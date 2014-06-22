""" Python config file

if exists("b:did_ftfile") | finish | endif
let b:did_ftfile = 1

let g:pylint_onwrite = 1
let g:pylint_show_rate = 0
let g:pylint_cwindow = 1
let g:pylint_signs = 1

inoremap <Nul> <C-x><C-o>
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
setlocal cindent
setlocal textwidth=80
setlocal formatoptions-=t
setlocal complete+=t

" Trim trailing whitespace
"au BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Best syntax highlight
let python_highlight_all=1
let python_highlight_exceptions=1
let python_highlight_builtins=1

" Run python script
map <leader>r :!./%<cr>
map <leader>mt :!ctags -R . <cr>

" PyLint
" compiler pylint

" Generate tags with: ctags -R -f ~/.vim/tags/python24.ctags /usr/lib/python2.4/
" ctrl-[ to go to the tag under the cursor, ctrl-T to go back.
set tags+=$HOME/.vim/tags/python27.ctags
set tags+=$HOME/.vim/tags/python33.ctags
