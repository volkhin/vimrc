" Artem Volkhin, artem@volkhin.com

" Vundle {{{
set nocompatible " enable vim features

" set runtimepath^=$HOME/.vim/bundle/fb-admin
" set runtimepath+=$HOME/.vim/bundle/fb-admin/after
source $HOME/.vim/bundle/fb-admin/biggrep.vim
source $HOME/.vim/bundle/fb-admin/fbvim.vim

filetype off
set rtp+=~/.vim/bundle/vundle.vim
call vundle#begin()

Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'ambv/black'
Plugin 'chriskempson/base16-vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'edkolev/promptline.vim'
Plugin 'elzr/vim-json'
Plugin 'fb-admin', {'pinned': 1}
Plugin 'haya14busa/incsearch.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'jlfwong/vim-arcanist'
Plugin 'jlfwong/vim-mercenary'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-signify'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'pignacio/vim-yapf-format'
Plugin 'plasticboy/vim-markdown'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'volkhin/vim-colors-solarized'
Plugin 'vundleVim/vundle.vim'
Plugin 'rhysd/vim-clang-format'

" not used anymore

" Plugin 'Lokaltog/vim-powerline'
" Plugin 'Shougo/neosnippet-snippets'
" Plugin 'Shougo/neosnippet.vim'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'alfredodeza/chapa.vim'
" Plugin 'chase/vim-ansible-yaml'
" Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'edkolev/tmuxline.vim'
" Plugin 'fatih/vim-go'
" Plugin 'jcfaria/Vim-R-plugin'
" Plugin 'jlanzarotta/bufexplorer'
" Plugin 'kchmck/vim-coffee-script'
" Plugin 'klen/python-mode'
" Plugin 'ludovicchabant/vim-lawrencium'
" Plugin 'mileszs/ack.vim'
" Plugin 'msanders/snipmate.vim'
" Plugin 'mustache/vim-mustache-handlebars'
" Plugin 'scrooloose/nerdtree'
" Plugin 'scrooloose/syntastic'
" Plugin 'tpope/vim-dispatch'
" Plugin 'tpope/vim-haml'
" Plugin 'vim-scripts/taglist.vim'
" Plugin 'wavded/vim-stylus'
" Plugin 'xolox/vim-misc'
" Plugin 'xolox/vim-session'

call vundle#end()
filetype plugin indent on
syntax on
" }}}
" Backup and swap files {{{

set backup " make backup file and leave it around
set backupdir=~/.vim/backups//
set backupskip+=svn-commit.tmp,svn-commit.[0-9]*.tmp
set swapfile
set directory=~/.vim/swap//
set undofile " enable persistent undo
set undodir=~/.vim/undo// " store undofiles in a tmp dir
set history=400 " history length
set viminfo+=h " save history

" }}}
" Sessions {{{

set ssop-=blank " dont save blank window
set ssop-=options " dont save options

" }}}
" Buffer options {{{

set hidden " hide buffers when they are abandoned
set autoread " auto reload changed files
set autowrite " automatically save before commands like :next and :make

" }}}
" Display options {{{

" set noerrorbells " no bells in terminal
set cmdheight=1
set laststatus=2 " always show status line
set lazyredraw " lazy buffer redrawing
set linebreak " break lines by words
set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,eol:$,nbsp:~
set matchpairs+=<:> " Make < and > match as well
set matchtime=3 " Show matching brackets for only 0.3 seconds ! NEED cpoptions+=m
set nolist " hide tabs and EOL chars
set nostartofline
set nowrap " don't wrap lines
set number " show line numbers
set numberwidth=1 " Keep line numbers small if it's shown
set ruler " show cursor position
set scrolloff=4 " min symbols bellow cursor
set showcmd " show normal mode commands as they are entered
set showmatch " flash matching delimiters
set showmode " show editing mode in status (-- INSERT --)
set sidescroll=4
set sidescrolloff=8
set title " show file name in window title
set visualbell " mute error bell

" }}}
" Tabs abd spaces {{{

set autoindent " copy indent from previous line
set smartindent " enable nice indent
set smarttab " isdent using shiftwidth"
set shiftwidth=2 " two spaces per indent
set tabstop=2 " number of spaces per tab in display
set softtabstop=2 " number of spaces per tab when inserting
set expandtab " substitute spaces for tabs
set shiftround " drop unused spaces

" }}}
" Search options {{{

set hlsearch " Highlight search results
set ignorecase " Ignore case in search patterns
set smartcase " Override the 'ignorecase' option if the search pattern contains upper case characters
set incsearch " While typing a search command, show where the pattern

" }}}
" Localization {{{

