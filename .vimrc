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
