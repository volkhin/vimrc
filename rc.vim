" Artem Volkhin, http://volkhin.com

" Basic setup, Vundle {{{
" ===================

set nocompatible " enable vim features
filetype off

let mapleader = ","

" init Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Bundle 'gmarik/vundle'
Bundle 'volkhin/vim-colors-solarized'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'jcfaria/Vim-R-plugin'
Bundle 'klen/python-mode'
Bundle 'kien/ctrlp.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'plasticboy/vim-markdown'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'fatih/vim-go'
Bundle 'Shougo/neosnippet.vim'
Bundle 'Shougo/neosnippet-snippets'
Bundle 'majutsushi/tagbar'
Bundle "rking/ag.vim"
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'wavded/vim-stylus'
Bundle 'Shougo/neocomplete.vim'
Bundle 'chase/vim-ansible-yaml'

" Bundle 'vim-scripts/taglist.vim'
" Bundle 'Valloric/YouCompleteMe'
" Bundle 'jlanzarotta/bufexplorer'
" Bundle 'scrooloose/syntastic'
" Bundle 'Lokaltog/vim-powerline'
" Bundle 'tpope/vim-haml'
" Bundle 'alfredodeza/chapa.vim'
" Bundle 'msanders/snipmate.vim'
" Bundle 'xolox/vim-misc'
" Bundle 'xolox/vim-session'

call vundle#end()
filetype plugin indent on
syntax on

" }}}

" General settings {{{
" ================

" set up backups folders
set backup " make backup file and leave it around
set backupskip+=svn-commit.tmp,svn-commit.[0-9]*.tmp
set directory=~/.vim/swap " where to put swap file
set backupdir=~/.vim/backups

" Buffer options
set hidden                  " hide buffers when they are abandoned
set autoread                " auto reload changed files
set autowrite               " automatically save before commands like :next and :make

" Display options
set title                   " show file name in window title
set visualbell              " mute error bell
set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,eol:$,nbsp:~
set linebreak               " break lines by words
set nowrap                  " don't wrap lines
set lazyredraw              " lazy buffer redrawing
set scrolloff=4             " min 4 symbols bellow cursor
set sidescroll=4
set sidescrolloff=8
set number              " show line numbers
set numberwidth=1       " Keep line numbers small if it's shown
set laststatus=2        " always show status line
set nostartofline

" Tab options
set autoindent              " copy indent from previous line
set smartindent             " enable nice indent
set expandtab               " tab with spaces
set smarttab                " isdent using shiftwidth"
set shiftwidth=4            " number of spaces to use for each step of indent
set softtabstop=4           " tab like 4 spaces
set tabstop=4
set shiftround              " drop unused spaces

" Backup and swap files
set history=400             " history length
set viminfo+=h              " save history
set ssop-=blank             " dont save blank window
set ssop-=options           " dont save options

" Search options
set hlsearch                " Highlight search results
set ignorecase              " Ignore case in search patterns
set smartcase               " Override the 'ignorecase' option if the search pattern contains upper case characters
set incsearch               " While typing a search command, show where the pattern

" Matching characters
set showmatch               " Show matching brackets
set matchpairs+=<:>         " Make < and > match as well
set matchtime=3             " Show matching brackets for only 0.3 seconds ! NEED cpoptions+=m

" Localization
set langmenu=none            " Always use english menu
set keymap=russian-jcukenwin " Переключение раскладок клавиатуры по <C-^>
set iminsert=0               " Раскладка по умолчанию - английская
set imsearch=0               " Раскладка по умолчанию при поиске - английская
set spelllang=en,ru          " Языки для проверки правописания
set encoding=utf-8 nobomb
set fileencodings=utf-8,cp1251,koi8-r,cp866
set termencoding=utf-8

" Undo
set undofile            " enable persistent undo
set undodir=/tmp/       " store undofiles in a tmp dir

" Wildmenu
set wildmenu                " use wildmenu ...

" Folding
set foldenable          " Enable code folding
set foldmethod=indent   " Fold on marker
set foldlevel=10        " High default so folds are shown to start

