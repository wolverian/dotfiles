autocmd!

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'purescript-contrib/purescript-vim'
Plug 'leafgarland/typescript-vim'
Plug 'vmchale/dhall-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'hrsh7th/nvim-compe'
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

colorscheme iceberg

syntax enable

let mapleader = " "
inoremap <c-c> <esc>
nnoremap <leader><tab> <c-^>
noremap <leader>s :w<cr>
noremap <C-k> <C-w>k
noremap <C-j> <C-w>j
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Silent grepping that automatically opens the quickfix window
command! -nargs=+ Rg execute 'silent grep! <args>' | copen 10

" compe
" inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')

lua << EOF

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 2;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  source = {
    path = true;
    buffer = true;
    calc = false;
    nvim_diagnostic = true;
    nvim_lua = true;
    vsnip = false;
    ultisnips = false;
    luasnip = false;
  };
}

vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true })

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  auto_select = true,  -- auto select first item
})

EOF

filetype plugin indent on
