
set background=dark
set guifont=PragmataPro\ Mono:h15
set termguicolors
set antialias
" set lines=50 columns=160
" hide gui elements
set go=
" disable cursor blinking in normal mode
set guicursor=n:blinkon0

hi SignColumn ctermbg=none guibg=NONE
hi SyntasticErrorSign ctermbg=none ctermfg=DarkRed guibg=NONE guifg=red
hi SyntasticWarningSign ctermbg=none ctermfg=DarkMagenta guibg=NONE guifg=yellow
hi SyntasticStyleErrorSign ctermbg=none ctermfg=DarkCyan guibg=NONE guifg=Cyan

let g:lightline = {
      \ 'colorscheme': 'default',
      \ }
