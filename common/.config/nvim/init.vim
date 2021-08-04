" os detection
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

" vim-plug
call plug#begin(stdpath('data') . '/plugged')

Plug 'LnL7/vim-nix'
Plug 'NovaDev94/vim-fish'
Plug 'PProvost/vim-ps1'
Plug 'elixir-editors/vim-elixir'
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
Plug 'neovim/nvim-lspconfig'
Plug 'ntpeters/vim-better-whitespace'
Plug 'peterhoeg/vim-qml'
Plug 'rust-lang/rust.vim'
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

" settings
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

" tabbing
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

" color scheme
colorscheme jellybeans

" features
filetype plugin indent on
syntax enable

" autocommands
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
autocmd BufNewFile,BufRead *.ly compiler lilypond
autocmd BufNewFile,BufRead *.tex let b:tex_flavor = 'pdflatexmk' | compiler tex

" vim
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

" matchit.vim
runtime! macros/matchit.vim

" netrw
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'
nmap <leader>e :Explore<cr>

" lightline.vim
let g:lightline={'colorscheme': 'jellybeans'}

" vim-easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" vim-better-whitespace
nmap <leader><space> :StripWhitespace<cr>

" vimwiki
let g:vimwiki_global_ext=0
let g:vimwiki_dir_link='index'
if s:os == 'macos'
    let g:vimwiki_list=[{'path': '$HOME/Wiki'}]
else
    let g:vimwiki_list=[{'path': '$HOME/docs/wiki'}]
endif

" vim-sonic-pi
let g:sonic_pi_run_args = ['--cue-server', 'external']

" nvim-lspconfig
lua << EOF
local servers = {
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = { 'E501' }
          }
        }
      }
    }
  },
  rust_analyzer = {},
  rnix = {},
  bashls = {},
}

local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
  buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
  buf_set_keymap('n', '<leader>ll', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  buf_set_keymap('n', '<leader>R', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  buf_set_keymap('n', '<leader>C', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  buf_set_keymap('n', '<leader>E', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
  buf_set_keymap('n', '<leader>Q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
end

for server, extra_args in pairs(servers) do
  local args = {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }

  for key, val in pairs(extra_args) do
    args[key] = val
  end

  nvim_lsp[server].setup(args)
end
EOF
