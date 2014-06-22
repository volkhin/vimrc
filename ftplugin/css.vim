""" main config for all programming languages

setlocal nowrap
setlocal number

" Complete option
setlocal complete=""
setlocal complete+=.
setlocal complete+=k
setlocal complete+=b
setlocal completeopt-=preview
setlocal completeopt+=longest
setlocal tabstop=4
setlocal softtabstop=4

setlocal foldmethod=marker
setlocal foldlevel=2
setlocal foldmarker={,}
nnoremap <buffer> <localleader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
inoremap <buffer> {<cr> {}<left><cr>.<cr><esc>kA<bs><space><space><space><space>
