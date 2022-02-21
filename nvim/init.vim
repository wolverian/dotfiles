autocmd!

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'purescript-contrib/purescript-vim'
Plug 'leafgarland/typescript-vim'
Plug 'vmchale/dhall-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'cocopon/iceberg.vim'
Plug 'windwp/nvim-autopairs'

call plug#end()

language en_US

set encoding=utf-8
set autoread
set autowrite
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
set termguicolors
set splitright
set splitbelow
set cursorline
set grepprg=rg\ --line-number
set completeopt=menuone,noselect
set clipboard+=unnamedplus

colorscheme iceberg

syntax enable

let mapleader = " "
inoremap <c-c> <esc>
nnoremap <leader><tab> <c-^>
noremap <leader>s :w<cr>
" can't use the default <C-l> because that is used below
noremap <leader><leader> :noh<cr>
noremap <C-k> <C-w>k
noremap <C-j> <C-w>j
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Select the first completion automatically to prevent hitting <C-n> twice
" to get an autocompletion
inoremap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<C-n><C-n>"

" Silent grepping that automatically opens the quickfix window
command! -nargs=+ Rg execute 'silent grep! <args>' | copen 10

lua << EOF

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require('nvim-autopairs').setup()

EOF

filetype plugin indent on
