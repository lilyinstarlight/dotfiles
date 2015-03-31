"vim-plug
call plug#begin('$HOME/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-speeddating'
Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-multiple-cursors'
Plug 'haya14busa/incsearch.vim'
Plug 'itchyny/lightline.vim'
Plug 'nanotech/jellybeans.vim'

call plug#end()

"features
syntax on
filetype plugin on
filetype indent on

"autocommands
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif "Restore to last known position in file on startup

"settings
set nocompatible
set ai
set bs=2
set hidden
set history=50
set ignorecase
set mouse=a
set nohlsearch
set noshowmode
set noruler
set number
set showmatch
set smartcase
set undodir=$HOME/.vim/undo
set undofile
set viminfo='20,<500
set wildmenu

"tabbing
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

"colour scheme
colorscheme jellybeans

"lightline.vim
let g:lightline = { 'colorscheme': 'jellybeans', }

"incsearch.vim
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
