"Vim-Plug
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-speeddating'
Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'
Plug 'FredKSchott/CoVim'
Plug 'nanotech/jellybeans.vim'

call plug#end()

"Features
syntax on
filetype indent on

"Settings
set noshowmode
set showmatch
set ignorecase
set smartcase
set mouse=a

"Tabbing
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

"Colour Scheme
colorscheme jellybeans
