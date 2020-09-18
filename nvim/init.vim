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
Plug 'purescript-contrib/purescript-vim'
Plug 'leafgarland/typescript-vim'
Plug 'idris-hackers/idris-vim'
Plug 'vmchale/dhall-vim'
Plug 'cocopon/iceberg.vim'
Plug 'junegunn/fzf'
Plug 'tikhomirov/vim-glsl'
Plug 'LnL7/vim-nix'
Plug 'neovimhaskell/haskell-vim'
Plug 'neovim/nvim-lspconfig' 

" JS and TypeScript
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim'

" Completion
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'

call plug#end()

" do NOT put a carriage return at the end of the last line! if you are programming
" for the web the default will cause http headers to be sent. that's bad.
language en_US
" allow project local configuration
set exrc
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
set hidden
set textwidth=0
set background=dark
set hls
set vb
set showmatch
set ignorecase
set smartcase
set nonumber
" set numberwidth=3
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
      diagnosticsOnChange = false;
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

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gh    <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g.    <cmd>lua vim.lsp.buf.code_action()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" Auto-format *.hs files prior to saving them
autocmd BufWritePre *.hs lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync(nil, 1000)

autocmd BufEnter * lua require'lsp_extra'.check_start_ts_lsp()

" Completion

let g:completion_chain_complete_list = [
  \{'complete_items': ['lsp', 'buffer']}
\]

autocmd BufEnter * lua require'completion'.on_attach()
set completeopt=menuone,noinsert,noselect
set shortmess+=c

lua <<EOF
require'lsp_extra'.register_PublishDiagnostics_callback()
EOF

highlight LspDiagnosticsUnderlineError gui=underline
highlight LspDiagnosticsUnderlineWarning gui=underline

filetype plugin indent on

command! Vcopen vertical copen|normal <C-W>=

set secure
