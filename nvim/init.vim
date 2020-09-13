" vim:set ts=2 sts=2 sw=2 expandtab:

autocmd!

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'junegunn/goyo.vim'
Plug 'mileszs/ack.vim'
Plug 'frigoeu/psc-ide-vim'
Plug 'cohama/lexima.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'purescript-contrib/purescript-vim'
Plug 'leafgarland/typescript-vim'
Plug 'ruanyl/vim-fixmyjs'
Plug 'idris-hackers/idris-vim'
Plug 'vmchale/dhall-vim'
Plug 'cocopon/iceberg.vim'
Plug 'junegunn/fzf', { 'dir': '~/Code/projects/fzf', 'do': './install --all' }
Plug 'mmai/vim-markdown-wiki'
Plug 'tikhomirov/vim-glsl'
Plug 'LnL7/vim-nix'
Plug 'neovimhaskell/haskell-vim'
Plug 'neovim/nvim-lspconfig' 

call plug#end()

" do NOT put a carriage return at the end of the last line! if you are programming
" for the web the default will cause http headers to be sent. that's bad.
language en_US
" allow project local configuration
set exrc
set completeopt=menu
set nocompatible
filetype off
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set cmdheight=1
set showtabline=1
set splitbelow
set splitright
set formatoptions=tcqorMj
set nobackup
set nowritebackup
set noswapfile
set nohidden
set textwidth=0
set background=dark
set hls
set vb
set showmatch
set ignorecase
set smartcase
set nonumber
set numberwidth=3
set gdefault
set cursorline
set noshowmode
set path=$PWD/**
set encoding=utf-8
set termguicolors
set statusline=%f
set signcolumn=yes

" These are needed for 256 colors to work in tmux,
" I don't know why.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

lua <<EOF
require'nvim_lsp'.hls.setup{
  init_options = {
    languageServerHaskell = {
      hlintOn = true;
      formattingProvider = "ormolu";
    }
  }
}
EOF

" make quickfix occupy the full width
botright cwindow
" botright lwindow

syntax enable
colorscheme iceberg

"
" Mappings
"
let mapleader = " "

" easier window switching
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

inoremap <c-c> <esc>
nnoremap <leader><tab> <c-^>
nnoremap <silent> <leader>f :FZF<cr>

map <leader><space> :noh<cr>
nmap <leader>s :w<cr>

" make it right
map Y y$

let g:netrw_liststyle = 0
let g:netrw_list_hide =''

" Allow JSX in .js files
let g:jsx_ext_required = 0

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline
" autocmd WinEnter * set number
" autocmd WinLeave * set nonumber

" Use LSP omni-completion in haskell files.
autocmd Filetype haskell setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Auto-format *.hs files prior to saving them
autocmd BufWritePre *.hs lua vim.lsp.buf.formatting_sync(nil, 1000)

lua <<EOF
do
  local method = "textDocument/publishDiagnostics"
  local default_callback = vim.lsp.callbacks[method]
  vim.lsp.callbacks[method] = function(err, method, result, client_id)
    default_callback(err, method, result, client_id)
    if result and result.diagnostics then
      for _, v in ipairs(result.diagnostics) do
        print(vim.inspect(v))
        print(vim.inspect(client_id))
        v.bufnr = client_id
        v.lnum = v.range.start.line + 1
        v.col = v.range.start.character + 1
        v.text = v.message
      end
      vim.lsp.util.set_qflist(result.diagnostics)
    end
  end
end
EOF

filetype plugin indent on

command! Vcopen vertical copen|normal <C-W>=

set secure
