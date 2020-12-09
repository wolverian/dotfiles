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
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'LnL7/vim-nix'
Plug 'neovimhaskell/haskell-vim'
Plug 'neovim/nvim-lspconfig' 
Plug 'voldikss/vim-floaterm'
Plug 'norcalli/nvim-colorizer.lua'

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
set relativenumber
set numberwidth=2
set nowrap
set gdefault
set cursorline
set noshowmode
set path=$PWD/**
set encoding=utf-8
set termguicolors
set statusline=%f\ %m\ %=%y\ Line\ %l:%L\ Col\ %c
set signcolumn=yes
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" Use the plain haskell-langauge-server without the wrapper.
" I think it should work with nix.
lua <<EOF
require'lspconfig'.hls.setup{
 cmd = {"haskell-language-server", "--lsp"};
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
colorscheme dracula

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
nnoremap <silent> <leader>g :FloatermNew --autoclose=2 lazygit<cr>
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>/ :Rg<cr>

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
nnoremap <silent> gh    <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g.    <cmd>lua vim.lsp.buf.code_action()<CR>

autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" Auto-format *.hs files prior to saving them
autocmd BufWritePre *.hs lua vim.lsp.buf.formatting_sync(nil, 1000)
" autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 1000)
" autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync(nil, 1000)

autocmd BufEnter * lua require'lsp_extra'.check_start_ts_lsp()

" Completion

let g:completion_chain_complete_list = [
  \{'complete_items': ['lsp', 'buffer']}
\]

let g:completion_trigger_keyword_length = 2

autocmd BufEnter * lua require'completion'.on_attach()
set completeopt=menuone,noinsert,noselect
set shortmess+=c

lua <<EOF
require'lsp_extra'.register_PublishDiagnostics_callback()
EOF

highlight LspDiagnosticsUnderlineError gui=underline
highlight LspDiagnosticsUnderlineWarning gui=underline
highlight SignColumn guibg=undefined

" red
highlight LspDiagnosticsError guifg=#e27878
" yellow
highlight LspDiagnosticsWarning guifg=#e2a478
" blue
highlight LspDiagnosticsInformationSign guifg=#84a0c6
highlight LspDiagnosticsHintSign guifg=#84a0c6

sign define LspDiagnosticsErrorSign text=● texthl=LspDiagnosticsError linehl= numhl=
sign define LspDiagnosticsWarningSign text=● texthl=LspDiagnosticsWarning linehl= numhl=
sign define LspDiagnosticsInformationSign text=● texthl=LspDiagnosticsInformation linehl= numhl=
sign define LspDiagnosticsHintSign text=● texthl=LspDiagnosticsHint linehl= numhl=

filetype plugin indent on

command! Vcopen vertical copen|normal <C-W>=
command! Purty silent !purty --write %

set secure
