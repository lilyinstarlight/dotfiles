if isdirectory(expand("$VIMRUNTIME/ftplugin"))
  filetype indent on
endif

set showcmd
set showmatch
set ignorecase
set smartcase
set incsearch
set autowrite
set hidden
set mouse=a

cmap w!! w !sudo tee > /dev/null %

set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
