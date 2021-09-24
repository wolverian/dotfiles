highlight clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "anttih"

" Black	  0 8
" Red	    1 9
" Green	  2 10
" Yellow  3 11
" Blue    4 12
" Magenta	5 13
" Cyan    6 14
" White   7 15

" In diffs, added lines are green, changed lines are yellow, deleted lines are
" red, and changed text (within a changed line) is bright yellow and bold.
highlight DiffAdd        ctermfg=0    ctermbg=2
highlight DiffChange     ctermfg=0    ctermbg=3
highlight DiffDelete     ctermfg=0    ctermbg=1
highlight DiffText       ctermfg=0    ctermbg=11   cterm=bold

" Invert selected lines in visual mode
highlight Visual         ctermfg=0 ctermbg=15

" Highlight search matches in black, with a yellow background
highlight Search         ctermfg=0    ctermbg=11

" Dim line numbers, comments, color columns, the status line, splits and sign
" columns.
highlight LineNr       ctermfg=8
highlight CursorLineNr ctermfg=7
highlight Comment      ctermfg=8
highlight ColorColumn  ctermfg=7    ctermbg=8
highlight Folded       ctermfg=7    ctermbg=8
highlight FoldColumn   ctermfg=7    ctermbg=8
highlight Pmenu        ctermfg=15   ctermbg=8
highlight PmenuSel     ctermfg=8    ctermbg=15
highlight SpellCap     ctermfg=7    ctermbg=8
highlight StatusLine   ctermfg=0    ctermbg=8
highlight StatusLineNC ctermfg=7    ctermbg=8    cterm=NONE
highlight VertSplit    ctermfg=0    ctermbg=0    cterm=NONE
highlight SignColumn                ctermbg=0

highlight Constant       ctermfg=6
highlight Function       ctermfg=15 cterm=NONE
highlight Boolean        ctermfg=6
highlight Identifier     ctermfg=15 cterm=NONE
highlight PreProc        ctermfg=15 cterm=NONE
highlight Special        ctermfg=NONE
highlight Statement      ctermfg=15 cterm=NONE
highlight Title          ctermfg=15 cterm=NONE
highlight Underlined     ctermfg=NONE cterm=underline
highlight String         ctermfg=NONE

" Accents
highlight Keyword        ctermfg=4
highlight Type           ctermfg=15