set langmenu=none " Always use english menu
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
set spelllang=en,ru
set encoding=utf-8 nobomb
set fileencodings=utf-8,cp1251,koi8-r,cp866
set termencoding=utf-8

" }}}
" Folding {{{

set foldenable " Enable code folding
set foldmethod=indent " Fold on marker
set foldnestmax=10
set foldlevelstart=10 " 0 - hide all, 10/10 - unfold everything

" }}}
" Color options {{{

set background=dark
" let base16colorspace=256
" colorscheme solarized
colorscheme base16-default-dark
" set t_Co=256

" }}}
" Highlight long lines {{{

set textwidth=80
if exists('+colorcolumn')
    hi ColorColumn term=reverse
    set colorcolumn=+1
endif

" }}}
" Misc {{{

set backspace=indent,eol,start " backspace removes indents, newlines and old tex
set wildmenu
" set clipboard+=unnamed " enable x-clipboard
set virtualedit=all " on virtualedit for all mode
set tags=tags;/ " search up the directory tree for tags
set shortmess=atToOIW
set confirm

set ttyfast
" set mousehide
set mouse=a
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif

" set complete=".,k,b"
set completeopt=menu,preview
set infercase
set whichwrap=b,s,<,>,[,],l,h
set ttimeoutlen=50

" }}}

" Functions {{{

fun! rc#Search()
    let word = input("Search for: ", expand("<cword>"))
    execute ':Ag '.word
endfun

" Auto cwindow height
fun! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfun

" Print link for opening
function! Open()
  " let f = expand( "%:f" )
  " let @* = substitute(f, ".*/fbcode", "https://phabricator.intern.facebook.com/diffusion/FBS/browse/master/fbcode/", "g") . "$" . line('.') . "?view=highlighted"
  echo expand('%:p:s?.*/fbcode/?https://phabricator.fb.com/diffusion/FBCODE/browse/master/?:s?.*/configerator/?blamec ?:s?.*/configerator-hg/?blamec ?') . '%24' . line('.')
endfunction
command! -nargs=* Open call Open()

command! FZFfbcode call fzf#run({
\  'source':  'find ~/fbcode/{fblearner/flow/projects/dper,fblearner/flow/projects/dper3,caffe2/caffe2/} | sed "s/^\/home\/volkhin\/fbcode\///"',
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})

command! FZFMru call fzf#run({
\  'source':  oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})


let repo_path = system('hg root')
let repo_initial = 'f'
if repo_path =~# 'configerator'
    let repo_initial = 'c'
elseif repo_path =~# 'www'
    let repo_initial = 't'
elseif repo_path =~# 'fbcode'
    let repo_initial = 'f'
endif

command! -nargs=* BGS
  \ call fzf#vim#grep(
  \   g:repo_initial . 'bgs --color=on --ignore-case '.<q-args>.
  \ '| sed "s,^[^/]*/,,"' .
  \ '| sed "s#^#$(hg root)/#g"', 1,
  \   fzf#vim#with_preview('right:35%')
  \ )
command! -nargs=* BGF
  \ call fzf#vim#grep(
  \ g:repo_initial . 'bgf --color=on --ignore-case '.<q-args>.
  \ '| sed "s,^[^/]*/,,"' .
  \ '| sed "s#^#$(hg root)/#g"', 1,
  \ fzf#vim#with_preview('right:35%'),
  \ )
nmap <leader>s :BGS expand("<cword>")<CR>

command! ShowTrailingSpaces /\S\zs\s\+$

command! CloseHiddenBuffers call s:CloseHiddenBuffers()
function! s:CloseHiddenBuffers()
  let open_buffers = []

  for i in range(tabpagenr('$'))
    call extend(open_buffers, tabpagebuflist(i + 1))
  endfor

  for num in range(1, bufnr("$") + 1)
    if buflisted(num) && index(open_buffers, num) == -1
      exec "bdelete ".num
    endif
  endfor
endfunction

" }}}
" Autocommands {{{

