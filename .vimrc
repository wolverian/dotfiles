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
Plug 'rking/ag.vim'
Plug 'frigoeu/psc-ide-vim'
Plug 'kana/vim-smartinput'
Plug 'vimoutliner/vimoutliner'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'purescript-contrib/purescript-vim'
Plug 'leafgarland/typescript-vim'
" Plug 'chriskempson/base16-vim'
" Plug 'nelstrom/vim-markdown-folding'
Plug 'Quramy/tsuquyomi'
Plug 'idris-hackers/idris-vim'
" Plug 'rakr/vim-one'
" Plug 'joshdick/onedark.vim'
" Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'vmchale/dhall-vim'
Plug 'cocopon/iceberg.vim'
Plug 'junegunn/fzf', { 'dir': '~/Code/projects/fzf', 'do': './install --all' }

call plug#end()

" do NOT put a carriage return at the end of the last line! if you are programming
" for the web the default will cause http headers to be sent. that's bad.
language en_US
" allow project local configuration
set exrc
set completeopt=menu
set nocompatible
filetype off
set noesckeys
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
set number
set numberwidth=3
set gdefault
set cursorline
set noshowmode
set ofu=syntaxcomplete#Complete
set path=$PWD/**
set encoding=utf-8
set termguicolors

" These are needed for 256 colors to work in tmux,
" I don't know why.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let g:lightline = {
      \ 'colorscheme': 'iceberg',
      \ }

" make quickfix occupy the full width
botright cwindow
botright lwindow

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

nnoremap <C-p> :FZF<cr>

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


nm <buffer> <silent> <leader>t :<C-U>echo PSCIDEtype(PSCIDEgetKeyword(), v:true)<CR>
nm <buffer> <silent> <leader>s :<C-U>call PSCIDEapplySuggestion()<CR>
nm <buffer> <silent> <leader>a :<C-U>call PSCIDEaddTypeAnnotation()<CR>
nm <buffer> <silent> <leader>i :<C-U>call PSCIDEimportIdentifier(PSCIDEgetKeyword())<CR>
nm <buffer> <silent> <leader>r :<C-U>call PSCIDEload()<CR>
nm <buffer> <silent> <leader>p :<C-U>call PSCIDEpursuit(PSCIDEgetKeyword())<CR>
nm <buffer> <silent> <leader>qa :<C-U>call PSCIDEaddImportQualifications()<CR>
nm <buffer> <silent> ]d :<C-U>call PSCIDEgoToDefinition("", PSCIDEgetKeyword())<CR>

autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

command! Vcopen vertical copen|normal <C-W>=

autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

filetype plugin indent on

set secure
