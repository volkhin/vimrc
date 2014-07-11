" stolen from somebody
" Artem Volkhin, http://volkhin.com

" Setup
" ======

set nocompatible " enable vim features
filetype off
set backup " make backup file and leave it around
set backupskip+=svn-commit.tmp,svn-commit.[0-9]*.tmp
set directory=/var/tmp,/tmp                         " where to put swap file
set backupdir=~/.vim/backups
if finddir(&backupdir) == ''
    silent call mkdir(&backupdir, "p")
end

" init Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Bundle 'gmarik/vundle'
Bundle 'volkhin/vim-colors-solarized'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/taglist.vim'
Bundle 'jcfaria/Vim-R-plugin'
Bundle 'tpope/vim-haml'
Bundle 'alfredodeza/chapa.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'jlanzarotta/bufexplorer'
" Bundle 'xolox/vim-misc'
" Bundle 'xolox/vim-session'
Bundle 'kien/ctrlp.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'plasticboy/vim-markdown'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'

call vundle#end()
filetype plugin indent on
syntax on

" init pathogen and build tags for doc folders
" call pathogen#helptags()
" call pathogen#incubate()


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
set winminheight=0          " minimal window height
set winminwidth=0           " minimal window width
set lazyredraw              " lazy buffer redrawing " TODO: need fix?
set scrolloff=4             " min 4 symbols bellow cursor
set sidescroll=4
set sidescrolloff=8
set nosplitbelow            " open new window bellow
set number
set numberwidth=1       " Keep line numbers small if it's shown
set laststatus=2

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
set encoding=utf-8
set fileencodings=utf-8,cp1251,koi8-r,cp866
set termencoding=utf-8

" Undo
set undofile            " enable persistent undo
set undodir=/tmp/       " store undofiles in a tmp dir

" Wildmenu
set wildmenu                " use wildmenu ...
set wildcharm=<TAB>         " autocomplete
set wildignore=*.pyc        " ignore file pattern
set cmdheight=2             " command line height 2

" Folding
set foldenable          " Enable code folding
set foldmethod=indent   " Fold on marker
set foldlevel=999       " High default so folds are shown to start
set foldcolumn=0        " Don't show a fold column

" Color options
set background=light     " set background color to dark
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
    hi ColorColumn ctermbg=7
    set colorcolumn=+1
else
    " au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

set t_Co=256
set ttyfast
set mousehide

" Autocomplete
set completeopt=menu
set infercase

set whichwrap=b,s,<,>,[,],l,h

set modelines=1

let mapleader = ","


" Functions
" ==========

" Keymap highlighter
" fun! rc#KeyMapHighlight()
" if &iminsert == 0
" hi StatusLine ctermbg=DarkBlue guibg=DarkBlue
" else
" hi StatusLine ctermbg=DarkRed guibg=DarkRed
" endif
" endfun

" Key bind helper
fun! rc#Map_ex_cmd(key, cmd)
    execute "nmap ".a:key." " . ":".a:cmd."<CR>"
    execute "cmap ".a:key." " . "<C-C>:".a:cmd."<CR>"
    execute "imap ".a:key." " . "<C-O>:".a:cmd."<CR>"
    execute "vmap ".a:key." " . "<Esc>:".a:cmd."<CR>gv"
endfun

" Option switcher helper
fun! rc#Toggle_option(key, opt)
    call rc#Map_ex_cmd(a:key, "set ".a:opt."! ".a:opt."?")
endfun

" Omni and dict completition
fun! rc#AddWrapper()
    if exists('&omnifunc') && &omnifunc != ''
        return "\<C-X>\<C-o>\<C-p>"
    else
        return "\<C-N>"
    endif
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

" Open the fold if restoring cursor position
fun! rc#OpenFoldOnRestore()
    if exists("b:doopenfold")
        execute "normal zv"
        if(b:doopenfold > 1)
            execute "+".1
        endif
        unlet b:doopenfold
    endif
endfun

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


" Autocommands
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
        au FocusLost * call rc#SaveBuffer()

        " cwindow height
        au FileType qf call AdjustWindowHeight(3, 6)
    augroup END
endif


" Plugins setup
" ==============

" Taglist
let Tlist_Compact_Format          = 1   " Do not show help
let Tlist_Enable_Fold_Column      = 0   " Don't Show the fold indicator column
let Tlist_Exit_OnlyWindow         = 1   " If you are last kill your self
let Tlist_GainFocus_On_ToggleOpen = 1   " Jump to taglist window to open
let Tlist_Show_One_File           = 1   " Displaying tags for only one file
let Tlist_Use_Right_Window        = 1   " Split to right side of the screen
let Tlist_Use_SingleClick         = 1   " Single mouse click open tag
let Tlist_WinWidth                = 30  " Taglist win width
let Tlist_Display_Tag_Scope       = 1   " Show tag scope next to the tag name
let tlist_xslt_settings           = 'xslt;m:match;n:name;a:apply;c:call'
let tlist_javascript_settings     = 'javascript;s:string;f:function;a:array;o:object'
let Tlist_Ctags_Cmd               = '/usr/local/Cellar/ctags/5.8/bin/ctags'

" NERDCommenter
let NERDSpaceDelims = 1

