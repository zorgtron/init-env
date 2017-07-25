set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "Andrew"

" Normal
hi Normal guifg=#FFFFFF guibg=#000000

" UI Chrome
hi Cursor       guifg=#FFFFFF guibg=#000000 gui=NONE
hi CursorLineNr guifg=#FFFFFF guibg=#000000 gui=NONE
hi LineNr       guifg=#FFFFFF guibg=#000000 gui=NONE
hi NonText                    guibg=#000000 gui=NONE
hi Search       guifg=#FFFFFF guibg=#000000 gui=NONE
hi ErrorMsg     guifg=#FFFFFF guibg=#000000 gui=NONE
hi StatusLine   guifg=#FFFFFF guibg=#000000 gui=NONE
hi StatusLineNC guifg=#FFFFFF guibg=#000000 gui=NONE

" Syntax Highlighting
hi Comment      guifg=#FFFFFF guibg=#000000 gui=NONE
hi Constant     guifg=#FFFFFF guibg=#000000 gui=NONE
hi Function     guifg=#FFFFFF guibg=#000000 gui=NONE
hi Identifier   guifg=#FFFFFF guibg=#000000 gui=NONE
hi Ignore       guifg=#FFFFFF guibg=#000000 gui=NONE
hi Keyword      guifg=#FFFFFF guibg=#000000 gui=NONE
hi Number       guifg=#FFFFFF guibg=#000000 gui=NONE
hi PreProc      guifg=#FFFFFF guibg=#000000 gui=NONE
hi Special      guifg=#FFFFFF guibg=#000000 gui=NONE
hi SpecialKey   guifg=#FFFFFF guibg=#000000 gui=NONE
hi Statement    guifg=#FFFFFF guibg=#000000 gui=NONE
hi String       guifg=#FFFFFF guibg=#000000 gui=NONE
hi Todo         guifg=#FFFFFF guibg=#000000 gui=NONE
hi Type         guifg=#FFFFFF guibg=#000000 gui=NONE
hi Underlined   guifg=#FFFFFF guibg=#000000 gui=NONE