if has("autocmd")
    " augroup updateFile
      " au!
      " au BufEnter * checktime
    " augroup END

    augroup custom_fswitch
      au!
      au BufEnter *.cc let b:fswitchdst  = 'h,hpp'
      au BufEnter *.h let b:fswitchdst  = 'cpp,cc,c'
    augroup END

    augroup vimrcEx
        au!

        " Auto reload vim settins
        " au BufWritePost rc.vim echo "reloaded settings from ~/.vimrc"
        " au BufWritePost rc.vim source ~/.vimrc

        " Restore cursor position
        " au BufReadPost * if line("'\"") <= line("$") | exe line("'\"") | endif

        " Save current open file when window focus is lost
        " au FocusLost * silent! :wa

        " quickfix and location list height
        au FileType qf call AdjustWindowHeight(3, 6)
        au FileType ll call AdjustWindowHeight(3, 6)
    augroup END

    augroup fbgrep
      au!
      au BufEnter *.php map <C-\> :TBGW<CR>
      au BufEnter *.py map <C-\> :FBGW<CR>
      au BufEnter *.cpp map <C-\> :FBGW<CR>
      au BufEnter *.cc map <C-\> :FBGW<CR>
      au BufEnter *.h map <C-\> :FBGW<CR>
      au BufEnter *.cinc map <C-\> :CBGW<CR>
    augroup END

    augroup highlightActiveWindow
      au!
      au WinEnter * set cursorline
      au WinLeave * set nocursorline
    augroup END

    augroup fb_filetypedetect
      au!
      au BufRead,BufNewFile *.cabal  setfiletype cabal
      au BufRead,BufNewFile *.hsc    setfiletype haskell
      au BufRead,BufNewFile *.phpt   setfiletype php

      au BufRead,BufNewFile *.thrift setfiletype thrift

      au BufRead,BufNewFile *.txt    setfiletype text
      au BufRead,BufNewFile README   setfiletype text

      " au BufRead,BufNewFile BUCK       setfiletype python
      " au BufRead,BufNewFile TARGETS    setfiletype python

      " au BufRead,BufNewFile *.smcprops setfiletype python
      " au BufRead,BufNewFile *.cconf    setfiletype python
      " au BufRead,BufNewFile *.mcconf   setfiletype python
      " au BufRead,BufNewFile *.cinc     setfiletype python
      " au BufRead,BufNewFile *.ctest    setfiletype python
      " au BufRead,BufNewFile *.tw       setfiletype python
      " au BufRead,BufNewFile *.thrift-cvalidator   setfiletype python
    augroup END
endif

" }}}
" Plugins setup {{{

" Neocomplete
let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_ignore_case = 0

" CtrlP
let g:ctrlp_custom_ignore = '(node_modules|_build|buck-out)'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_root = ''

" LogiPat
let g:loaded_logipat = 1 " disable :ELP command which shadows :Explore

" Snipmate
" let snippets_dir = substitute(globpath(&rtp, 'snippets/'), "\n", ',', 'g')
let snippets_dir = "~/.vim/snippets"

" Markdown
let g:vim_markdown_initial_foldlevel=10

" Syntasctic
let g:syntastic_python_checkers=['flake8']
" let g:syntastic_python_checkers=['pyflakes']"
let g:syntastic_python_python_exec = '/usr/local/fbcode/gcc-4.9-glibc-2.20-fb/bin/python2.7'
if &ft != 'php'
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list=1
  let g:syntastic_check_on_open = 0
  let g:syntastic_check_on_wq = 1
  let g:syntastic_quiet_messages = { "type": "style" }
endif
let g:syntastic_mode_map = {
      \ 'passive_filetypes': ["java", "cpp", "php", "lua", "text"]
      \ }

let g:syntastic_lua_checkers = ["luac", "flychecklint"]
let g:syntastic_aggregate_errors = 1

" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: "\<TAB>"

imap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" yapf
let g:yapf_format_yapf_location = '/home/volkhin/fbcode/third-party2/yapf/0.10.0/gcc-4.9-glibc-2.20-fb/cf40c91/lib/python/'

" vim-go
" let g:go_snippet_engine = "neosnippet"
let g:go_fmt_command = "goimports"
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_structs = 1

" Unite
call unite#custom#source('file,file/new,buffer,file_rec',
      \ 'matchers', 'matcher_fuzzy')

" NERDCommenter
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
map <leader>cc <Plug>NERDCommenterComment
map <leader>cu <Plug>NERDCommenterUncomment
map <leader>ci <Plug>NERDCommenterInvert

let g:gitgutter_max_signs = 1000

" airline
" if !exists('g:airline_symbols')
  " let g:airline_symbols = {}
" endif

" let g:airline_left_sep = ' ' " ''
" let g:airline_left_alt_sep = ' ' " ''
" let g:airline_right_sep = ' ' " ''
" let g:airline_right_alt_sep = ' ' " ''
" let g:airline_symbols.branch = ' ' " ''
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.readonly = ' ' " ''
" let g:airline_symbols.linenr = ' ' " ''
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = 'Ξ'

let g:airline_skip_empty_sections = 0

let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
" let g:airline#extensions#default#layout = [
    " \ [ 'a', 'b', 'c' ],
    " \ [ 'z', 'error', 'warning' ]
    " \ ]
