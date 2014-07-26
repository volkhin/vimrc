""" main config for all programming languages

map <buffer> <leader>r :!g++ -Wall -DVOLKHIN % -o %:r.out  && ./%:r.out <cr>

function! SwitchSourceHeader()
  "update!
  if (expand ("%:e") == "cpp")
    find %:t:r.h
  else
    find %:t:r.cpp
  endif
endfunction

nmap ,q :call SwitchSourceHeader()<CR>