" Color options
set background=dark     " set background color to dark
colorscheme solarized

" Edit
set backspace=indent,eol,start " Allow backspace to remove indents, newlines and old tex"
" set clipboard+=unnamed      " enable x-clipboard
set virtualedit=all         " on virtualedit for all mode

set shortmess=atToOI
set confirm

" highlight long lines
set textwidth=80
if exists('+colorcolumn')
    "hi ColorColumn ctermbg=0
    set colorcolumn=+1
else
    " au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

set t_Co=256
set ttyfast
set mousehide
set mouse=a

" Autocomplete
" set complete=".,k,b"
set completeopt=menu
set infercase

set whichwrap=b,s,<,>,[,],l,h

set modelines=1

set ttimeoutlen=50
" }}}

" Functions {{{
" ==========

" Keymap highlighter
" fun! rc#KeyMapHighlight()
" if &iminsert == 0
" hi StatusLine ctermbg=DarkBlue guibg=DarkBlue
" else
" hi StatusLine ctermbg=DarkRed guibg=DarkRed
" endif
" endfun

" Omni and dict completition
fun! rc#AddWrapper()
    if exists('&omnifunc') && &omnifunc != ''
        return "\<C-X>\<C-o>\<C-p>"
    else
        return "\<C-N>"
    endif
endfun

fun! rc#Search()
    let word = input("Search for: ", expand("<cword>"))
    execute ':Ag '.word
endfun

" Recursive vimgrep
fun! rc#RGrep()
    let pattern = input("Search for pattern: ", expand("<cword>"))
    if pattern == ""
        return
    endif

    let cwd = getcwd()
    let startdir = input("Start searching from directory: ", cwd, "dir")
    if startdir == ""
        return
    endif

    let filepattern = input("Search in files matching pattern: ", "*.*")
    if filepattern == ""
        return
    endif

    execute 'noautocmd vimgrep /'.pattern.'/gj '.startdir.'/**/'.filepattern | copen
endfun

" Shell command with buffer output
command! -complete=shellcmd -nargs=+ Shell call rc#RunShellCommand(<q-args>)
fun! rc#RunShellCommand(cmdline)
    let isfirst = 1
    let words = []
    for word in split(a:cmdline)
        if isfirst
            let isfirst = 0  " don't change first word (shell command)
        else
            if word[0] =~ '\v[%#<]'
                let word = expand(word)
            endif
            let word = shellescape(word, 1)
        endif
        call add(words, word)
    endfor
    let expanded_cmdline = join(words)
    botright new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    call setline(1, 'You entered:  ' . a:cmdline)
    call setline(2, 'Expanded to:  ' . expanded_cmdline)
    call append(line('$'), substitute(getline(2), '.', '=', 'g'))
    silent execute '$read !'. expanded_cmdline
    1
endfun

command! ReloadVimrc source ~/.vimrc

" Save buffer
fun! rc#SaveBuffer()
    if filewritable(expand( '%' ))
        exe "w"
    endif
endfun

" Auto cwindow height
fun! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfun
" }}}

" Autocommands {{{
" =============

if has("autocmd")
    augroup vimrcEx
        au!

        " Auto reload vim settins
        au! bufwritepost rc.vim source ~/.vimrc

        " Highlight insert mode
        au InsertEnter * set cursorline
        au InsertLeave * set nocursorline " FIXME: works with delay

        " New file templates
        "au BufNewFile *.* 0r $HOME/.vim/templates/%:e.tpl " TODO: what is %:e ?
        au BufNewFile *.py 0r $HOME/.vim/templates/py.tpl

        " Restore cursor position
        au BufReadPost * if line("'\"") <= line("$") | exe line("'\"") | endif

        " Save current open file when window focus is lost
        au FocusLost * silent! :wa

        " cwindow height
        au FileType qf call AdjustWindowHeight(3, 6)
    augroup END

    augroup vimGo
        au FileType go nmap <Leader>i <Plug>(go-info)
        au FileType go nmap <Leader>gd <Plug>(go-doc)
        au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
        au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
        au FileType go nmap <leader>r <Plug>(go-run)
        au FileType go nmap <leader>b <Plug>(go-build)
        au FileType go nmap <leader>s <Plug>(go-implements)
        au FileType go nmap <leader>e <Plug>(go-rename)
        au FileType go nmap <leader>c <Plug>(go-coverage)
        au FileType go nmap <leader>B <Plug>(go-install)
        au FileType go nmap <leader>t <Plug>(go-test)
        au FileType go nmap <leader>v <Plug>(go-vet)
        au FileType go nmap <leader>V <Plug>(go-lint)
        au FileType go nmap <Leader>ds <Plug>(go-def-split)
        au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
        au FileType go nmap <Leader>dt <Plug>(go-def-tab)
    augroup END