" let g:airline_section_z = "%n% %#__accent_bold#%{g:airline_symbols.linenr}%#__accent_bold#%l%#__restore__#%#__restore__#:%v"
let g:airline_section_x = ""
let g:airline_section_y = ""
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#keymap#enabled = 0
let g:airline#extensions#hunks#enabled = 0

let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_buffers = 0

" Promptline
" let g:promptline_theme = 'base16_default'
      " \'c' : [ promptline#slices#vcs_branch(), "$(_dotfiles_scm_info)" ],
let g:promptline_preset = {
      \'a': [ promptline#slices#host(), promptline#slices#user() ],
      \'b': [ promptline#slices#cwd() ],
      \'c' : [ "$(_dotfiles_scm_info)" ],
      \'z': [ '\t' ],
      \'warn' : [ promptline#slices#last_exit_code() ]}

" let g:pymode = 1
" let g:pymode_warnings = 1
" let g:pymode_lint_checkers = ['pep8', 'mccabe']
" let g:pymode_python = 'python3'

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_error_symbol = 'x'
let g:ycm_warning_symbol = '!'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_confirm_extra_conf = 0
" let g:ycm_global_ycm_extra_conf = '/home/volkhin/fbcode/.ycm_extra_conf.py'
let g:ycm_use_clangd = "Never"
let g:ycm_extra_conf_globlist = ['~/*', '/data/users/volkhin/fbcode/*']
let g:ycm_open_loclist_on_ycm_diags = 1
let g:ycm_always_populate_location_list = 1
" YCM must use the same Python version it's linked against
" let g:ycm_path_to_python_interpreter = '/data/users/volkhin/fbsource/fbcode/third-party-buck/gcc-5-glibc-2.23/build/python/2.7/bin/python2.7'
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python3'

let g:fuf_timeFormat = ''

" }}}
" Hotkeys {{{

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>= <Plug>AirlineSelectNextTab

map <leader>tt <esc>:tabnew<CR>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
 " Use Ag over Grep
 set grepprg=ag\ --vimgrep
 set grepprg=ag\ --nogroup\ --nocolor\ --column
endif

nnoremap j gj
nnoremap k gk

" Neosnippets
" Plugin key-mappings.
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)

" Drop hightlight search result
noremap <leader><space> :nohls<CR>
noremap <space> za

" Navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Quickfix window
nnoremap <silent> <leader>ll :ccl<CR>:lcl<CR>
nnoremap <silent> <leader>nn :cwindow<CR>:cn<CR>
nnoremap <silent> <leader>pp :cwindow<CR>:cp<CR>

" Delete all buffers
nmap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<cr>

" Search
nmap <leader>a :call rc#Search()<CR>
" nmap <C-b> :History<CR>
" nmap <C-b> :CtrlPMRU<CR>
nmap <C-b> :BufExplorer<CR>
" nmap <C-b> :Unite buffer<CR>
" nmap <C-b> :FufBuffer<CR>
" nmap <C-b> :FZFMru<CR>
nmap <C-p> :FZFfbcode<CR>
" nnoremap <C-p> :exe ':CtrlP '.g:ctrlp_root.'<CR>'
" nmap <C-b> :CtrlPBuffer<CR>

" Incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Sessions
map <leader>ss <ESC>:mksession! ~/.vim/session<CR>
map <leader>sl <ESC>:source ~/.vim/session<CR>

nnoremap <silent> <leader>f :NERDTreeFind<CR>
nnoremap <silent> <leader>F :NERDTreeFocus<CR>
nnoremap <silent> <leader>x :NERDTreeToggle<CR>
nnoremap <silent> <leader>X :TagbarOpenAutoClose<CR>
nnoremap <silent> <leader>e :Explore<CR>

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

"
nnoremap <leader>y :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>Y :YcmDiags<CR>
nnoremap <leader>u :SyntasticCheck<CR>
nnoremap <silent> <leader>pg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <silent> <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <silent> <leader>pc :YcmCompleter GoToDeclaration<CR>
nnoremap <silent> <leader>i :YcmCompleter GetType<CR>
nnoremap <silent> <leader>I :YcmCompleter GetDoc<CR>
nnoremap <silent> gd :YcmCompleter GoToDefinitionElseDeclaration<CR>

map <Leader>k :pyxfile ~/.vim/bundle/fb-admin/clang-format.py<CR>
map <Leader>K :%pyxfile ~/.vim/bundle/fb-admin/clang-format.py<CR>
nnoremap <silent> <Leader>q :FSHere<CR>

" }}}

set secure " must be written at the last
" vim: fdm=marker
