" This is mostly copied from Gary Bernhardt's grb4 theme:
" https://github.com/garybernhardt/dotfiles/blob/master/.vim/colors/grb4.vim

runtime colors/ir_black256.vim

let g:colors_name = "ahc256"

hi pythonSpaceError ctermbg=red guibg=red

hi Comment ctermfg=darkgray

hi StatusLine ctermbg=236 ctermfg=white
hi StatusLineNC ctermbg=242 ctermfg=white
hi VertSplit ctermbg=236 ctermfg=245
hi LineNr ctermfg=darkgray
hi CursorLine guifg=NONE guibg=#121212 gui=NONE ctermfg=NONE ctermbg=234
hi Function guifg=#FFD2A7 guibg=NONE gui=NONE ctermfg=yellow ctermbg=NONE cterm=NONE
hi Visual guifg=NONE guibg=#262D51 gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Pmenu ctermbg=26 ctermfg=white

" ir_black doesn't highlight operators for some reason
 hi Operator guifg=#6699CC guibg=NONE gui=NONE ctermfg=lightblue ctermbg=NONE cterm=NONE

