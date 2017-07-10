" Install Plugins ######################################################################################################

call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'elzr/vim-json'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'kchmck/vim-coffee-script'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdtree'

call plug#end()

" Execute Basic Setup Commands #########################################################################################

:colorscheme obsidian
:filetype plugin indent on
:hi ColorColumn ctermbg=8
:syntax on

" Configure Settings ###################################################################################################

:set autoindent
:set autowrite
:set autowriteall
:set background=dark
:set backspace=indent,eol,start
:set cmdheight=2
:set colorcolumn=120
:set expandtab
:set hlsearch
:set incsearch
:set laststatus=2
:set modelines=2
:set number
:set path=**
:set ruler
:set scrolloff=5
:set shiftwidth=4
:set showbreak="+++>"
:set showcmd
:set showmatch
:set smarttab
:set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
:set tabstop=4
:set textwidth=0
:set virtualedit=block
:set visualbell
:set wildmode=longest,list
:set nowrap

" Configure Plugins ####################################################################################################

:let g:vim_json_syntax_conceal = 0
:let g:indent_guides_enable_on_vim_startup = 0 " :IndentGuidesToggle

