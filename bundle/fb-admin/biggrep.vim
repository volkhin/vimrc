" A function for executing BigGrep from within vim.
" To use it, put 'source ~admin/scripts/vim/biggrep.vim' in your .vimrc.
" Run ':TBGS some_string' to search for a string in www/trunk.
" Similar for TBGR, FBGS, and FBGR.
" Bonus! [TF]BGW will search for the word under the cursor.
"
" Of course, you can press enter on the results to jump to them.
" If pressing Enter in the quickfix list doesn't work for you, add this to your
" .vimrc:
"    au BufReadPost quickfix map <buffer> <Enter> :.cc<CR> 
"
" This works only when your working directory is a descendant of the www or
" fbcode or android root.
"
" @author dreiss

function! BigGrep(corpus, query, search)
  let subst = ""

  " Attempts to reconcile a git vs mercurial repo by checking for errors
  let corpus_path = system('git rev-parse --show-cdup')
  if v:shell_error
    let corpus_path = system('hg root')
    let corpus_path = substitute(corpus_path, '\n$', '', '').'/'
  else
    let corpus_path = substitute(corpus_path, '\n$', '', '')
  endif

  let fbsource = corpus_path =~ "fbsource"

  let fbsource = 0
  let corpus_path = ""

  if a:corpus == "t"
    if fbsource
      let corpus_path = corpus_path . "www/"
    endif
    let subst = "s:^www/:".corpus_path.":"
  elseif a:corpus == "f"
    if fbsource
      let corpus_path = corpus_path . "fbcode/"
    endif
    let subst = "s:^fbsource/fbcode/:".corpus_path.":"
  elseif a:corpus == "a"
    if fbsource
      let corpus_path = corpus_path . "android/"
    endif
    let subst = "s:^android/:".corpus_path.":"
  endif

  let old_grep = &grepprg
  let old_gfmt = &grepformat

  let &grepprg = a:corpus . "bg" . a:query . " '$*' \\| sed -e '".subst."'"
  let &grepformat = "%f:%l:%c:%m"
  " The GNU Bourne-Again SHell has driven me to this.
  let search = substitute(a:search, "'", "'\"'\"'", "g")
  execute "silent grep! " . search
  copen
  execute "normal \<c-w>J"
  redraw!

  let &grepprg = old_grep
  let &grepformat = old_gfmt
endfunction

command! TBGW call BigGrep("t", "s", expand("<cword>"))
command! -nargs=1 TBGS call BigGrep("t","s",<q-args>)
command! -nargs=1 TBGR call BigGrep("t","r",<q-args>)

command! FBGW call BigGrep("f", "s", expand("<cword>"))
command! -nargs=1 FBGS call BigGrep("f","s",<q-args>)
command! -nargs=1 FBGR call BigGrep("f","r",<q-args>)

command! ABGW call BigGrep("a", "s", expand("<cword>"))
command! -nargs=1 ABGS call BigGrep("a","s",<q-args>)
command! -nargs=1 ABGR call BigGrep("a","r",<q-args>)
