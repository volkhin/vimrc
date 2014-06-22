""" main config for all programming languages

map <buffer> <leader>r :!g++ -Wall -DVOLKHIN % -o %:r.out  && ./%:r.out <cr>

setlocal nowrap
setlocal number
setlocal foldlevelstart=99
setlocal foldlevel=99
setlocal foldmethod=indent

" Complete option
setlocal complete=""
setlocal complete+=.
setlocal complete+=k
setlocal complete+=b
setlocal completeopt-=preview
setlocal completeopt+=longest
setlocal tabstop=4
setlocal softtabstop=4

function! SwitchSourceHeader()
  "update!
  if (expand ("%:e") == "cpp")
    find %:t:r.h
  else
    find %:t:r.cpp
  endif
endfunction

nmap ,q :call SwitchSourceHeader()<CR>
