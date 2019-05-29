" Print link for opening
" function! Open()
  " " let f = expand( "%:f" )
  " " let @* = substitute(f, ".*/fbcode", "https://phabricator.intern.facebook.com/diffusion/FBS/browse/master/fbcode/", "g") . "$" . line('.') . "?view=highlighted"
  " echo expand('%:p:s?.*/fbcode/?https://phabricator.fb.com/diffusion/FBCODE/browse/master/?:s?.*/configerator/?blamec ?:s?.*/configerator-hg/?blamec ?') . '%24' . line('.')
" endfunction
" command! -nargs=* Open call Open()


if filereadable('/etc/fbwhoami')
    " Generate URL to view section of code for sharing
    function! Open() range
      let fullpath = resolve(expand('%:p'))
      let linestr = line('.')
      if a:lastline - a:firstline > 0
          let linestr = a:firstline . "-" . a:lastline
      endif

      let filepos = expand("%:p") . ":" . linestr
      let urlcmd = "diffusion " . filepos
      echom system(urlcmd . "|" . "fburl" . " 2> /dev/null")[:-2]
    endfunction

    " nnoremap <leader><leader>d :call Open()<CR>
    " vnoremap <leader><leader>d :call Open()<CR>
    command! -range Open :<line1>,<line2>call Open()
endif
