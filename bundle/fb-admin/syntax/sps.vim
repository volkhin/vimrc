" Vim syntax file
" Language: sps

if exists("b:current_syntax")
  finish
endif

syn keyword langKeywords deny allow if all true false in not return
syn keyword langBindings this that viewer viewer_context null
syn keyword langOperators in let
syn keyword declKeywords node implements interface prop perm edge extend constants enum alias sources externals
syn keyword nativeTypes String Int Set Any Bool Pair

syn match comment '//.*'
syn match string '\'.[^\']*\''
syn match annotation '@[a-zA-Z0-9_]*'

hi def link annotation Identifier
hi def link declKeywords PreProc
hi def link langKeywords Statement
hi def link langOperators Operator
hi def link langBindings Identifier
hi def link nativeTypes Type
hi def link comment Comment
