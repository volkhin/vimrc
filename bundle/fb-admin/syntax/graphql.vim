" Vim syntax file
" Language: GraphQL
" Maintainer: Dan Schafer
" Latest Revision: 8 May 2014

if exists("b:current_syntax")
  finish
endif

syn keyword GraphQLQueryKeyword Query Mutation nextgroup=GraphQLQueryName skipwhite
syn match GraphQLQueryName '[A-Z][A-Za-z]*' nextgroup=GraphQLTypeHintDelimiter,GraphQLFieldSet skipwhite
syn match GraphQLTypeHintDelimiter ':' nextgroup=GraphQLTypeHint skipwhite
syn match GraphQLTypeHint '[A-Z][A-Za-z]*' nextgroup=GraphQLQueryContainer skipwhite

syn keyword GraphQLFragmentKeyword QueryFragment nextgroup=GraphQLFragmentName skipwhite
syn match GraphQLFragmentName '[A-Z][A-Za-z]*' nextgroup=GraphQLFragmentTypeHintDelimiter skipwhite
syn match GraphQLFragmentTypeHintDelimiter ':' nextgroup=GraphQLFragmentTypeHint skipwhite
syn match GraphQLFragmentTypeHint '[A-Z][A-Za-z]*' nextgroup=GraphQLFieldSet skipwhite

syn region GraphQLQueryContainer start="{" end="}" fold contains=GraphQLRootCall
syn match GraphQLRootCall '[a-z_]*' nextgroup=GraphQLRootCallArgument containedin=GraphQLQueryContainer
syn region GraphQLRootCallArgument start="(" end=")" contains=GraphQLCallVariable,GraphQLCallLiteral nextgroup=GraphQLFieldSet skipwhite containedin=GraphQLQueryContainer
syn match GraphQLCallLiteral '[A-Za-z0-9]' contained
syn region GraphQLCallVariable start="<" end=">" contains=GraphQLCallVariableName containedin=GraphQLQueryContainer
syn match GraphQLCallVariableName '[A-Za-z_]*' containedin=GraphQLCallVariable containedin=GraphQLCallVariable

syn region GraphQLFieldSet start="{" end="}" fold contains=GraphQLField,GraphQLFragmentRef,GraphQLInlineComment,GraphQLBlockComment,GraphQLAsKeyword,GraphQLAliasName
syn match GraphQLFieldDelimiter ',' nextgroup=GraphQLField,GraphQLFragmentRef skipwhite containedin=GraphQLFieldSet
syn match GraphQLCallStart '\.' nextgroup=GraphQLCall containedin=GraphQLFieldSet
syn match GraphQLCall '[a-z_]*' nextgroup=GraphQLCallArgument containedin=GraphQLFieldSet
syn match GraphQLAliasName ' [A-Za-z_]*'hs=s+1,ms=s+1 nextgroup=GraphQLFieldDelimiter,GraphQLFieldSet skipwhite containedin=GraphQLFieldSet
syn match GraphQLField '[a-z_]*' nextgroup=GraphQLFieldDelimiter,GraphQLFieldSet,GraphQLCallStart,GraphQLAsKeyword skipwhite containedin=GraphQLFieldSet
syn keyword GraphQLAsKeyword as nextgroup=GraphQLAliasName skipwhite
syn match GraphQLFragmentRef '@[A-Z][A-Za-z_]*' nextgroup=GraphQLFieldDelimiter skipwhite containedin=GraphQLFieldSet
syn region GraphQLCallArgument start="(" end=")" contains=GraphQLCallVariable,GraphQLCallLiteral nextgroup=GraphQLCallStart,GraphQLField,GraphQLFieldSet skipwhite containedin=GraphQLFieldSet

syn region GraphQLBlockComment start="/\*" end="\*/" fold
syn match GraphQLInlineComment '\/\/.*$'

let b:current_syntax = "graphql"

hi def link GraphQLQueryKeyword Structure
hi def link GraphQLFragmentKeyword Structure
hi def link GraphQLQueryName Function
hi def link GraphQLFragmentName Function
hi def link GraphQLTypeHint Constant
hi def link GraphQLFragmentTypeHint Constant
hi def link GraphQLRootCall Repeat
hi def link GraphQLCall Repeat
hi def link GraphQLCallVariableName Identifier
hi def link GraphQLCallLiteral String
hi def link GraphQLField Keyword
hi def link GraphQLAsKeyword Operator
hi def link GraphQLAliasName Identifier
hi def link GraphQLFragmentRef Type
hi def link GraphQLBlockComment Comment
hi def link GraphQLInlineComment Comment
