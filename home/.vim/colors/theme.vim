" Vim color file

set background=dark
hi clear

if exists("syntax_on")
	syntax reset
endif

let g:colors_name = "theme"

" hi Normal		 	
hi NonText		ctermfg=12 	cterm=bold
hi comment		ctermfg=14 	cterm=bold
hi constant		ctermfg=13 	cterm=bold
hi identifier		ctermfg=14 	cterm=bold
hi statement		ctermfg=11 	cterm=bold
hi preproc		ctermfg=12 	cterm=bold
hi type			ctermfg=10 	cterm=bold
hi special		ctermfg=9 	cterm=bold
hi ErrorMsg	 	ctermbg=9	cterm=bold
hi WarningMsg		ctermfg=9 	cterm=bold
hi Error	 	ctermbg=9	cterm=bold
hi Todo			ctermfg=0 	ctermbg=11
" hi Cursor		 
hi Search		ctermfg=0	ctermbg=11
" hi IncSearch	 	
hi LineNr		ctermfg=11 	cterm=bold
hi ShowMarksHL		ctermfg=14 	ctermbg=12	cterm=bold
" hi StatusLineNC	 	
hi StatusLine		cterm=bold,reverse
" hi label		 	
" hi operator	 	
hi SpecialKey		ctermfg=12 	cterm=bold
hi Directory		ctermfg=14 	cterm=bold
hi MoreMsg		ctermfg=10 	cterm=bold
hi CursorLineNr		ctermfg=11 	cterm=bold,underline
hi Question		ctermfg=10 	cterm=bold
hi Title		ctermfg=13 	cterm=bold
hi WildMenu		ctermfg=0 	ctermbg=11
hi SignColumn		ctermfg=14 	ctermbg=0	cterm=bold
hi Pmenu		ctermfg=0 	ctermbg=13
hi TabLine	 	ctermbg=0	cterm=bold,underline
hi CursorColumn	 	ctermbg=0
hi CursorLine		cterm=underline
hi ColorColumn	 	ctermbg=9
hi StatusLineTerm	ctermfg=0 	ctermbg=10
hi StatusLineTermNC	ctermfg=0 	ctermbg=10
" hi lCursor		 	
hi MatchParen	 	ctermbg=14
hi ToolbarLine	 	ctermbg=0
hi ToolbarButton	ctermfg=0 	ctermbg=15
hi Underlined		ctermfg=12 	cterm=bold,underline
hi Ignore		ctermfg=0 	
hi Conceal		ctermbg=0

hi clear Visual
hi Visual		cterm=reverse
hi DiffChange	 	ctermbg=13
hi DiffText	 	ctermbg=9	cterm=bold
hi DiffAdd		ctermbg=12
hi DiffDelete		ctermfg=12 	ctermbg=14	cterm=bold
hi Folded		ctermfg=14 	ctermbg=0	cterm=bold
hi FoldColumn		ctermfg=14 	ctermbg=0	cterm=bold
" hi cIf0		 	
" hi diffOnly	 	
