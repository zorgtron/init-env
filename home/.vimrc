" Install Plugins ######################################################################################################

call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'digitaltoad/vim-pug'
Plug 'elzr/vim-json'
Plug 'flazz/vim-colorschemes'
Plug 'gisraptor/vim-lilypond-integrator'
Plug 'godlygeek/tabular'
Plug 'jlanzarotta/bufexplorer'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'skammer/vim-css-color'
Plug 'statianzo/vim-jade'
Plug 'tpope/vim-fugitive'
Plug 'vim-syntastic/syntastic'

call plug#end()

" Execute Basic Setup Commands #########################################################################################

set background=dark
colorscheme zmrok
" abra alduin badwolf Benokai birds-of-paradise black-angus brogrammer bvemu cabin camo chlordane coffee corporation
" dark-robin feral golden greens kellys liquidcarbon night_vision obsidian solarized zmrok
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
set diffopt=filler,vertical
set expandtab
set nohlsearch
set incsearch
set laststatus=2
set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵
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
set statusline=%<%f\ %h%m%r%#warningmsg#%{SyntasticStatuslineFlag()}%*%=%-14.(%l,%c%V%)\ %P
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

autocmd BufWritePre * %s/\s\+$//e

" Configure Plugins ####################################################################################################

" ctrlpvim/ctrlp.vim
let g:ctrlp_working_path_mode = 0
let g:ctrlp_regexp = 0
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
nmap =, :Tabularize /[^,]*:<CR>

" nathanaelkane/vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 0 " :IndentGuidesToggle

" vim-syntastic/syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Key Mappings #########################################################################################################

map <F1>  :NERDTreeToggle<CR>
map <F2>  :NERDTreeFind<CR>
map <F3>  :'a,.!sort<CR>
map <F4>  :IndentGuidesToggle<CR>
map <F5>  :e<CR>
map <F6>  :set hlsearch!<CR>
map <F7>  :cp<CR>
map <F8>  :copen<CR>
map <F9>  :cn<CR>
map <F10> :tselect<CR>
map <F11> :!ctags -R src test<CR>

" Local Overrides ######################################################################################################

if !empty(glob("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

" File-Type Specific Settings ##########################################################################################

autocmd BufRead COMMIT_EDITMSG set textwidth=70 colorcolumn=70
