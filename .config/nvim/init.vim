"settings
if ! has('nvim')
set nocompatible
endif
set autoindent
set autoread
set autowrite
set backspace=indent,start
set clipboard=unnamedplus
set cursorcolumn
set cursorline
set display=lastline
set encoding=utf-8
set formatoptions+=n,j
set hidden
set history=50
set ignorecase
set incsearch
set laststatus=2
set listchars=eol:$,tab:>-,space:.,trail:#,extends:>,precedes:<,conceal:*,nbsp:+
set mouse=a
set nrformats=hex,alpha
set nohlsearch
set nojoinspaces
set noshowmode
set noruler
set number
if has('nvim')
set runtimepath+=/usr/share/vim/vimfiles
endif
if has('nvim')
set shada='20,<500,h
endif
set showmatch
set smartcase
set smarttab
set scrolloff=2
set showcmd
if ! has('nvim')
set undodir=$HOME/.local/share/nvim/undo
endif
set undofile
if ! has('nvim')
set viminfo='20,<500,h
endif
set wildmenu

"vim-plug
call plug#begin('$HOME/.config/nvim/plugged')

Plug 'haya14busa/incsearch.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-plug'
Plug 'nanotech/jellybeans.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'

call plug#end()

"tabbing
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

"colour scheme
colorscheme jellybeans

"features
filetype plugin indent on
syntax enable

"autocommands
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

"vim
nmap <leader>l :set list!<cr>

"matchit.vim
runtime! macros/matchit.vim

"netrw
nmap <leader>e :Explore<cr>

"incsearch.vim
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"lightline.vim
let g:lightline = { 'colorscheme': 'jellybeans', }

"vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"vim-better-whitespace
nmap <leader><space> :StripWhitespace<cr>
