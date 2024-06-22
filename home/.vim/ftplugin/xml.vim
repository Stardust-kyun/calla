" Vim script file                                           vim600:fdm=marker:
" FileType:     XML
" Author:       Devin Weaver <suki (at) tritarget.com> 
" Maintainer:   Devin Weaver <suki (at) tritarget.com>
" Last Change:  Tue Apr 07 11:12:08 EDT 2009
" Version:      1.84
" Location:     http://www.vim.org/scripts/script.php?script_id=301
" Licence:      This program is free software; you can redistribute it
"               and/or modify it under the terms of the GNU General Public
"               License.  See http://www.gnu.org/copyleft/gpl.txt
" Credits:      Brad Phelan <bphelan (at) mathworks.co.uk> for completing
"                 tag matching and visual tag completion.
"               Ma, Xiangjiang <Xiangjiang.Ma (at) broadvision.com> for
"                 pointing out VIM 6.0 map <buffer> feature.
"               Luc Hermitte <hermitte (at) free.fr> for testing the self
"                 install documentation code and providing good bug fixes.
"               Guo-Peng Wen for the self install documentation code.
"               Shawn Boles <ickybots (at) gmail.com> for fixing the
"                 <Leader>x cancelation bug. 
"               Martijn van der Kwast <mvdkwast@gmx.net> for patching
"                 problems with multi-languages (XML and PHP).

" This script provides some convenience when editing XML (and some SGML)
" formated documents.

" Section: Documentation 
" ----------------------
"
" Documentation should be available by ":help xml-plugin" command, once the
" script has been copied in you .vim/plugin directory.
"
" You still can read the documentation at the end of this file. Locate it by
" searching the "xml-plugin" string (and set ft=help to have
" appropriate syntaxic coloration). 

" Note: If you used the 5.x version of this file (xmledit.vim) you'll need to
" comment out the section where you called it since it is no longer used in
" version 6.x. 

" TODO: Revamp ParseTag to pull appart a tag a rebuild it properly.
" a tag like: <  test  nowrap  testatt=foo   >
" should be fixed to: <test nowrap="nowrap" testatt="foo"></test>

"==============================================================================

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
" sboles, init these variables so vim doesn't complain on wrap cancel
let b:last_wrap_tag_used = ""
let b:last_wrap_atts_used = ""

