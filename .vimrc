
call pathogen#runtime_append_all_bundles() 

" do NOT put a carriage return at the end of the last line! if you are programming
" for the web the default will cause http headers to be sent. that's bad.
set binary noeol
set nocompatible
set noesckeys
set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
set cmdheight=1
set showtabline=1
set splitbelow
set splitright
set autoread
set wildmenu
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
set wildignore=*.o,*.class,*.png,*.jar

set statusline=\ "
set statusline+=%f\ " file name
set statusline+=[
set statusline+=%{strlen(&ft)?&ft:'none'} " filetype
set statusline+=]
" set statusline+=%{fugitive#statusline()}
set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=%= " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

syntax on
scriptencoding utf-8

" enable filetype-specific indenting and plugins
filetype plugin indent on
filetype plugin on

augroup vimrcEx
    autocmd!
    autocmd FileType ruby,javascript,coffee set ai sw=2 sts=2 tabstop=2 et
    autocmd! BufRead,BufNewFile *.mkd setfiletype mkd
    autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:&gt;
    autocmd BufRead,BufNewFile *.k set ft=scheme
    autocmd BufRead,BufNewFile *.rkt set ft=scheme
augroup END

" this is better than \
let mapleader = ","

let g:solarized_termcolors=16
color solarized

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

let g:CommandTMaxFiles=25000
noremap <leader>e :CommandT<cr>

noremap <C-CR> :call Toggle_task_status()<CR>

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
