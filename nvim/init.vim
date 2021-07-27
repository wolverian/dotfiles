autocmd!

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'purescript-contrib/purescript-vim'
Plug 'leafgarland/typescript-vim'
Plug 'vmchale/dhall-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'neovim/nvim-lspconfig' 
Plug 'kabouzeid/nvim-lspinstall'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'shaunsingh/moonlight.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'hrsh7th/nvim-compe'

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
set termguicolors

colorscheme moonlight

syntax enable

let mapleader = " "
inoremap <c-c> <esc>
nnoremap <leader><tab> <c-^>
noremap <leader><space> :noh<cr>
noremap <leader>s :w<cr>

" nvim-tree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <silent><Tab> :BufferLineCycleNext<CR>
nnoremap <silent><S-Tab> :BufferLineCyclePrev<CR>

" compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')

lua << EOF

vim.o.completeopt = "menuone,noselect"
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
  -- documentation = {
  --   border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
  --   winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
  --   max_width = 120,
  --   min_width = 60,
  --   max_height = math.floor(vim.o.lines * 0.3),
  --   min_height = 1,
  -- };

  source = {
    path = true;
    buffer = true;
    calc = false;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = false;
    ultisnips = false;
    luasnip = false;
  };
}


vim.g.moonlight_borders = true
require('moonlight').set()

require("bufferline").setup({})

require'lspinstall'.setup()
local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end

EOF

filetype plugin indent on
