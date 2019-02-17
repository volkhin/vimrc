" script that does omnicompletion of usernames on a system
" Author: ccheever
"
" notes: won't work on systems where ls-ing /home/ doesn't give 
" a list of usernames (most Mac OS X systems, many unices, etc.)
"
" copied blatantly from the example omnicompletion script
"
" also sets the omnicompletion function explicitly which is maybe 
" a bad ideea
fun! CompleteUsernames(findstart, base)
  if a:findstart
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start
  else
    " find months matching with "a:base"
    let res = []
    for m in split(system("ls /home/"))
      if m =~ '^' . a:base
    call add(res, m)
      endif
    endfor
    return res
  endif
endfun

fun! SetupUsernameCompetion()
    source $HOME/.vim/omnitab.vim
    set completefunc=CompleteUsernames
    set omnifunc=CompleteUsernames
    goto 1
    read $HOME/svn-commit-template.txt
    goto 1
    filetype plugin indent on
    let g:omniCompletion = 1
endfun

filetype plugin indent on

call SetupUsernameCompetion()