endif
" }}}

" Plugins setup {{{
" ==============

" Neocomplete
let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_ignore_case = 0

" CtrlP
let g:ctrlp_custom_ignore = 'node_modules'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" Snipmate
" let snippets_dir = substitute(globpath(&rtp, 'snippets/'), "\n", ',', 'g')
let snippets_dir = "~/.vim/snippets"

" Markdown
let g:vim_markdown_initial_foldlevel=10

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" vim-go
let g:go_snippet_engine = "neosnippet"
let g:go_fmt_command = "goimports"
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_structs = 1

let g:NERDSpaceDelims = 1

let g:gitgutter_max_signs = 1000

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" if executable('ag')
  " Use Ag over Grep
  " set grepprg=ag\ --vimgrep
  " set grepprg=ag\ --nogroup\ --nocolor\ --column

" endif
" }}}

let g:pymode = 1
let g:pymode_warnings = 1
let g:pymode_lint_checkers = ['pep8', 'mccabe']
" let g:pymode_python = 'python3'

" Hot keys {{{
" ==========

" Omni and dict completition on space
inoremap <Nul> <C-R>=rc#AddWrapper()<CR>
inoremap <A-Space> <C-R>=rc#AddWrapper()<CR>

" Neosnippets
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" Nice scrolling if line wrap
noremap j gj
noremap k gk

" Drop hightlight search result
noremap <leader><space> :nohls<CR>
noremap <space> za

" Fast scrool
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Close cwindow
nnoremap <silent> <leader>ll :ccl<CR>:lcl<CR>

" Quickfix fast navigation
nnoremap <silent> <leader>nn :cwindow<CR>:cn<CR>
nnoremap <silent> <leader>pp :cwindow<CR>:cp<CR>

" Make
nnoremap <silent> <leader>mm :!make<CR>

" Delete all buffers
nmap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<cr>

" Search
nmap <silent> <leader>gw :call rc#RGrep()<CR>
nmap <leader>a :call rc#Search()<CR>
nmap <C-b> :CtrlPMRU<CR>
" nmap <C-b> :CtrlPBuffer<CR>

" Open new tab
"nmap <leader>tt <esc>:tabnew<cr>

nnoremap <silent> <leader>f :NERDTreeFind<CR>
nnoremap <silent> <leader>F :NERDTreeFocus<CR>
nnoremap <silent> <leader>x :NERDTreeToggle<CR>
nnoremap <silent> <leader>X :TagbarOpenAutoClose<CR>

"call rc#Map_ex_cmd("<F2>", "BufExplorer")
"call rc#Map_ex_cmd("<F3>", "NERDTreeToggle")
"call rc#Map_ex_cmd("<F2>", "cw")
"call rc#Map_ex_cmd("<F4>", "TlistToggle")
"call rc#Toggle_option("<F6>", "list")      " Invisible chars
"call rc#Toggle_option("<F7>", "wrap")      " Toggle word wrapping

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %
" }}}

" Project settings {{{
" ================

if !exists('s:loaded_my_vimrc')
    " auto load .vimrc.local from current directory
     exe 'silent! source '.getcwd().'/.vimrc.local'
    let s:loaded_my_vimrc = 1
endif
" }}}

set secure  " must be written at the last.  see :help 'secure'.
" vim: foldmethod=marker
