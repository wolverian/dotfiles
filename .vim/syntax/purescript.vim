" syntax highlighting for purescript
"
" Heavily modified version of the purescript syntax
" highlighter to support purescript.
"
" author: raichoo (raichoo@googlemail.com)

if exists("b:current_syntax")
  finish
endif

syn match ConId         "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=\<[A-Z][a-zA-Z0-9_']*\>"
syn match VarId         "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=\<[a-z][a-zA-Z0-9_']*\>"

" Reserved symbols--cannot be overloaded.
syn match purescriptDelimiter  "(\|)\|\[\|\]\|,\|;\|_\|{\|}"

syn keyword purescriptModuleStartLabel module
syn keyword purescriptImport foreign import hiding
syn region purescriptQualifiedImport start="\<qualified\>" contains=purescriptType,purescriptDot end="\<as\>"
syn keyword purescriptTypedef data type newtype
syn keyword purescriptStructure class instance where forall do case of let in
syn keyword purescriptConditional if then else
syn match purescriptTypeSig
  \ "^\s*\(where\s\+\|let\s\+\|default\s\+\)\?[_a-z][a-zA-Z0-9_']*\(,\s*[_a-z][a-zA-Z0-9_']*\)*\(\s*::\|\n\s\+::\)"
syn match purescriptNumber "\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>"
syn match purescriptFloat "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"
syn match purescriptDelimiter  "[(),;[\]{}]"
syn keyword purescriptInfix infix infixl infixr
syn match purescriptOperators "\([-!#$%&\*\+/<=>\?@\\^|~:]\|\<_\>\)"
syn match purescriptDot "\."
syn match purescriptType "\<\([A-Z][a-zA-Z0-9_]*\|_|_\)\>"
syn match purescriptLineComment "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$"
syn match purescriptChar "'[^'\\]'\|'\\.'\|'\\u[0-9a-fA-F]\{4}'"
syn match purescriptBacktick "`[A-Za-z][A-Za-z0-9_]*`"
syn region purescriptString start=+"+ skip=+\\\\\|\\"+ end=+"+
syn region purescriptMultilineString start=+"""+ end=+"""+
syn region purescriptBlockComment start="{-" end="-}" contains=purescriptBlockComment

highlight def link purescriptModuleStartLabel purescriptStructure
highlight def link purescriptImport Keyword
highlight def link purescriptQualifiedImport Structure
highlight def link purescriptStructure Keyword
"highlight def link purescriptStatement Statement
highlight def link purescriptConditional Conditional
highlight def link purescriptTypeSig Function
highlight def link purescriptNumber Number
highlight def link purescriptFloat Float
highlight def link purescriptDelimiter Delimiter
highlight def link purescriptInfix PreProc
highlight def link purescriptOperators Operator
highlight def link purescriptDot Operator
highlight def link purescriptType Type
highlight def link purescriptTypedef Typedef
highlight def link purescriptLineComment Comment
highlight def link purescriptBlockComment Comment
highlight def link purescriptString String
highlight def link purescriptMultilineString String
highlight def link purescriptChar String
highlight def link purescriptBacktick Operator

let b:current_syntax = "purescript"
