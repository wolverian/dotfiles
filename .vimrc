" vim:set ts=2 sts=2 sw=2 expandtab:

autocmd!

execute pathogen#infect()

" do NOT put a carriage return at the end of the last line! if you are programming
" for the web the default will cause http headers to be sent. that's bad.
set nocompatible
set noesckeys
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set cmdheight=1
set showtabline=1
set splitbelow
set splitright
set wildmenu
set wildmode=longest,list
set wildignore=*.o,*.class,*.png,*.jar,*.pyc,lib/*,target/*,project/*,bin/redo*/,node_modules/*
set autoindent
set formatoptions=tcqorM
set formatprg=par\ -w79
set nobackup
set nowritebackup
set noswapfile
set hidden
set tw=79
set laststatus=2
set background=dark
set incsearch
set hls
set vb
set showmatch
set ignorecase
set smartcase
set scrolloff=3
set backspace=indent,eol,start
set lcs=tab:▸\ ,eol:¬
set fillchars=vert:│
set nonumber
set numberwidth=3
set gdefault
set t_Co=256
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999
set cursorline
set ofu=syntaxcomplete#Complete
set nojoinspaces
set foldmethod=manual
set nofoldenable
set autoread

set statusline=\ "
set statusline+=%f\ " file name
set statusline+=[
set statusline+=%{strlen(&ft)?&ft:'none'} " filetype
set statusline+=]
" set statusline+=%{fugitive#statusline()}
set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=%= " right align
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

syntax on
scriptencoding utf-8

" enable filetype-specific indenting and plugins
filetype plugin indent on

augroup vimrcEx
    autocmd!
    autocmd! BufRead,BufNewFile *.mkd setfiletype mkd
    autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:&gt;
    autocmd BufRead,BufNewFile *.k set ft=scheme
    autocmd BufRead,BufNewFile *.rkt set lisp
    " autocmd! BufWritePost *.coffee :silent !coffee -c --map %
    " au BufEnter *.hs compiler ghc
augroup END

" this is better than \
let mapleader = ","

let g:solarized_termcolors=16
let g:onedark_termcolors=16
color onedark

" easier window switching
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" make quickfix occupy the full width
botright cwindow

" leave cursor after the pasted text
noremap p gp
noremap P gP
noremap gp p
noremap gP P

imap <c-c> <esc>
nnoremap <leader><leader> <c-^>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard | grep -v node_modules']

map <leader>e :CtrlP<cr>
map <leader>b :CtrlPBuffer<cr>

" wrap current sexpr and insert proc name
map ,w vabs)a

map <leader><space> :noh<cr>

" make it right
map Y y$

" grepping
set grepprg=ack
map ,g :execute " grep " . expand("<cword>") . " " <bar> cwindow<CR>

" VimClojure
let vimclojure#HighlightBuiltins = 1
let vimclojure#ParenRainbow = 1

" em is ugly in solarized
hi htmlItalic cterm=none ctermbg=none
let g:html_indent_tags = 'p'

hi VertSplit ctermbg=none

" Syntastic
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_jump = 2
let g:syntastic_error_symbol = ' '
let g:syntastic_style_error_symbol = ' '
let g:syntastic_warning_symbol = ' '
let g:syntastic_auto_loc_list = 2
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_haskell_checkers = ['hdevtools', 'hlint']
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['haskell'], 'passive_filetypes': [] }

hi SignColumn ctermbg=none guibg=NONE
hi SyntasticErrorSign ctermbg=none ctermfg=DarkRed guibg=NONE guifg=DarkRed
hi SyntasticWarningSign ctermbg=none ctermfg=DarkMagenta guibg=NONE guifg=DarkMagenta
hi SyntasticStyleErrorSign ctermbg=none ctermfg=DarkCyan guibg=NONE guifg=DarkCyan

