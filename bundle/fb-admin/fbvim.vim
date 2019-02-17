let s:fbvim_py_path = '/home/volkhin/.vim/bundle/fb-admin/fbvimpylib/fbvim.py'

python << ENDPYTHON
import imp
import vim
import sys
import os

__fbvim_path = vim.eval('s:fbvim_py_path')
sys.path.append(os.path.dirname(__fbvim_path))

fbvim = imp.load_source('fbvim', __fbvim_path)
ENDPYTHON

" take the current vim state and save it to a session file named by the current
" repo (e.g. www) and the current branch
command! FBVimSaveSession python fbvim.save_session()

" look at the current repo (.e.g www) and current branch, and restore the last
" saved session if it exists.
command! FBVimLoadSession python fbvim.load_session()

" run a query against the mural_server for tags (only works in www)
command! FBVimMuralSearch python fbvim.tags_mural()
" same as above, but use the current word under the cursor
command! FBVimMuralSearchCurrentWord python fbvim.tags_mural(True)
" go "back" when navigating tags (same as built-in Ctrl-T)
command! FBVimPopTagStack python fbvim.pop_tag_stack()

" run a big grep query on the current repo (automatically maps www -> tbgs
" etc.)
command! FBVimBigGrep python fbvim.big_grep()

" search for file in the current repo
command! FBVimFilenameSearch python fbvim.repo_file_typeahead()

" search against hack server
command! FBVimHackSearch python fbvim.tags_hack()

" search against hack server using current word
command! FBVimHackSearchCurrentWord python fbvim.tags_hack(True)

