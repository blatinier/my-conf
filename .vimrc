" pacman -S python2-powerline-git
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set paste
let mapleader=","

set t_Co=256
"
" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
" required for vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Better file browser
Bundle 'scrooloose/nerdtree'
Bundle 'tyok/ack.vim'
let g:ackprg = 'ag --nogroup --nocolor --column'

Bundle 'vim-scripts/nerdtree-ack'
" Code commenter
Bundle 'scrooloose/nerdcommenter'
" pacman -S ctags
Bundle 'majutsushi/tagbar'
" Code and files fuzzy finder
Bundle 'kien/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
Bundle 'fisadev/vim-ctrlp-cmdpalette'
" Zen coding
Bundle 'mattn/emmet-vim'

"
" Code helpers for vim
"Bundle 'davidhalter/jedi-vim'

" Code checkers for vim
Bundle 'scrooloose/syntastic'

Bundle 'flazz/vim-colorschemes'

"let g:syntastic_python_checkers = ["pylint"]
"let g:syntastic_python_pylint_exe = "pylint"
let g:syntastic_python_checker_args='-d E1130'
let g:pymode_lint_write = 0

map <leader>s :SyntasticCheck<CR>

" Tab list panel
Bundle 'kien/tabman.vim'
" Consoles as buffers
Bundle 'rosenfeld/conque-term'
" Pending tasks list
"Bundle 'fisadev/FixedTaskList.vim'
" Surround
Bundle 'tpope/vim-surround'
" Autoclose
Bundle 'Townk/vim-autoclose'
" Indent text object
Bundle 'michaeljsmith/vim-indent-object'
" Python mode (indentation, doc, refactor, lints, code checking, motion and
" operators, highlighting, run and ipdb breakpoints)
" Bundle 'klen/python-mode'
let g:pymode_options_max_line_length = 80
" Snippets manager (SnipMate), dependencies, and snippets repo
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'
" Git diff icons on the side of the file lines
" Bundle 'airblade/vim-gitgutter'
" Automatically sort python imports
"Bundle 'fisadev/vim-isort'

" Python code checker
"Bundle 'pyflakes.vim'

"let g:pyflakes_builtins = ["_"]


" Search results counter
Bundle 'IndexedSearch'
" XML/HTML tags navigation
Bundle 'matchit.zip'
" Yank history navigation
Bundle 'YankRing.vim'

"VCS management in vim
Bundle 'vcscommand.vim'

"Gundo
Bundle 'sjl/gundo.vim'

Bundle 'ervandew/supertab'

Bundle 'bling/vim-airline'
let g:airline_powerline_fonts = 1

Bundle 'wincent/Command-T'
set wildignore+=*.o,*.obj,.git,.hg,*.pyc,*.pyo,*.orig,*.swp,*.png,*.doctree,*.ttf,*.zip

Bundle 'szw/vim-maximizer'
nnoremap <silent><F3> :MaximizerToggle<CR>
vnoremap <silent><F3> :MaximizerToggle<CR>gv
inoremap <silent><F3> <C-o>:MaximizerToggle<CR>

Bundle 'mhinz/vim-startify'

" Installing plugins the first time
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

filetype plugin indent on

set tabpagemax=30

autocmd FileType * set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType c,python,rst,yaml,xml,conf set tabstop=4|set shiftwidth=4|set expandtab
syn on
retab
set background=dark
set autoindent
set spelllang=fr
set encoding=utf8

set nocompatible   " Disable vi-compatibility
set encoding=utf-8 " Necessary to show Unicode glyphs
set fileencoding=utf-8 " Necessary to show Unicode glyphs

set directory=$HOME/.vim_swap/
" Highlight searches
set hlsearch

" Highlight dynamically as pattern is typed
set incsearch

" Always show status line
"set laststatus=2

" Status line definition.
"set statusline=[%n]\ %<%f%m%r\ %w\ %y\ \ <%{&fileformat}>%=\ %l,%c%V\/%L\ \ %P
" Show the current mode
set showmode
" Show the filename in the window titlebar
"set title
" Start scrolling horizontally at this number of columns.
set sidescrolloff=5
" case only matters with mixed case expressions
set ignorecase
set smartcase

map <leader>f :TlistToggle<CR>
map <F4> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"NERDTree when vim starts up
"au VimEnter *  NERDTree
autocmd VimEnter * wincmd p
let g:nerdtree_tabs_open_on_console_startup=1

map <leader>h :GundoToggle<CR>
map <leader>pl :call Pylint(1)<CR>
nnoremap <leader>l :TagbarToggle<CR>
" autofocus on Tagbar open
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_width = 50

" tab navigation
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" navigate windows with meta+arrows
map <M-Right> <c-w>l
map <M-Left> <c-w>h
map <M-Up> <c-w>k
map <M-Down> <c-w>j
imap <M-Right> <ESC><c-w>l
imap <M-Left> <ESC><c-w>h
imap <M-Up> <ESC><c-w>k
imap <M-Down> <ESC><c-w>j

" fix some problems with gitgutter and other plugins (originally jedi-vim, but
" left just in case, and it's faster)
let g:gitgutter_eager = 0
let g:gitgutter_realtime = 0

" show pending tasks list
map <F2> :TaskList<CR>

" store yankring history file hidden
let g:yankring_history_file = '.yankring_history'

