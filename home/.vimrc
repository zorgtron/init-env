" Install Plugins ######################################################################################################

call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'elzr/vim-json'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'jlanzarotta/bufexplorer'
Plug 'kchmck/vim-coffee-script'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'statianzo/vim-jade'

call plug#end()

" Execute Basic Setup Commands #########################################################################################

set background=dark
colorscheme golden
" abra alduin badwolf Benokai birds-of-paradise black-angus brogrammer bvemu cabin camo chlordane coffee corporation
" dark-robin feral golden greens kellys liquidcarbon night_vision obsidian solarized
"
filetype plugin indent on
hi ColorColumn ctermbg=8
syntax on

" Configure Settings ###################################################################################################

set autoindent
set autowrite
set autowriteall
set backspace=indent,eol,start
set cmdheight=2
set colorcolumn=120
set cursorline
set expandtab
set hlsearch
set incsearch
set laststatus=2
set modelines=2
set nofoldenable
set nowrap
set number
set path=**
set ruler
set scrolloff=5
set shiftwidth=4
set showbreak="+++>"
set showcmd
set showmatch
set smarttab
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set t_Co=256
set tabstop=4
set textwidth=0
set virtualedit=block
set visualbell
set wildignore+=node_modules,log,build,dist
set wildmode=longest,list

if executable('ag')
    set grepprg=ag\ --vimgrep\ -p\ .agignore
    set grepformat=%f:%l:%c:%m
endif

" Configure Plugins ####################################################################################################

" ctrlpvim/ctrlp.vim
let g:ctrlp_working_path_mode = 0
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif

" elzr/vim-json
let g:vim_json_syntax_conceal = 0

" godlygeek/tabular
nmap == :Tabularize /=<CR>
nmap =: :Tabularize /[^:]*:<CR>
nmap =or :Tabularize /or<CR>

" nathanaelkane/vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 0 " :IndentGuidesToggle

" Key Mappings #########################################################################################################

map <F7> :cp<CR>
map <F8> :copen<CR>
map <F9> :cn<CR>
