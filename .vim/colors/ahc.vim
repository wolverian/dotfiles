" This is mostly copied from Gary Bernhardt's grb4 theme:
" https://github.com/garybernhardt/dotfiles/blob/master/.vim/colors/grb4.vim

runtime colors/ir_black.vim

let g:colors_name = "ahc"

hi pythonSpaceError ctermbg=red guibg=red

hi CursorLine ctermbg=darkgray
hi StatusLine ctermbg=lightgrey ctermfg=black
hi StatusLineNC ctermbg=lightgrey ctermfg=black
hi VertSplit ctermbg=lightgrey ctermfg=black
hi Comment ctermfg=black
hi MatchParen ctermbg=red

" ir_black doesn't highlight operators for some reason
hi Operator guifg=#6699CC guibg=NONE gui=NONE ctermfg=lightblue ctermbg=NONE cterm=NONE
" hi Operator        guifg=#6699CC     guibg=NONE        gui=NONE
" ctermfg=lightblue   ctermbg=NONE        cterm=NONE
" "

