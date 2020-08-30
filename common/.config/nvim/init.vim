"os detection
if !exists('s:os')
    if has('win32')
        let s:uname = 'Windows'
        let s:os = 'windows'
    elseif filereadable('/proc/version') && readfile('/proc/version')[0] =~ 'Microsoft\|WSL'
        let s:uname = 'Linux'
        let s:os = 'wsl'
    else
        let s:uname = substitute(system('uname -s'), '\n', '', '')
        if s:uname == 'Darwin'
            let s:os = 'macos'
        elseif s:uname == 'Linux'
            let s:os = 'linux'
        else
            let s:os = 'unknown'
        endif
    endif
endif

"vim-plug
call plug#begin(stdpath('data') . '/plugged')

Plug 'LnL7/vim-nix'
Plug 'NovaDev94/vim-fish'
Plug 'PProvost/vim-ps1'
Plug 'fidian/hexmode'
Plug 'gisraptor/vim-lilypond-integrator'
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-plug'
Plug 'junegunn/vim-slash'
Plug 'lfv89/vim-interestingwords'
Plug 'lilyinstarlight/vim-resolve'
Plug 'lilyinstarlight/vim-sonic-pi'
Plug 'lilyinstarlight/vim-spl'
Plug 'nanotech/jellybeans.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'peterhoeg/vim-qml'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'
Plug 'vimwiki/vimwiki'
Plug 'zeek/vim-zeek'

call plug#end()

"settings
set autoindent
set autoread
set autowrite
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
set printoptions=number:y,paper:letter
set shada='20,<500,h
set showmatch
set smartcase
set smarttab
set scrolloff=2
set showcmd
set undofile
set wildmenu

"tabbing
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

"color scheme
colorscheme jellybeans

"features
filetype plugin indent on
syntax enable

"autocommands
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
autocmd BufNewFile,BufRead *.ly compiler lilypond
autocmd BufNewFile,BufRead *.tex let b:tex_flavor = 'pdflatexmk' | compiler tex

"vim
nnoremap Y y$
nmap <leader>n :ene<cr>
nmap <leader>d :%d<cr>
nmap <leader>l :set list!<cr>
nmap <leader>s :w<cr>
nmap <leader>t :tabe<cr>
nmap <leader>c :clo<cr>
nmap <leader>u :bd!<cr>
nmap <leader>a :bel new<cr>:te<cr>
nmap <leader>v :set virtualedit=all<cr>
nmap <leader>g :set virtualedit=<cr>
nmap <leader>b :Hexmode<cr>
nmap <leader>p :.!xargs 
vmap <leader>p :!xargs 
nmap <leader>q :.!bc<cr>
vmap <leader>q :!bc<cr>
nmap <leader><cr> :make %<cr>

"matchit.vim
runtime! macros/matchit.vim

"netrw
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'
nmap <leader>e :Explore<cr>

"lightline.vim
let g:lightline={'colorscheme': 'jellybeans'}

"vim-easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

"vim-better-whitespace
nmap <leader><space> :StripWhitespace<cr>

"vimwiki
let g:vimwiki_global_ext=0
let g:vimwiki_dir_link='index'
if s:os == 'macos'
    let g:vimwiki_list=[{'path': '$HOME/Wiki'}]
else
    let g:vimwiki_list=[{'path': '$HOME/docs/wiki'}]
endif
