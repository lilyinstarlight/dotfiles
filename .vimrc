"Pathogen
execute pathogen#infect()

"Features
syntax on
filetype indent on

"Settings
set showcmd
set showmatch
set ignorecase
set smartcase
set incsearch
set autowrite
set hidden
set mouse=a

"Tabbing
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

"Custom commands
cmap w!! w !sudo tee > /dev/null %
