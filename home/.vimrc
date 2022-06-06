" Install Plugged ######################################################################################################

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

" Install Plugins ######################################################################################################

call plug#begin('~/.vim/plugged')

" Functionality Plugins
Plug 'ctrlpvim/ctrlp.vim'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'jlanzarotta/bufexplorer'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'

" Language Support Plugins
Plug 'digitaltoad/vim-pug'                          " pug
Plug 'elzr/vim-json'                                " json
Plug 'gisraptor/vim-lilypond-integrator'            " lilypond
Plug 'google/yapf'                                  " python
Plug 'kchmck/vim-coffee-script'                     " coffeescript
Plug 'leafgarland/typescript-vim'                   " typescript
Plug 'ljfa-ag/minetweaker-highlighting'             " zenscript
Plug 'maxmellon/vim-jsx-pretty'                     " jsx
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " autocomplete several languages
Plug 'pangloss/vim-javascript'                      " javascript
Plug 'plasticboy/vim-markdown'                      " markdown
Plug 'posva/vim-vue'                                " vue
Plug 'slim-template/vim-slim'                       " slim
Plug 'statianzo/vim-jade'                           " jade
Plug 'stephpy/vim-yaml'                             " yaml
Plug 'vim-scripts/mako.vim'                         " mako

call plug#end()

" Execute Basic Setup Commands #########################################################################################

set background=dark
silent! colorscheme gruvbox
" abra alduin badwolf Benokai birds-of-paradise black-angus brogrammer bvemu cabin camo chlordane coffee corporation
" dark-robin feral golden greens gruvbox kellys liquidcarbon molokai night_vision obsidian solarized zmrok

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
set incsearch
set laststatus=2
set list
set listchars=tab:>-
set modelines=2
set nobackup
set nofoldenable
set nohlsearch
set noswapfile
set nowrap
set nowritebackup
set number
set path=**
set ruler
set scrolloff=5
set shiftwidth=4
set showbreak="+++>"
set showcmd
set showmatch
set smarttab
set statusline=%<%f\ %h%m%r%*%=%-14.(%l,%c%V%)\ %P
set t_Co=256
set tabstop=4
set textwidth=100
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


" neoclide/coc.nvim

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
let g:indent_guides_enable_on_vim_startup = 0

 "plasticboy/vim-markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" posva/vim-vue
let g:vue_pre_processors = 'detect_on_enter'

" scrooloose/nerdtree
let g:NERDTreeIgnore = ['__pycache__', '\.pyc$', 'node_modules']

" vim-airline/vim-airline
let g:airline#extensions#ale#enabled = 1

" w0rp/ale
let g:ale_completion_delay = 500
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_open_list = 1
let g:ale_set_loclist = 0
let g:ale_sign_column_always = 1

let g:ale_fixers = {
    \'*': ['remove_trailing_lines', 'trim_whitespace'],
    \'go': ['gofmt', 'goimports'],
    \'javascript': ['eslint'],
    \'python': [],
    \'scss': ['stylelint'],
    \'typescript': ['eslint'],
    \'typescriptreact': ['eslint']
    \}

let g:ale_linters = {
    \'go': ['gobuild', 'golint', 'govet'],
    \'html': [],
    \'javascript': ['eslint'],
    \'json': ['jsonlint'],
    \'pug': ['puglint'],
    \'python': ['pycodestyle', 'pydocstyle', 'pyflakes', 'pyls'],
    \'typescript': ['eslint', 'tsserver'],
    \'typescriptreact': ['eslint', 'tsserver'],
    \'vue': ['vls']
    \}

let g:ale_virtualenv_dir_names = ['usr']

" Key Mappings #########################################################################################################

map <F1>  :NERDTreeToggle<CR>
map <F2>  :NERDTreeFind<CR>
map <F3>  :'a,.!sort -fg<CR>
map <F4>  :IndentGuidesToggle<CR>
map <F5>  :e!<CR>
map <F6>  :set hlsearch!<CR>
map <F7>  :cp<CR>
map <F8>  :copen<CR>
map <F9>  :cn<CR>
map <F10> :ALEFindReferences<CR>
map <F11> :ALEGoToDefinition<CR>
map <F12> :ALEGoToTypeDefinition<CR>

nmap '    :BufExplorer<CR>

" Local Overrides ######################################################################################################

silent! source $HOME/.vimrc.local    " user or machine specific .vimrc
silent! source .vimrc.local          " project specific .vimrc

" File-Type Specific Settings ##########################################################################################

autocmd BufRead COMMIT_EDITMSG set textwidth=70 colorcolumn=70
autocmd BufRead Makefile setlocal noexpandtab
autocmd BufRead *.mako set syntax=mako
autocmd BufRead *.go set noexpandtab
autocmd BufRead *.go set listchars=tab:\ \ ,
autocmd BufRead *.jin set syntax=jinja
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
