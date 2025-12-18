if exists("b:current_syntax")
  finish
endif

syntax keyword tacoKeyword fun
syntax keyword tacoKeyword rec
syntax keyword tacoKeyword if
syntax keyword tacoKeyword while
syntax keyword tacoKeyword else
syntax keyword tacoKeyword for
syntax keyword tacoKeyword return
syntax keyword tacoKeyword assert
syntax keyword tacoKeyword enum
syntax keyword tacoKeyword in
syntax keyword tacoKeyword match

syntax keyword tacoConstant true
syntax keyword tacoConstant false
syntax keyword tacoConstant self
syntax keyword tacoConstant arguments

syntax keyword tacoType int
syntax keyword tacoType str
syntax keyword tacoType bool

syntax match tacoComment "#.*$"

syntax region tacoInterp start=/\$/ end=/\>/ contained contains=tacoIdentifier
syntax region tacoInterp start=/\${/ end=/}/ contained contains=tacoKeyword,tacoType,tacoString,tacoNumber,tacoIdentifier,tacoRecord,tacoOperator

syntax region tacoString start=/"/ end=/"/ contains=tacoInterp
syntax match tacoNumber /\v\d+/

syntax match tacoIdentifier /\v[a-z_][a-zA-Z0-9_]*/
syntax match tacoRecord /\v[A-Z][a-zA-Z0-9_]*/
syntax match tacoOperator /[\?\.:=!+\-*\/\<\>/\&\|]/
" syntax match tacoChar /[=:\.]/
syntax match tacoBlock /[(){}\[\],]/
syntax match tacoAttribute /@[a-zA-Z_][a-zA-Z0-9_]*/

highlight link tacoKeyword Keyword
highlight link tacoType Type
highlight link tacoComment Comment
highlight link tacoString String
highlight link tacoNumber Number
highlight link tacoRecord Identifier
highlight link tacoIdentifier @property
highlight link tacoInterp Directory
highlight link tacoChar Label
highlight link tacoBlock Delimiter
highlight link tacoOperator Delimiter
highlight link tacoConstant Constant
highlight link tacoAttribute Special

let b:current_syntax = "taco"
