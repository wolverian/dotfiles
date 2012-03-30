
call pathogen#runtime_append_all_bundles() 

" do NOT put a carriage return at the end of the last line! if you are programming
" for the web the default will cause http headers to be sent. that's bad.
set binary noeol

" turn off compatibility with the old vi
set nocompatible

" prevent delay after ESC O.
" for some reason noesckeys is not enough
set noesckeys
" set timeoutlen=0

" set our tabs to four spaces
set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4

autocmd FileType ruby,haml,eruby,yaml,javascript,coffee set ai sw=2 sts=2 tabstop=2 et

set cmdheight=1

" this is better than \
let mapleader = ","

" UTF-8 All the way
scriptencoding utf-8

" enable filetype-specific indenting
filetype plugin indent on

" show tabline only when there are more than one
set showtabline=1

" Open new horizontal split windows below current
set splitbelow

" Open new vertical split windows to the right
set splitright

" Set to auto read when a file is changed from the outside
set autoread

" cd to current buffer dir
" set autochdir

" nice autocomplete
set wildmenu

" indenting for programming
"set smartindent
set autoindent

" this will make it indent after 'o' for example
" set cindent

" continue comment on next line when hard-wrapping
set formatoptions=tcqorM

" use par command for paragraph formatting.
" it must be installed
set formatprg=par\ -w79

" no backup or swap files
set nobackup
set nowritebackup
set noswapfile

" hide buffers (allow changing from edited buffers without warnings)
set hidden

" turn on hard-wrapping
set tw=79

" highlight all character beyond 80 columns
"match ErrorMsg '\%>80v.\+'

" make the last line where the status is two lines deep so you
" can always see the status
set laststatus=2

set statusline=\ "
set statusline+=%f\ " file name
set statusline+=[
set statusline+=%{strlen(&ft)?&ft:'none'} " filetype
set statusline+=]
" set statusline+=%{fugitive#statusline()}
set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=%= " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

" Enable nice colors in NERDTree
let NERDTreeMinimalUI = 1
let NERDChristmasTree = 1

" Make <leader>e to open NERDTree
nmap <leader>e :NERDTreeToggle<CR>

" Make bookmarks visible
let NERDTreeShowBookmarks = 0

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault

" turn syntax highlighting on by default
syntax on

set t_Co=256

" color ahc256
let g:solarized_termcolors=16
color solarized
set background=dark

" incremental search, always
set incsearch

" set highlight search
set hls

" turn on the "visual bell" - which is much quieter than the "audio blink"
set vb

" automatically show matching brackets. works like it does in bbedit.
set showmatch

" make searches case-sensitive only when search inludes uppercase letters
set ignorecase
set smartcase

" keep more context when scrolling off the end of a buffer
set scrolloff=3

" make that backspace key work the way it should
set backspace=indent,eol,start

" show invisible characters TextMate style
"set list
set lcs=tab:▸\ ,eol:¬

" nicer split borders
set fillchars=vert:│

set nonumber
set numberwidth=3

filetype plugin on
set ofu=syntaxcomplete#Complete

" Source the vimrc file after saving it
""if has("autocmd")
""    autocmd bufwritepost .vimrc source $MYVIMRC
""endif

" easier window switching
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" This came from Gary Bernhardt:
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

set cursorline

augroup markdown
    au! BufRead,BufNewFile *.mkd   setfiletype mkd
augroup END

augroup mkd
    autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END

" make quickfix occupy the full width
botright cwindow

" Spec.io SilentReporter error format
" ERROR: Message. File /file/path, line 10.
set errorformat+=%m.\ File\ %f\\,\ line\ %l.

" leave cursor after the pasted text
noremap p gp
noremap P gP
noremap gp p 
noremap gP P

set wildignore=*.o,*.class

let g:CommandTMaxFiles=25000
noremap <leader>e :CommandT<cr>

noremap <C-CR> :call Toggle_task_status()<CR>

" wrap current sexpr and insert proc name
map ,w vabs)a

" VimClojure
let vimclojure#HighlightBuiltins = 1
let vimclojure#ParenRainbow = 1

" em is ugly in solarized
hi htmlItalic cterm=none ctermbg=none

hi VertSplit ctermbg=none

" Compile coffeescript on save
autocmd BufWritePost,FileWritePost *.coffee :silent !coffee -c --bare <afile>