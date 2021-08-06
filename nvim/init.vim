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
Plug 'akinsho/nvim-bufferline.lua'
Plug 'hrsh7th/nvim-compe'
Plug 'hoob3rt/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'TimUntersberger/neogit'
Plug 'mfussenegger/nvim-jdtls'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'sindrets/diffview.nvim'

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

" bufferline
nnoremap <silent><Tab> :BufferLineCycleNext<CR>
nnoremap <silent><S-Tab> :BufferLineCyclePrev<CR>

" compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')

nnoremap <leader>f <cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({previewer = false}))<cr>

lua << EOF
require('lualine').setup({
  options = {
    theme = 'moonlight',
    component_separators = {'', ''},
    section_separators = {'', ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename'},
    lualine_c = {'branch'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
})

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

require("bufferline").setup({
  options = {
    max_name_length = 25,
    tab_size = 25,
    show_close_icon = false,
    show_buffer_close_icons = false
  }
})

require'lspinstall'.setup()

local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

local servers = require'lspinstall'.installed_servers()

for _, server in pairs(servers) do
  require'lspconfig'[server].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

require('neogit').setup({
  integrations = { diffview = true }
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require('telescope').setup({
  defaults = {
    layout_strategy = "center"
  }
})

require'diffview'.setup({})
EOF

filetype plugin indent on
