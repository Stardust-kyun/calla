exec "source " . expand('<sfile>:p:h') . "/dim.vim"

let colors_name = "grim"

if &background == "light"
  highlight Constant       ctermfg=8
  highlight Identifier     ctermfg=0
  highlight PreProc        ctermfg=0 cterm=bold
  highlight Special        ctermfg=0
  highlight Statement      ctermfg=0 cterm=bold
  highlight Title          ctermfg=0 cterm=bold
  highlight Type           ctermfg=0
  highlight Underlined     cterm=underline ctermfg=0
else
  highlight Constant       ctermfg=7
  highlight Identifier     ctermfg=15
  highlight PreProc        ctermfg=15 cterm=bold
  highlight Special        ctermfg=15
  highlight Statement      ctermfg=15 cterm=bold
  highlight Title          ctermfg=15 cterm=bold
  highlight Type           ctermfg=15
  highlight Underlined     cterm=underline ctermfg=15
end
