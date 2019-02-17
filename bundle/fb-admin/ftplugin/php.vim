" Vim ftplugin file
" Language:     PHP
" Maintainer:   Max Wang <mwang@fb.com>

setl iskeyword+=$

" Make gf work with our includes of the form $root.'/local/path.php'
setl includeexpr=substitute(v:fname,'^/','','')