" NERDTree
let NERDTreeWinSize = 30
" files/dirs to ignore in NERDTree (mostly the same as my svn ignores)
let NERDTreeIgnore=[
            \'\~$',
            \'\.pt.cache$',
            \'\.Python$',
            \'\.svn$',
            \'\.beam$',
            \'\.pyc$',
            \'\.pyo$',
            \'\.mo$',
            \'\.o$',
            \'\.lo$',
            \'\.la$',
            \'\..*.rej$',
            \'\.rej$',
            \'\.\~lock.*#$',
            \'\.AppleDouble$',
            \'\.DS_Store$']

" Enable extended matchit
runtime macros/matchit.vim

" CtrlP
let g:ctrlp_custom_ignore = 'node_modules'

" Snipmate
" let snippets_dir = substitute(globpath(&rtp, 'snippets/'), "\n", ',', 'g')
let snippets_dir = "~/.vim/snippets"

" Markdown
let g:vim_markdown_initial_foldlevel=3

" Hot keys
" ==========

" Insert mode
" ------------

" Omni and dict completition on space
inoremap <Nul> <C-R>=rc#AddWrapper()<CR>
inoremap <A-Space> <C-R>=rc#AddWrapper()<CR>

" Normal mode
" ------------

" Nice scrolling if line wrap
noremap j gj
noremap k gk

" Split line in current cursor position
" map     <S-O>       i<CR><ESC>

" Drop hightlight search result
noremap <leader><space> :nohls<CR>
noremap <space> za

" Fast scrool
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Select all
map vA ggVG

" Close cwindow
nnoremap <silent> ,ll :ccl<CR>

" Quickfix fast navigation
nnoremap <silent> ,nn :cwindow<CR>:cn<CR>
nnoremap <silent> ,pp :cwindow<CR>:cp<CR>

" Make
nnoremap <silent> ,mm :!make<CR>

" Run
nnoremap <silent> ,r :!%<CR>

" Window commands
nnoremap <silent> ,h :wincmd h<CR>
nnoremap <silent> ,j :wincmd j<CR>
nnoremap <silent> ,k :wincmd k<CR>
nnoremap <silent> ,l :wincmd l<CR>
nnoremap <silent> ,+ :wincmd +<CR>
nnoremap <silent> ,- :wincmd -<CR>
nnoremap <silent> ,cj :wincmd j<CR>:close<CR>
nnoremap <silent> ,ck :wincmd k<CR>:close<CR>
nnoremap <silent> ,ch :wincmd h<CR>:close<CR>
nnoremap <silent> ,cl :wincmd l<CR>:close<CR>
nnoremap <silent> ,cw :close<CR>

" Buffer commands
noremap <silent> ,bp :bp<CR>
noremap <silent> ,bn :bn<CR>
noremap <silent> ,bw :w<CR>
noremap <silent> ,bd :bd<CR>
noremap <silent> ,ls :ls<CR>

" Delete all buffers
nmap <silent> ,da :exec "1," . bufnr('$') . "bd"<cr>

" Search the current file for the word under the cursor and display matches
nmap <silent> ,gw :call rc#RGrep()<CR>

" Open new tab
nmap <leader>tt <esc>:tabnew<cr>

" Tab navigation
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt

" первая вкладка
call rc#Map_ex_cmd("<A-UP>", ":tabfirst")
" последняя вкладка
call rc#Map_ex_cmd("<A-DOWN>", ":tablast")
" переместить вкладку в начало
nmap Q :tabmove 0<cr>
" переместить вкладку в конец
call rc#Map_ex_cmd("<C-DOWN>", ":tabmove")

" Переключение раскладок будет производиться по <C-F>
" cmap <silent> <C-F> <C-^>
" imap <silent> <C-F> <C-^>X<Esc>:call rc#KeyMapHighlight()<CR>a<C-H>
" nmap <silent> <C-F> a<C-^><Esc>:call rc#KeyMapHighlight()<CR>
" vmap <silent> <C-F> <Esc>a<C-^><Esc::call rc#KeyMapHighlight()<CR>gv

" NERDTree keys
call rc#Map_ex_cmd("<F2>", "BufExplorer")
call rc#Map_ex_cmd("<F3>", "NERDTreeToggle")
nnoremap <silent> <leader>f :NERDTreeFind<CR>

" Toggle cwindow
" call rc#Map_ex_cmd("<F2>", "cw")

" Запуск/сокрытие плагина Tlist
call rc#Map_ex_cmd("<F4>", "TlistToggle")

call rc#Toggle_option("<F6>", "list")      " Переключение подсветки невидимых символов
call rc#Toggle_option("<F7>", "wrap")      " Переключение переноса слов

" Git fugitive menu
" map <F9> :emenu G.<TAB>
" menu G.Status :Gstatus<CR>
" menu G.Diff :Gdiff<CR>
" menu G.Commit :Gcommit %<CR>
" menu G.Checkout :Gread<CR>
" menu G.Remove :Gremove<CR>
" menu G.Move :Gmove<CR>
" menu G.Log :Glog<CR>
" menu G.Blame :Gblame<CR>

" Закрытие файла
call rc#Map_ex_cmd("<C-F10>", "qall")
call rc#Map_ex_cmd("<S-F10>", "qall!")

" Список регистров
" call rc#Map_ex_cmd("<F11>", "reg")

" Список меток
" call rc#Map_ex_cmd("<F12>", "marks")

" Project settings
" ================

if !exists('s:loaded_my_vimrc')
    " auto load .vim/.vimrc from current directory
    " exe 'silent! source '.getcwd().'/.vim/.vimrc'
    " exe 'silent! source '.getcwd().'/.vimrc'
    let s:loaded_my_vimrc = 1
endif


set secure  " must be written at the last.  see :help 'secure'.
