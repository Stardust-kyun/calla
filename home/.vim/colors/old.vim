" Vim color file
" Old theme to be used with 'set termguicolors'

set background=dark
hi clear

if exists("syntax_on")
	syntax reset
endif

let g:colors_name = "old"

let bg = "#19191e"
let fg = "#9999a8"
let bl = "#2b2b33"
let wh = "#9999a8"
let r  = "#825a5a"
let g  = "#5a825a"
let y  = "#968264"
let b  = "#505a82"
let m  = "#735a87"
let c  = "#5a7387"

exe 'hi Normal		guifg=' . fg 	' guibg=' . bg
exe 'hi NonText		guifg=' . b 	' guibg=' . bg	' cterm=bold'
exe 'hi comment		guifg=' . c 	' guibg=' . bg	' cterm=bold'
exe 'hi constant	guifg=' . m 	' guibg=' . bg	' cterm=bold'
exe 'hi identifier	guifg=' . c 	' guibg=' . bg	' cterm=bold'
exe 'hi statement	guifg=' . y 	' guibg=' . bg	' cterm=bold'
exe 'hi preproc		guifg=' . b 	' guibg=' . bg	' cterm=bold'
exe 'hi type		guifg=' . g 	' guibg=' . bg	' cterm=bold'
exe 'hi special		guifg=' . r 	' guibg=' . bg	' cterm=bold'
exe 'hi ErrorMsg	guifg=' . fg 	' guibg=' . r	' cterm=bold'
exe 'hi WarningMsg	guifg=' . r 	' guibg=' . bg	' cterm=bold'
exe 'hi Error		guifg=' . fg 	' guibg=' . r	' cterm=bold'
exe 'hi Todo		guifg=' . bl 	' guibg=' . y
exe 'hi Cursor		guifg=' . fg 	' guibg=' . bg
exe 'hi Search		guifg=' . bl	' guibg=' . y
exe 'hi IncSearch	guifg=' . fg 	' guibg=' . bg
exe 'hi LineNr		guifg=' . y 	' guibg=' . bg	' cterm=bold'
exe 'hi ShowMarksHL	guifg=' . c 	' guibg=' . b	' cterm=bold'
exe 'hi StatusLineNC	guifg=' . fg 	' guibg=' . bg
exe 'hi StatusLine	guifg=' . bg 	' guibg=' . fg	' cterm=bold'
exe 'hi label		guifg=' . fg 	' guibg=' . bg
exe 'hi operator	guifg=' . fg 	' guibg=' . bg
exe 'hi SpecialKey	guifg=' . b 	' guibg=' . bg	' cterm=bold'
exe 'hi Directory	guifg=' . c 	' guibg=' . bg	' cterm=bold'
exe 'hi MoreMsg		guifg=' . g 	' guibg=' . bg	' cterm=bold'
exe 'hi CursorLineNr	guifg=' . y 	' guibg=' . bg	' cterm=bold,underline'
exe 'hi Question	guifg=' . g 	' guibg=' . bg	' cterm=bold'
exe 'hi Title		guifg=' . m 	' guibg=' . bg	' cterm=bold'
exe 'hi WildMenu	guifg=' . bl 	' guibg=' . y
exe 'hi SignColumn	guifg=' . c 	' guibg=' . bl	' cterm=bold'
exe 'hi Pmenu		guifg=' . bl 	' guibg=' . m
exe 'hi TabLine		guifg=' . fg 	' guibg=' . bl	' cterm=bold,underline'
exe 'hi CursorColumn	guifg=' . fg 	' guibg=' . bl
exe 'hi CursorLine	guifg=' . fg 	' guibg=' . bg	' cterm=underline'
exe 'hi ColorColumn	guifg=' . fg 	' guibg=' . r
exe 'hi StatusLineTerm	guifg=' . bl 	' guibg=' . g
exe 'hi StatusLineTermNC	guifg=' . bl 	' guibg=' . g
exe 'hi lCursor		guifg=' . fg 	' guibg=' . bg
exe 'hi MatchParen	guifg=' . fg 	' guibg=' . c
exe 'hi ToolbarLine	guifg=' . fg 	' guibg=' . bl
exe 'hi ToolbarButton	guifg=' . bl 	' guibg=' . fg
exe 'hi Underlined	guifg=' . b 	' guibg=' . bg	' cterm=bold,underline'
exe 'hi Ignore		guifg=' . bl 	' guibg=' . bg
exe 'hi Conceal		guifg=' . fg 	' guibg=' . bl

hi clear Visual
exe 'hi Visual		guifg=' . bg 	' guibg=' . fg
exe 'hi DiffChange	guifg=' . fg 	' guibg=' . m
exe 'hi DiffText	guifg=' . fg 	' guibg=' . r	' cterm=bold'
exe 'hi DiffAdd		guifg=' . fg 	' guibg=' . b
exe 'hi DiffDelete	guifg=' . b 	' guibg=' . c	' cterm=bold'
exe 'hi Folded		guifg=' . c 	' guibg=' . bl	' cterm=bold'
exe 'hi FoldColumn	guifg=' . c 	' guibg=' . bl	' cterm=bold'
exe 'hi cIf0		guifg=' . fg 	' guibg=' . bg
exe 'hi diffOnly	guifg=' . fg 	' guibg=' . bg