" WrapTag -> Places an XML tag around a visual selection.            {{{1
" Brad Phelan: Wrap the argument in an XML tag
" Added nice GUI support to the dialogs. 
" Rewrote function to implement new algorythem that addresses several bugs.
if !exists("*s:WrapTag") 
function s:WrapTag(text)
    if (line(".") < line("'<"))
        let insert_cmd = "o"
    elseif (col(".") < col("'<"))
        let insert_cmd = "a"
    else
        let insert_cmd = "i"
    endif
    if strlen(a:text) > 10
        let input_text = strpart(a:text, 0, 10) . '...'
    else
        let input_text = a:text
    endif
    let wraptag = inputdialog('Tag to wrap "' . input_text . '" : ')
    if strlen(wraptag)==0
        if strlen(b:last_wrap_tag_used)==0
            undo
            return
        endif
        let wraptag = b:last_wrap_tag_used
        let atts = b:last_wrap_atts_used
    else
        let atts = inputdialog('Attributes in <' . wraptag . '> : ')
    endif
    if (visualmode() ==# 'V')
        let text = strpart(a:text,0,strlen(a:text)-1)
        if (insert_cmd ==# "o")
            let eol_cmd = ""
        else
            let eol_cmd = "\<Cr>"
        endif
    else
        let text = a:text
        let eol_cmd = ""
    endif
    if strlen(atts)==0
        let text = "<".wraptag.">".text."</".wraptag.">"
        let b:last_wrap_tag_used = wraptag
        let b:last_wrap_atts_used = ""
    else
        let text = "<".wraptag." ".atts.">".text."</".wraptag.">"
        let b:last_wrap_tag_used = wraptag
        let b:last_wrap_atts_used = atts
    endif
    execute "normal! ".insert_cmd.text.eol_cmd
endfunction
endif

" NewFileXML -> Inserts <?xml?> at top of new file.                  {{{1
if !exists("*s:NewFileXML")
function s:NewFileXML( )
    " Where is g:did_xhtmlcf_inits defined?
    if &filetype == 'docbk' || &filetype == 'xml' || (!exists ("g:did_xhtmlcf_inits") && exists ("g:xml_use_xhtml") && (&filetype == 'html' || &filetype == 'xhtml'))
        if append (0, '<?xml version="1.0"?>')
            normal! G
        endif
    endif
endfunction
endif


" Callback -> Checks for tag callbacks and executes them.            {{{1
if !exists("*s:Callback")
function s:Callback( xml_tag, isHtml )
    let text = 0
    if a:isHtml == 1 && exists ("*HtmlAttribCallback")
        let text = HtmlAttribCallback (a:xml_tag)
    elseif exists ("*XmlAttribCallback")
        let text = XmlAttribCallback (a:xml_tag)
    endif       
    if text != '0'
        execute "normal! i " . text ."\<Esc>l"
    endif
endfunction
endif


" IsParsableTag -> Check to see if the tag is a real tag.            {{{1
if !exists("*s:IsParsableTag")
function s:IsParsableTag( tag )
    " The "Should I parse?" flag.
    let parse = 1

    " make sure a:tag has a proper tag in it and is not a instruction or end tag.
    if a:tag !~ '^<[[:alnum:]_:\-].*>$'
        let parse = 0
    endif

    " make sure this tag isn't already closed.
    if strpart (a:tag, strlen (a:tag) - 2, 1) == '/'
        let parse = 0
    endif
    
    return parse
endfunction
endif


" ParseTag -> The major work hourse for tag completion.              {{{1
if !exists("*s:ParseTag")
function s:ParseTag( )
    " Save registers
    let old_reg_save = @"
    let old_save_x   = @x

    if (!exists("g:xml_no_auto_nesting") && strpart (getline ("."), col (".") - 2, 2) == '>>')
        let multi_line = 1
        execute "normal! \"xX"
    else
        let multi_line = 0
    endif

    let @" = ""
    execute "normal! \"xy%%"
    let ltag = @"
    if (&filetype == 'html' || &filetype == 'xhtml') && (!exists ("g:xml_no_html"))
        let html_mode = 1
        let ltag = substitute (ltag, '[^[:graph:]]\+', ' ', 'g')
        let ltag = substitute (ltag, '<\s*\([^[:alnum:]_:\-[:blank:]]\=\)\s*\([[:alnum:]_:\-]\+\)\>', '<\1\2', '')
    else
        let html_mode = 0
    endif

    if <SID>IsParsableTag (ltag)
        " find the break between tag name and atributes (or closing of tag)
        let index = matchend (ltag, '[[:alnum:]_:\-]\+')

        let tag_name = strpart (ltag, 1, index - 1)
        if strpart (ltag, index) =~ '[^/>[:blank:]]'
            let has_attrib = 1
        else
            let has_attrib = 0
        endif

        " That's (index - 1) + 2, 2 for the '</' and 1 for the extra character the
        " while includes (the '>' is ignored because <Esc> puts the curser on top
        " of the '>'
        let index = index + 2

        " print out the end tag and place the cursor back were it left off
        if html_mode && tag_name =~? '^\(img\|input\|param\|frame\|br\|hr\|meta\|link\|base\|area\)$'
            if has_attrib == 0
                call <SID>Callback (tag_name, html_mode)
            endif
            if exists ("g:xml_use_xhtml")
                execute "normal! i /\<Esc>l"
            endif
        else
            if multi_line
                " Can't use \<Tab> because that indents 'tabstop' not 'shiftwidth'
                " Also >> doesn't shift on an empty line hence the temporary char 'x'
                let com_save = &comments
                set comments-=n:>
                execute "normal! a\<Cr>\<Cr>\<Esc>kAx\<Esc>>>$\"xx"
                execute "set comments=" . substitute(com_save, " ", "\\\\ ", "g")
            else
                if has_attrib == 0
                    call <SID>Callback (tag_name, html_mode)
                endif
                if exists("g:xml_jump_string")
                    let index = index + strlen(g:xml_jump_string)
                    let jump_char = g:xml_jump_string
                    call <SID>InitEditFromJump()
                else
                    let jump_char = ""
                endif
                execute "normal! a</" . tag_name . ">" . jump_char . "\<Esc>" . index . "h"
            endif
        endif
    endif

    " restore registers
    let @" = old_reg_save
    let @x = old_save_x

    if multi_line
        startinsert!
    else
        execute "normal! l"
        startinsert
    endif
endfunction
endif


" ParseTag2 -> Experimental function to replace ParseTag             {{{1
"if !exists("*s:ParseTag2")
"function s:ParseTag2( )
    " My thought is to pull the tag out and reformat it to a normalized tag
    " and put it back.
"endfunction
"endif


" BuildTagName -> Grabs the tag's name for tag matching.             {{{1
if !exists("*s:BuildTagName")
function s:BuildTagName( )
  "First check to see if we Are allready on the end of the tag. The / search
  "forwards command will jump to the next tag otherwise

  " Store contents of register x in a variable
  let b:xreg = @x 

  exec "normal! v\"xy"
  if @x=='>'
     " Don't do anything
  else
     exec "normal! />/\<Cr>"
  endif

  " Now we head back to the < to reach the beginning.
  exec "normal! ?<?\<Cr>"

  " Capture the tag (a > will be catured by the /$/ match)
  exec "normal! v/\\s\\|$/\<Cr>\"xy"

  " We need to strip off any junk at the end.
  let @x=strpart(@x, 0, match(@x, "[[:blank:]>\<C-J>]"))

  "remove <, >
  let @x=substitute(@x,'^<\|>$','','')

  " remove spaces.
  let @x=substitute(@x,'/\s*','/', '')
  let @x=substitute(@x,'^\s*','', '')

  " Swap @x and b:xreg
  let temp = @x
  let @x = b:xreg
  let b:xreg = temp
endfunction
endif

" TagMatch1 -> First step in tag matching.                           {{{1 
" Brad Phelan: First step in tag matching.
if !exists("*s:TagMatch1")
function s:TagMatch1()
  " Save registers
  let old_reg_save = @"

  "Drop a marker here just in case we have a mismatched tag and
  "wish to return (:mark looses column position)
  normal! mz

  call <SID>BuildTagName()

  "Check to see if it is an end tag. If it is place a 1 in endtag
  if match(b:xreg, '^/')==-1
    let endtag = 0
  else
    let endtag = 1  
  endif

 " Extract the tag from the whole tag block
 " eg if the block =
 "   tag attrib1=blah attrib2=blah
 " we will end up with 
 "   tag
 " with no trailing or leading spaces
 let b:xreg=substitute(b:xreg,'^/','','g')

 " Make sure the tag is valid.
 " Malformed tags could be <?xml ?>, <![CDATA[]]>, etc.
 if match(b:xreg,'^[[:alnum:]_:\-]') != -1
     " Pass the tag to the matching 
     " routine
     call <SID>TagMatch2(b:xreg, endtag)
 endif
 " Restore registers
 let @" = old_reg_save
endfunction
endif


" TagMatch2 -> Second step in tag matching.                          {{{1
" Brad Phelan: Second step in tag matching.
if !exists("*s:TagMatch2")
function s:TagMatch2(tag,endtag)
  let match_type=''

  " Build the pattern for searching for XML tags based
  " on the 'tag' type passed into the function.
  " Note we search forwards for end tags and
  " backwards for start tags
  if a:endtag==0
     "let nextMatch='normal /\(<\s*' . a:tag . '\(\s\+.\{-}\)*>\)\|\(<\/' . a:tag . '\s*>\)'
     let match_type = '/'
  else
     "let nextMatch='normal ?\(<\s*' . a:tag . '\(\s\+.\{-}\)*>\)\|\(<\/' . a:tag . '\s*>\)'
     let match_type = '?'
  endif

  if a:endtag==0
     let stk = 1 
  else
     let stk = 1
  end

 " wrapscan must be turned on. We'll recored the value and reset it afterward.
 " We have it on because if we don't we'll get a nasty error if the search hits
 " BOF or EOF.
 let wrapval = &wrapscan
 let &wrapscan = 1

  "Get the current location of the cursor so we can 
  "detect if we wrap on ourselves
  let lpos = line(".")
  let cpos = col(".")

  if a:endtag==0
      " If we are trying to find a start tag
      " then decrement when we find a start tag
      let iter = 1
  else
      " If we are trying to find an end tag
      " then increment when we find a start tag
      let iter = -1
  endif

  "Loop until stk == 0. 
  while 1 
     " exec search.
     " Make sure to avoid />$/ as well as /\s$/ and /$/.
     exec "normal! " . match_type . '<\s*\/*\s*' . a:tag . '\([[:blank:]>]\|$\)' . "\<Cr>"

     " Check to see if our match makes sence.
     if a:endtag == 0
         if line(".") < lpos
             call <SID>MisMatchedTag (0, a:tag)
             break
         elseif line(".") == lpos && col(".") <= cpos
             call <SID>MisMatchedTag (1, a:tag)
             break
         endif
     else
         if line(".") > lpos
             call <SID>MisMatchedTag (2, '/'.a:tag)
             break
         elseif line(".") == lpos && col(".") >= cpos
             call <SID>MisMatchedTag (3, '/'.a:tag)
             break
         endif
     endif

     call <SID>BuildTagName()

     if match(b:xreg,'^/')==-1
        " Found start tag
        let stk = stk + iter 
     else
        " Found end tag
        let stk = stk - iter
     endif

     if stk == 0
        break
     endif    
  endwhile

  let &wrapscan = wrapval
endfunction
endif

" MisMatchedTag -> What to do if a tag is mismatched.                {{{1
if !exists("*s:MisMatchedTag")
function s:MisMatchedTag( id, tag )
    "Jump back to our formor spot
    normal! `z
    normal zz
    echohl WarningMsg
    " For debugging
    "echo "Mismatched tag " . a:id . ": <" . a:tag . ">"
    " For release
    echo "Mismatched tag <" . a:tag . ">"
    echohl None
endfunction
endif

" DeleteTag -> Deletes surrounding tags from cursor.                 {{{1
" Modifies mark z
if !exists("*s:DeleteTag")
function s:DeleteTag( )
    if strpart (getline ("."), col (".") - 1, 1) == "<"
        normal! l
    endif
    if search ("<[^\/]", "bW") == 0
        return
    endif
    normal! mz
    normal \5
    normal! d%`zd%
endfunction
endif

" VisualTag -> Selects Tag body in a visual selection.                {{{1
" Modifies mark z
if !exists("*s:VisualTag")
function s:VisualTag( ) 
    if strpart (getline ("."), col (".") - 1, 1) == "<"
        normal! l
    endif
    if search ("<[^\/]", "bW") == 0
        return
    endif
    normal! mz
    normal \5
    normal! %
    exe "normal! " . visualmode()
    normal! `z
endfunction
endif
 
" InsertGt -> close tags only if the cursor is in a HTML or XML context {{{1
" Else continue editing
if !exists("*s:InsertGt")
function s:InsertGt( )
  let save_matchpairs = &matchpairs
  set matchpairs-=<:>
  execute "normal! a>"
  execute "set matchpairs=" . save_matchpairs
  " When the current char is text within a tag it will not proccess as a
  " syntax'ed element and return nothing below. Since the multi line wrap
  " feture relies on using the '>' char as text within a tag we must use the
  " char prior to establish if it is valid html/xml
  if (getline('.')[col('.') - 1] == '>')
    let char_syn=synIDattr(synID(line("."), col(".") - 1, 1), "name")
  endif
  if -1 == match(char_syn, "xmlProcessing") && (0 == match(char_syn, 'html') || 0 == match(char_syn, 'xml') || 0 == match(char_syn, 'docbk'))
    call <SID>ParseTag()
  else
    if col(".") == col("$") - 1
      startinsert!
    else 
      execute "normal! l"
      startinsert
    endif
  endif
endfunction
endif

" InitEditFromJump -> Set some needed autocommands and syntax highlights for EditFromJump. {{{1
if !exists("*s:InitEditFromJump")
function s:InitEditFromJump( )
    " Add a syntax highlight for the xml_jump_string.
    execute "syntax match Error /\\V" . g:xml_jump_string . "/"
endfunction
endif

" ClearJumpMarks -> Clean out extranious left over xml_jump_string garbage. {{{1
if !exists("*s:ClearJumpMarks")
function s:ClearJumpMarks( )
    if exists("g:xml_jump_string")
       if g:xml_jump_string != ""
           execute ":%s/" . g:xml_jump_string . "//ge"
       endif
    endif
endfunction
endif

" EditFromJump -> Jump to the end of the tag and continue editing. {{{1
" g:xml_jump_string must be set.
if !exists("*s:EditFromJump")
function s:EditFromJump( )
    if exists("g:xml_jump_string")
        if g:xml_jump_string != ""
            let foo = search(g:xml_jump_string, 'csW') " Moves cursor by default
            execute "normal! " . strlen(g:xml_jump_string) . "x"
            if col(".") == col("$") - 1
                startinsert!
            else
                startinsert
            endif
        endif
    else
        echohl WarningMsg
        echo "Function disabled. xml_jump_string not defined."
        echohl None
    endif
endfunction
endif

" Section: Doc installation {{{1
" Function: s:XmlInstallDocumentation(full_name, revision)              {{{2
"   Install help documentation.
" Arguments:
"   full_name: Full name of this vim plugin script, including path name.
"   revision:  Revision of the vim script. #version# mark in the document file
"              will be replaced with this string with 'v' prefix.
" Return:
"   1 if new document installed, 0 otherwise.
" Note: Cleaned and generalized by guo-peng Wen
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

function! s:XmlInstallDocumentation(full_name, revision)
    " Name of the document path based on the system we use:
    if (has("unix"))
        " On UNIX like system, using forward slash:
        let l:slash_char = '/'
        let l:mkdir_cmd  = ':silent !mkdir -p '
    else
        " On M$ system, use backslash. Also mkdir syntax is different.
        " This should only work on W2K and up.
        let l:slash_char = '\'
        let l:mkdir_cmd  = ':silent !mkdir '
    endif

    let l:doc_path = l:slash_char . 'doc'
    "let l:doc_home = l:slash_char . '.vim' . l:slash_char . 'doc'

    " Figure out document path based on full name of this script:
    let l:vim_plugin_path = fnamemodify(a:full_name, ':h')
    "let l:vim_doc_path   = fnamemodify(a:full_name, ':h:h') . l:doc_path
    let l:vim_doc_path    = matchstr(l:vim_plugin_path, 
            \ '.\{-}\ze\%(\%(ft\)\=plugin\|macros\)') . l:doc_path
    if (!(filewritable(l:vim_doc_path) == 2))
        echomsg "Doc path: " . l:vim_doc_path
        execute l:mkdir_cmd . l:vim_doc_path
        if (!(filewritable(l:vim_doc_path) == 2))
            " Try a default configuration in user home:
            "let l:vim_doc_path = expand("~") . l:doc_home
            let l:vim_doc_path = matchstr(&rtp,
                  \ escape($HOME, '\') .'[/\\]\%(\.vim\|vimfiles\)')
            if (!(filewritable(l:vim_doc_path) == 2))
                execute l:mkdir_cmd . l:vim_doc_path
                if (!(filewritable(l:vim_doc_path) == 2))
                    " Put a warning:
                    echomsg "Unable to open documentation directory"
                    echomsg " type :help add-local-help for more informations."
                    return 0
                endif
            endif
        endif
    endif

    " Exit if we have problem to access the document directory:
    if (!isdirectory(l:vim_plugin_path)
        \ || !isdirectory(l:vim_doc_path)
        \ || filewritable(l:vim_doc_path) != 2)
        return 0
    endif

    " Full name of script and documentation file:
    let l:script_name = 'xml.vim'
    let l:doc_name    = 'xml-plugin.txt'
    let l:plugin_file = l:vim_plugin_path . l:slash_char . l:script_name
    let l:doc_file    = l:vim_doc_path    . l:slash_char . l:doc_name

    " Bail out if document file is still up to date:
    if (filereadable(l:doc_file)  &&
        \ getftime(l:plugin_file) < getftime(l:doc_file))
        return 0
    endif

    " Prepare window position restoring command:
    if (strlen(@%))
        let l:go_back = 'b ' . bufnr("%")
    else
        let l:go_back = 'enew!'
    endif

    " Create a new buffer & read in the plugin file (me):
    setl nomodeline
    exe 'enew!'
    exe 'r ' . l:plugin_file

    setl modeline
    let l:buf = bufnr("%")
    setl noswapfile modifiable

    norm zR
    norm gg

    " Delete from first line to a line starts with
    " === START_DOC
    1,/^=\{3,}\s\+START_DOC\C/ d

    " Delete from a line starts with
    " === END_DOC
    " to the end of the documents:
    /^=\{3,}\s\+END_DOC\C/,$ d

    " Remove fold marks:
    % s/{\{3}[1-9]/    /

    " Add modeline for help doc: the modeline string is mangled intentionally
    " to avoid it be recognized by VIM:
    call append(line('$'), '')
    call append(line('$'), ' v' . 'im:tw=78:ts=8:ft=help:norl:')

    " Replace revision:
    exe "normal :1,5s/#version#/ v" . a:revision . "/\<CR>"

    " Save the help document:
    exe 'w! ' . l:doc_file
    exe l:go_back
    exe 'bw ' . l:buf

    " Build help tags:
    exe 'helptags ' . l:vim_doc_path

    return 1
endfunction
" }}}2

let s:script_lines = readfile(expand("<sfile>"), "", 6)
let s:revision=
      \ substitute(s:script_lines[5], '^" Version:\s*\|\s*$', '', '')
"      \ substitute("$Revision: 83 $",'\$\S*: \([.0-9]\+\) \$','\1','')
silent! let s:install_status =
    \ s:XmlInstallDocumentation(expand('<sfile>:p'), s:revision)
if (s:install_status == 1)
    echom expand("<sfile>:t:r") . '-plugin v' . s:revision .
        \ ': Help-documentation installed.'
endif


" Mappings and Settings.                                             {{{1
" This makes the '%' jump between the start and end of a single tag.
setlocal matchpairs+=<:>
setlocal commentstring=<!--%s-->

" Have this as an escape incase you want a literal '>' not to run the
" ParseTag function.
if !exists("g:xml_tag_completion_map")
    inoremap <buffer> <LocalLeader>. >
    inoremap <buffer> <LocalLeader>> >
endif

" Jump between the beggining and end tags.
nnoremap <buffer> <LocalLeader>5 :call <SID>TagMatch1()<Cr>
nnoremap <buffer> <LocalLeader>% :call <SID>TagMatch1()<Cr>
vnoremap <buffer> <LocalLeader>5 <Esc>:call <SID>VisualTag()<Cr>
vnoremap <buffer> <LocalLeader>% <Esc>:call <SID>VisualTag()<Cr>

" Wrap selection in XML tag
vnoremap <buffer> <LocalLeader>x "xx:call <SID>WrapTag(@x)<Cr>
nnoremap <buffer> <LocalLeader>d :call <SID>DeleteTag()<Cr>

" Parse the tag after pressing the close '>'.
if !exists("g:xml_tag_completion_map")
    " inoremap <buffer> > ><Esc>:call <SID>ParseTag()<Cr>
    inoremap <buffer> > <Esc>:call <SID>InsertGt()<Cr>
else
    execute "inoremap <buffer> " . g:xml_tag_completion_map . " <Esc>:call <SID>InsertGt()<Cr>"
endif

nnoremap <buffer> <LocalLeader><Space> :call <SID>EditFromJump()<Cr>
inoremap <buffer> <LocalLeader><Space> <Esc>:call <SID>EditFromJump()<Cr>
" Clear out all left over xml_jump_string garbage
nnoremap <buffer> <LocalLeader>w :call <SID>ClearJumpMarks()<Cr>
" The syntax files clear out any predefined syntax definitions. Recreate
" this when ever a xml_jump_string is created. (in ParseTag)

augroup xml
    au!
    au BufNewFile * call <SID>NewFileXML()
    " Remove left over garbage from xml_jump_string on file save.
    au BufWritePre <buffer> call <SID>ClearJumpMarks()
augroup END
"}}}1
finish

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section: Documentation content                                          {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
=== START_DOC
*xml-plugin.txt*  Help edit XML and SGML documents.                  #version#

                                   XML Edit {{{2 ~

A filetype plugin to help edit XML and SGML documents.

This script provides some convenience when editing XML (and some SGML
including HTML) formated documents. It allows you to jump to the beginning
or end of the tag block your cursor is in. '%' will jump between '<' and '>'
within the tag your cursor is in. When in insert mode and you finish a tag
(pressing '>') the tag will be completed. If you press '>' twice it will
complete the tag and place the cursor in the middle of the tags on it's own
line (helps with nested tags).

Usage: Place this file into your ftplugin directory. To add html support
Sym-link or copy this file to html.vim in your ftplugin directory. To activte
the script place 'filetype plugin on' in your |.vimrc| file. See |ftplugins|
for more information on this topic.

If the file edited is of type "html" and "xml_use_html" is  defined then the
following tags will not auto complete:
<img>, <input>, <param>, <frame>, <br>, <hr>, <meta>, <link>, <base>, <area>

If the file edited is of type 'html' and 'xml_use_xhtml' is defined the above
tags will autocomplete the xml closing staying xhtml compatable.
ex. <hr> becomes <hr /> (see |xml-plugin-settings|)

NOTE: If you used the VIM 5.x version of this file (xmledit.vim) you'll need
to comment out the section where you called it. It is no longer used in the
VIM 6.x version. 

Known Bugs {{{2 ~

- This script will modify registers ". and "x; register "" will be restored.
- < & > marks inside of a CDATA section are interpreted as actual XML tags
  even if unmatched.
- Although the script can handle leading spaces such as < tag></ tag> it is
  illegal XML syntax and considered very bad form.
- Placing a literal `>' in an attribute value will auto complete dispite that
  the start tag isn't finished. This is poor XML anyway you should use
  &gt; instead.
- The matching algorithm can handle illegal tag characters where as the tag
  completion algorithm can not.

------------------------------------------------------------------------------
                                                         *xml-plugin-mappings*
Mappings {{{2 ~

<LocalLeader> is a setting in VIM that depicts a prefix for scripts and
plugins to use. By default this is the backslash key `\'. See |mapleader|
for details.

<LocalLeader><Space>
        Normal or Insert - Continue editing after the ending tag. This
        option requires xml_jump_string to be set to function. When a tag
        is completed it will append the xml_jump_string. Once this mapping
        is ran it will delete the next xml_jump_string pattern to the right
        of the curser and delete it leaving you in insert mode to continue
        editing.

<LocalLeader>w
        Normal - Will clear the entire file of left over xml_jump_string garbage.
        * This will also happen automatically when you save the file. *

<LocalLeader>x
        Visual - Place a custom XML tag to suround the selected text. You
        need to have selected text in visual mode before you can use this
        mapping. See |visual-mode| for details.

<LocalLeader>.   or      <LocalLeader>>
        Insert - Place a literal '>' without parsing tag.

<LocalLeader>5   or      <LocalLeader>%
        Normal or Visual - Jump to the begining or end tag.

<LocalLeader>d
        Normal - Deletes the surrounding tags from the cursor. >
            <tag1>outter <tag2>inner text</tag2> text</tag1>
                    ^
<       Turns to: >
            outter <tag2>inner text</tag2> text
            ^
<

------------------------------------------------------------------------------
                                                         *xml-plugin-settings*
Options {{{2 ~

(All options must be placed in your |.vimrc| prior to the |ftplugin|
command.)

xml_tag_completion_map
        Use this setting to change the default mapping to auto complete a
        tag. By default typing a literal `>' will cause the tag your editing
        to auto complete; pressing twice will auto nest the tag. By using
        this setting the `>' will be a literal `>' and you must use the new
        mapping to perform auto completion and auto nesting. For example if
        you wanted Control-L to perform auto completion inmstead of typing a
        `>' place the following into your .vimrc: >
            let xml_tag_completion_map = "<C-l>"
<
xml_no_auto_nesting
        This turns off the auto nesting feature. After a completion is made
        and another `>' is typed xml-edit automatically will break the tag
        accross multiple lines and indent the curser to make creating nested
        tqags easier. This feature turns it off. Enter the following in your
        .vimrc: >
            let xml_no_auto_nesting = 1
<
xml_use_xhtml
        When editing HTML this will auto close the short tags to make valid
        XML like <hr /> and <br />. Enter the following in your vimrc to
        turn this option on: >
            let xml_use_xhtml = 1
<
xml_no_html
        This turns off the support for HTML specific tags. Place this in your
        .vimrc: >
            let xml_no_html = 1
<
xml_jump_string
        This turns off the support for continuing edits after an ending tag.
        xml_jump_string can be any string how ever a simple character will
        suffice. Pick a character or small string that is unique and will
        not interfer with your normal editing. See the <LocalLeader>Space
        mapping for more.
        .vimrc: >
            let xml_jump_string = "`"
<
------------------------------------------------------------------------------
                                                        *xml-plugin-callbacks*
Callback Functions {{{2 ~

A callback function is a function used to customize features on a per tag
basis. For example say you wish to have a default set of attributs when you
type an empty tag like this:
    You type: <tag>
    You get:  <tag default="attributes"></tag>

This is for any script programmers who wish to add xml-plugin support to
there own filetype plugins.

Callback functions recive one attribute variable which is the tag name. The
all must return either a string or the number zero. If it returns a string
the plugin will place the string in the proper location. If it is a zero the
plugin will ignore and continue as if no callback existed.

The following are implemented callback functions:

HtmlAttribCallback
        This is used to add default attributes to html tag. It is intended
        for HTML files only.

XmlAttribCallback
        This is a generic callback for xml tags intended to add attributes.

                                                             *xml-plugin-html*
Callback Example {{{2 ~

The following is an example of using XmlAttribCallback in your .vimrc
>
        function XmlAttribCallback (xml_tag)
            if a:xml_tag ==? "my-xml-tag"
                return "attributes=\"my xml attributes\""
            else
                return 0
            endif
        endfunction
<
The following is a sample html.vim file type plugin you could use:
>
  " Vim script file                                       vim600:fdm=marker:
  " FileType:   HTML
  " Maintainer: Devin Weaver <vim (at) tritarget.com>
  " Location:   http://www.vim.org/scripts/script.php?script_id=301

  " This is a wrapper script to add extra html support to xml documents.
  " Original script can be seen in xml-plugin documentation.

  " Only do this when not done yet for this buffer
  if exists("b:did_ftplugin")
    finish
  endif
  " Don't set 'b:did_ftplugin = 1' because that is xml.vim's responsability.

  let b:html_mode = 1

  if !exists("*HtmlAttribCallback")
  function HtmlAttribCallback( xml_tag )
      if a:xml_tag ==? "table"
          return "cellpadding=\"0\" cellspacing=\"0\" border=\"0\""
      elseif a:xml_tag ==? "link"
          return "href=\"/site.css\" rel=\"StyleSheet\" type=\"text/css\""
      elseif a:xml_tag ==? "body"
          return "bgcolor=\"white\""
      elseif a:xml_tag ==? "frame"
          return "name=\"NAME\" src=\"/\" scrolling=\"auto\" noresize"
      elseif a:xml_tag ==? "frameset"
          return "rows=\"0,*\" cols=\"*,0\" border=\"0\""
      elseif a:xml_tag ==? "img"
          return "src=\"\" width=\"0\" height=\"0\" border=\"0\" alt=\"\""
      elseif a:xml_tag ==? "a"
          if has("browse")
              " Look up a file to fill the href. Used in local relative file
              " links. typeing your own href before closing the tag with `>'
              " will override this.
              let cwd = getcwd()
              let cwd = substitute (cwd, "\\", "/", "g")
              let href = browse (0, "Link to href...", getcwd(), "")
              let href = substitute (href, cwd . "/", "", "")
              let href = substitute (href, " ", "%20", "g")
          else
              let href = ""
          endif
          return "href=\"" . href . "\""
      else
          return 0
      endif
  endfunction
  endif

  " On to loading xml.vim
  runtime ftplugin/xml.vim
<
=== END_DOC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim: set tabstop=8 shiftwidth=4 softtabstop=4 smartindent
" vim600: set foldmethod=marker smarttab fileencoding=iso-8859-15 
