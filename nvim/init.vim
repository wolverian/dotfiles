autocmd!

call plug#begin('~/.local/share/nvim/plugged')

" Plug 'tpope/vim-sensible'
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-scriptease'
" Plug 'tpope/vim-vinegar'
" Plug 'tpope/vim-obsession'
" Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-unimpaired'
" Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'purescript-contrib/purescript-vim'
Plug 'leafgarland/typescript-vim'
" Plug 'idris-hackers/idris-vim'
Plug 'vmchale/dhall-vim'
" Plug 'cocopon/iceberg.vim'
" Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'
" Plug 'tikhomirov/vim-glsl'
" Plug 'LnL7/vim-nix'
Plug 'neovimhaskell/haskell-vim'
" Plug 'neovim/nvim-lspconfig' 
" Plug 'voldikss/vim-floaterm'
" Plug 'norcalli/nvim-colorizer.lua'
Plug 'jeffkreeftmeijer/vim-dim'

call plug#end()

language en_US

set encoding=utf-8
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set cmdheight=1
set showtabline=1
set hidden
set hls
set vb
set showmatch
set ignorecase
set smartcase
set nonumber
set numberwidth=2
set signcolumn=number
set nowrap
" set gdefault
" set cursorline
" set noshowmode
" set termguicolors

colorscheme dim

syntax enable

let mapleader = " "
inoremap <c-c> <esc>
nnoremap <leader><tab> <c-^>
noremap <leader><space> :noh<cr>
noremap <leader>s :w<cr>

filetype plugin indent on
