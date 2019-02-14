" Omni completion for Facebook commit messages
" Author: dreiss

function! CommitMessageOmniComplete(findstart, base)
  " Grab the text leading up to the cursor and the current section.
  let uptohere = getline('.')[:col('.')-2]
  let section = ""
  if uptohere =~ ":"
    let section = substitute(uptohere, ':.*', '', '')
    let section = substitute(section, ' ', '', 'g')
  endif
  " Confirm that we are in a section that we can complete.
  if !has_key(s:callbacks, section)
    return a:findstart ? -1 : []
  endif


  " Have to return the index of the term we want to complete.
  if a:findstart
    " We want to start on the first non-space after the last comma or colon.
    let prefix = substitute(uptohere, '\([,:] *\)[^,:]*$', '\1', '')
    return strlen(prefix)

  " Have to return the actual completions.
  else
    return s:callbacks[section](a:base)

  endif
endfun


let s:callbacks = {}

function s:callbacks.Reviewers(base)
  let results = []
  for line in s:ReadFile("people")
    let [unixname, label] = split(line, '\t')
    if unixname =~ '^' . a:base
      call add(results, {
            \'word': unixname,
            \'menu': label,
      \})
    endif
  endfor
  return results
endfunction

function s:callbacks.Tags(base)
  let results = []
  for line in s:ReadFile("tags")
    if line =~ '^' . a:base
      call add(results, line)
    endif
  endfor
  return results
endfunction

function s:callbacks.TaskID(base)
  if a:base =~ '^#'
    let base = a:base[1:]
    let prepend = "#"
  else
    let base = a:base
    let prepend = ""
  endif

  let results = []
  for line in s:ReadFile("tasks")
    let [task, title] = split(line, '\t')
    if task =~ '^' . base
      call add(results, {
            \'word': prepend . task,
            \'menu': title,
      \})
    endif
  endfor
  return results
endfunction

function s:callbacks.CC(base)
  let results = []
  for line in s:ReadFile("everything")
    let [id, type, name] = split(line, '\t')
    "let [type, name] = split(line, '\t')
    if name =~ '^' . a:base
      call add(results, {
            \'menu': type,
            \'word': id . " {{{" . name . "}}}, ",
            \'abbr': name,
      \})
            "\'word': name,
    endif
  endfor
  return results
endfunction
" This doesn't really work yet.
unlet s:callbacks.CC


function! s:ReadFile(name)
  return readfile($HOME . "/.omnicommit/" . a:name . ".dat")
endfunction


function! CommitMessageCleverTab()
  " Pop-up menu is visible?  Complete forward!
  if pumvisible()
    return "\<C-N>"
  endif
  " At the start of a line?  Pop-up completions!
  if getline('.') =~ '^[A-Za-z ]*:'
    return "\<C-X>\<C-O>"
  endif
  " BO-RING!
  return "\<Tab>"
endfunction

function! CommitMessageCleverShiftTab()
  " Pop-up menu is visible?  Complete backward!
  if pumvisible()
    return "\<C-P>"
  endif
  " BO-RING!
  return "\<S-Tab>"
endfunction

function! CommitMessageCleverCR()
  " Prepare a command to delete trailing whitespace.
  " (Which we might have created).
  let trailing_spaces = substitute(getline('.'), '^.\{-}\( *\)$', '\1', '')
  let backspaces = substitute(trailing_spaces, ' ', "\<BS>", 'g')

  " Pop-up menu is visible?  Accept and move on!
  if pumvisible()
    return "\<C-Y>\<Down>\<Down>\<End> "
  endif
  " Empty line after an empty field?  Delete it and move on!
  if getline('.') == '' && line('.') > 1 && getline(line('.')-1) =~ '^[A-Za-z ]*: \?$'
    return "\<Esc>\<Up>3ddA "
  endif
  " Two empty lines in a row?  Trim and move on!
  if getline('.') == '' && line('.') > 1 && getline(line('.')-1) == ''
    return "\<Esc>\<Up>2ddjA "
  endif
  " Finished with a field?  Move on!
  if line('.') == 1 || getline('.')  =~ '^[A-Za-z ]*:.*[^ ]'
    return "\<Down>\<Down>\<End> "
  endif
  return backspaces . "\<CR>"
endfunction


function! CommitMessageSetTurbo()
  inoremap <Tab> <C-R>=CommitMessageCleverTab()<CR>
  inoremap <S-Tab> <C-R>=CommitMessageCleverShiftTab()<CR>
  inoremap <CR> <C-R>=CommitMessageCleverCR()<CR>
endfunction


if exists("g:omnicommit_turbo")
  au FileType gitcommit call CommitMessageSetTurbo()
  au FileType svncommit call CommitMessageSetTurbo()
endif

au FileType gitcommit set omnifunc=CommitMessageOmniComplete
au FileType svncommit set omnifunc=CommitMessageOmniComplete
