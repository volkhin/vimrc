""" main config for all programming languages

" map <buffer> <leader>r :!g++ -Wall -DVOLKHIN % -o %:r.out  && ./%:r.out <cr>

" if !exists("*SwitchSourceHeader")
" function! SwitchSourceHeader()
  " "update!
  " if (expand ("%:e") == "cpp")
    " find %:t:r.h
  " else
    " find %:t:r.cpp
  " endif
" endfunction
" endif
" nmap <Leader>q :call SwitchSourceHeader()<CR>

setlocal ts=2 sts=2 sw=2

set foldmethod=marker
set foldmarker={,}