" save as sudo
ca w!! w !sudo tee "%"

" old autocomplete keyboard shortcut
imap <C-J> <C-X><C-O>
"let g:jedi#completions_enabled = 0
imap <c-space> <C-R>=RopeCodeAssistInsertMode()<CR>"

"let g:jedi#popup_on_dot = 0

filetype on
autocmd FileType make setlocal noexpandtab
autocmd BufWritePre * :%s/\t/    /ge
autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre Makefile :%s/    /\t/ge

" Resize splits when the window is resized
au VimResized * :wincmd =

" :DiffOrig → open vimdiff to show changes since vim was opened
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
map <F5> :DiffOrig<Enter>

noremap <leader>p :silent! set paste<CR>"*p:set nopaste<CR>

" Toggle [i]nvisible characters
nnoremap <leader>i :set list!<cr>


" Toggle paste
" " For some reason pastetoggle doesn't redraw the screen (thus the status bar
" " doesn't change) while :set paste! does, so I use that instead.
" " set pastetoggle=<F6>
nnoremap <F6> :set paste!<cr>

"let g:PyLintCWindow = 1
"let g:PyLintSigns = 1
"let g:PyLintOnWrite = 1
let g:pylint_onwrite = 0

let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
 au!
 autocmd BufReadPost *
 \ if expand("<afile>:p:h") !=? $TEMP |
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ let JumpCursorOnEdit_foo = line("'\"") |
 \ let b:doopenfold = 1 |
 \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
 \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
 \ let b:doopenfold = 2 |
 \ endif |
 \ exe JumpCursorOnEdit_foo |
 \ endif |
 \ endif
 " Need to postpone using "zv" until after reading the modelines.
 autocmd BufWinEnter *
 \ if exists("b:doopenfold") |
 \ exe "normal zv" |
 \ if(b:doopenfold > 1) |
 \ exe "+".1 |
 \ endif |
 \ unlet b:doopenfold |
 \ endif
augroup END

" CtrlP (new fuzzy finder)
let g:ctrlp_map = ',e'
nmap ,g :CtrlPBufTag<CR>
nmap ,G :CtrlPBufTagAll<CR>
nmap ,f :CtrlPLine<CR>
nmap ,m :CtrlPMRUFiles<CR>
nmap ,c :CtrlPCmdPalette<CR>
" to be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction
" CtrlP with default text
nmap ,wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
nmap ,wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
nmap ,wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
nmap ,we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
nmap ,pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
nmap ,wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>
" Don't change working directory
let g:ctrlp_working_path_mode = 0
" Ignore files on fuzzy finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }

" Ignore files on NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" simple recursive grep
command! -nargs=1 RecurGrep lvimgrep /<args>/gj ./**/*.* | lopen | set nowrap
command! -nargs=1 RecurGrepFast silent exec 'lgrep! <q-args> ./**/*.*' | lopen
nmap ,R :RecurGrep
nmap ,r :RecurGrepFast
nmap ,wR :RecurGrep <cword><CR>
nmap ,wr :RecurGrepFast <cword><CR>

" python-mode settings
" don't show lint result every time we save a file
let g:pymode_lint_write = 0
" run pep8+pyflakes+pylint validator with \8
autocmd FileType python map <buffer> <leader>8 :PyLint<CR>
" rules to ignore (example: "E501,W293")
let g:pymode_lint_ignore = ""
" don't add extra column for error icons (on console vim creates a 2-char-wide
" extra column)
let g:pymode_lint_signs = 1
" don't fold python code on open
let g:pymode_folding = 1
" don't load rope by default. Change to 1 to use rope
let g:pymode_rope = 1

"Extended autocompletion (rope could complete objects which have not been
"imported) from project
let g:pymode_rope_autoimport = 1

map <leader>i :PymodeRopeAutoImport<CR>

" neocomplcache settings
"let g:neocomplcache_enable_at_startup = 1
"let g:neocomplcache_enable_ignore_case = 1
"let g:neocomplcache_enable_smart_case = 1
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_enable_fuzzy_completion = 1
"let g:neocomplcache_enable_camel_case_completion = 1
"let g:neocomplcache_enable_underbar_completion = 1
"let g:neocomplcache_fuzzy_completion_start_length = 1
"let g:neocomplcache_auto_completion_start_length = 1
"let g:neocomplcache_auto_completion_start_length = 1
"let g:neocomplcache_manual_completion_start_length = 1
"let g:neocomplcache_min_keyword_length = 1
"let g:neocomplcache_min_syntax_length = 1
"" complete with workds from any opened file
"let g:neocomplcache_same_filetype_lists = {}
"let g:neocomplcache_same_filetype_lists._ = '_'

" rope (from python-mode) settings
nmap ,d :RopeGotoDefinition<CR>
nmap ,D :tab split<CR>:RopeGotoDefinition<CR>
nmap ,o :RopeFindOccurrences<CR>

" don't let pyflakes allways override the quickfix list
"let g:pyflakes_use_quickfix = 0

" tabman shortcuts
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

set wrap

function! Insert_ipdb()
    let task_line_no = line ('.')
    let line         = getline (task_line_no)
    let whitespaces  = matchstr (line,'^\s\+')

    let entry = whitespaces."import ipdb; ipdb.set_trace();"

    " Insert new project line
    call append(task_line_no, entry)
endfunction
command IP call Insert_ipdb()


