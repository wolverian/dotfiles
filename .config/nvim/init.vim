" vim:set ts=2 sts=2 sw=2 expandtab:

autocmd!

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-flagship'
Plug 'tpope/vim-unimpaired'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'junegunn/goyo.vim'
" Plug 'mileszs/ack.vim'
Plug 'frigoeu/psc-ide-vim'
Plug 'cohama/lexima.vim'
" Plug 'townk/vim-autoclose'
Plug 'vimoutliner/vimoutliner'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'purescript-contrib/purescript-vim'
Plug 'leafgarland/typescript-vim'
" Plug 'HerringtonDarkholme/yats.vim'
Plug 'ruanyl/vim-fixmyjs'
Plug 'ntpeters/vim-better-whitespace'
" Plug 'Quramy/tsuquyomi'
" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'idris-hackers/idris-vim'
" Plug 'itchyny/lightline.vim'
Plug 'vmchale/dhall-vim'
Plug 'cocopon/iceberg.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mmai/vim-markdown-wiki'
Plug 'alx741/vim-hindent'
Plug 'jremmen/vim-ripgrep'
Plug 'udalov/kotlin-vim'
Plug 'natebosch/vim-lsc'

" Plug 'autozimu/LanguageClient-neovim', {
"   \ 'branch': 'next',
"   \ 'do': 'bash install.sh',
"   \ }

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
set hidden
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
" set ofu=syntaxcomplete#Complete
set path=$PWD/**
set encoding=utf-8
set termguicolors
set statusline=%f

" These are needed for 256 colors to work in tmux,
" I don't know why.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Do not highlight trailing whitespace.
" This will still remove the whitespace on save.
let g:better_whitespace_enabled = 0

" Strip trailing whitespace for all filetypes
let g:strip_whitespace_on_save = 0
" Do not ask
let g:strip_whitespace_confirm = 0

let g:lsc_server_commands = {'typescript': 'localhost:7000'}

" make quickfix occupy the full width
" botright cwindow
" botright lwindow

syntax enable
colorscheme iceberg

"
" Mappings
"

let mapleader = " "

" easier window switching
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

imap <c-c> <esc>
nnoremap <leader><tab> <c-^>

nnoremap <silent> <leader>f :Files<cr>

map <leader><space> :noh<cr>

" make it right
map Y y$

let g:tablabel =
      \ "%N%{flagship#tabmodified()} %{flagship#tabcwds('shorten',',')}"


let g:netrw_liststyle = 0
let g:netrw_list_hide =''

" Purescript
let g:psc_ide_syntastic_mode = 0
let g:purescript_indent_if = 0
let g:purescript_indent_case = 0
let g:purescript_indent_let = 0
let g:purescript_indent_where = 0
let g:purescript_indent_do = 0

" Allow JSX in .js files
let g:jsx_ext_required = 0

let g:LanguageClient_serverCommands = {
    \ 'typescript': ['./node_modules/.bin/tsserver'],
    \ 'javascript': ['./node_modules/.bin/tsserver']
    \ }

" let g:LanguageClient_devel = 1
let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_loggingFile = 'LanguageClient.log'
let g:LanguageClient_serverStderr = 'LanguageServer.log'
let g:LanguageClient_selectionUI = 'location-list'

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" hindent
let g:hindent_on_save = 1
let g:hindent_command = "cabal new-exec hindent"

" Typescript
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>s :w<cr>
let g:fixmyjs_engine = 'eslint'

nm <buffer> <silent> <leader>t :<C-U>echo PSCIDEtype(PSCIDEgetKeyword(), v:true)<CR>
" nm <buffer> <silent> <leader>s :<C-U>call PSCIDEapplySuggestion()<CR>
nm <buffer> <silent> <leader>a :<C-U>call PSCIDEaddTypeAnnotation()<CR>
nm <buffer> <silent> <leader>i :<C-U>call PSCIDEimportIdentifier(PSCIDEgetKeyword())<CR>
nm <buffer> <silent> <leader>r :<C-U>call PSCIDEload()<CR>
nm <buffer> <silent> <leader>p :<C-U>call PSCIDEpursuit(PSCIDEgetKeyword())<CR>
nm <buffer> <silent> <leader>qa :<C-U>call PSCIDEaddImportQualifications()<CR>
nm <buffer> <silent> ]d :<C-U>call PSCIDEgoToDefinition("", PSCIDEgetKeyword())<CR>

autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline
autocmd WinEnter * set number
autocmd WinLeave * set nonumber

filetype plugin indent on

command! Vcopen vertical copen|normal <C-W>=

set secure
