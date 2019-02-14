" A function for executing git grep from within vim.
" To use it, put 'source ~admin/scripts/vim/gitgrep.vim' in your .vimrc.
" Run ':GG some_regexp' to search.  (Only | needs to be escaped.)
"
" @author dreiss

function! GitGrep(regex)
  let old_grep = &grepprg
  let &grepprg = "git grep -n '$*' "
  " The GNU Bourne-Again SHell has driven me to this.
  let search = substitute(a:regex, "'", "'\"'\"'", "g")
  execute "silent grep! ".search
  copen
  execute "normal \<c-w>J"
  redraw!
  let &grepprg = old_grep
endfunction
command! -nargs=+ GG call GitGrep(<q-args>)
