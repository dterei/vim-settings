" ==============================================================================
" David Terei's .vimrc file
"
" Vim Version: 7.4.0
"
" ==============================================================================


"###############################################################################
"# Essential Settings                                                          #
"###############################################################################

set nocompatible

" OS neutral variable for referring to user files
" assume unix, change if not
let $MYVIM=$HOME."/.vim"

if has("win32")
  "source $VIMRUNTIME/mswin.vim
  let $MYVIM=$VIM
endif

let $SS=$MYVIM."/sessions"


"###############################################################################
"# Vundle Plugin Manager                                                       #
"###############################################################################

" Plugin Manager for Vim
" http://github.com/gmarik/vundle

" setup Vundle
filetype off
set rtp+=$MYVIM/bundle/vundle/
call vundle#begin()
Bundle 'gmarik/vundle'

" === Plugins! ===

" With bufexplorer, you can quickly and easily switch between buffers.
Bundle 'bufexplorer.zip'
" File finding command.
Bundle 'wincent/command-t'
" A fuzzy search file and buffer browser.
Bundle 'LustyExplorer'
" Network browser (included with vim but want most up to date)
Bundle 'netrw.vim'
" NERD Tree filesystem explorer
Bundle 'scrooloose/nerdtree'
" Syntatic - Checks for syntax errors
Bundle 'scrooloose/syntastic'
" Tag listing / Class explorer
Bundle 'majutsushi/tagbar'
" Powerline
Bundle 'bling/vim-airline'

" Extended % matching for HTML, LaTeX, and many other languages.
Bundle 'matchit.zip'
" Align text to columns
Bundle 'godlygeek/tabular'
" Quickly surround some text (i.e bracket, html tags...)
Bundle 'tpope/vim-surround'
" Auto closing of quotes, parenthesis, brackets... ect
Bundle 'Raimondi/delimitMate'
" Toggle commenting
Bundle 'tomtom/tcomment_vim'
" QFEnter -- better quickfix window handling
Bundle 'yssl/QFEnter'

" Support for local.vimrc
Bundle 'vim-scripts/lh-vim-lib'
Bundle 'LucHermitte/local_vimrc'
" Git plugin.
Bundle 'tpope/vim-fugitive'
" Display changes from git in side signs.
Bundle 'airblade/vim-gitgutter'
" Git highlighting files.
Bundle 'tpope/vim-git'
" Unix helpers
Bundle 'tpope/vim-eunuch'

" More repeat (.) support (for plugins)
Bundle 'tpope/vim-repeat'
" Provides selectable highlighting
Bundle 'Mark'
" Provide a bookmarking facility for Vim. Mark lines of interest.
Bundle 'dterei/VimBookmarking'
" Maintains a history of previous yanks and deletes.
Bundle 'YankRing.vim'
" Visualise the undo tree of vim.
Bundle 'sjl/gundo.vim'
" Make <F12> switch mouse between Vim and Terminal
Bundle 'nvie/vim-togglemouse'
" Easy moving / jumping
Bundle 'EasyMotion'
" Provides some nice shortcuts for things like :cn
Bundle 'tpope/vim-unimpaired'
" Improved :man & :help (and other docs) viewer
Bundle 'powerman/vim-plugin-viewdoc'

" Golang support
Bundle 'jnwhiteh/vim-golang'
Bundle 'fatih/vim-go'
" A filetype plugin to help edit XML, HTML and SGML documents.
Bundle 'xmledit'
" Haskell folding
Bundle 'Twinside/vim-haskellFold'
" Markdown support
Bundle 'tpope/vim-markdown'
" Indent highlighting
Bundle 'nathanaelkane/vim-indent-guides'
" Scala support
Bundle 'derekwyatt/vim-scala'

" === Colour Schemes! ===
Bundle 'dterei/VimCobaltColourScheme'
Bundle 'dterei/Twilight'
Bundle 'cschlueter/vim-mustang'
Bundle 'wgibbs/vim-irblack'
Bundle 'darkslategray.vim'
Bundle 'darkspectrum'
Bundle 'fruity.vim'
Bundle 'tir_black'
Bundle 'kib_darktango.vim'
Bundle 'peaksea'
Bundle 'pyte'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vilight.vim'
Bundle 'Wombat'
Bundle 'Zenburn'
Bundle 'bclear'

call vundle#end()


"###############################################################################
"# General Settings                                                            #
"###############################################################################

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
augroup myjump
  au!
  au BufReadPost *
   \ if line("'\"") > 0 && line("'\"") <= line("$") |
   \   exe "normal! g`\"" |
   \ endif
augroup END

" setup mapleader
let mapleader=","
let maplocalleader="\\"

" nice features but vim is very stable and I save a lot
set nobackup
set noswapfile

set encoding=utf-8
"set termencoding=latin1

set mouse=a  " enable mouse in terminal

set showcmd  " display incomplete commands
set wildmenu " way cooler command line mode completion

set history=100 " keep 100 lines of command line history
set viminfo='500,f1,<500,s50,:0,@30,/30,! " what to store for each file
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
" permanent undo
if version >= 703
  set undofile
  set undodir=$MYVIM/undo
endif

set incsearch  " do incremental searching
set ignorecase " make this default, turn on case in search with /<search>\C/
" type small case will search case independent, type mixed case will use exact
set smartcase

" Ignore these files for auto...
set wildignore+=*.o,*.obj,*.bak,*.exe,*~,*.hi,*.pyc,*.class,*.bak,*.swp

" Don't lcd to the current buffers directory, this is a nice feature but
" causes a lot of problems, so instead I use some keyboard shortcuts to
" open tabs at the current files dir... ect.
set noacd

set ch=1 " Make command line one lines high
set laststatus=2 " enable status line always
set ruler " show the cursor position all the time

set scrolloff=3 " lines to always seeable when scrolling

" Default text width, used with autoformatter and pasting
"set tw=80
"set wm=80

" Just hide, dont close buffers (a lot of people love this, not me though)
set hidden

" Path setting for finding files
set path+=**,

" Function for saving when root priv required
cmap w!! w !sudo tee % >/dev/null

" Allow more than 10 tabs with -p command
set tabpagemax=40

" Modelines
set modeline
set modelines=5

" Delete comment character when joining commented lines
set formatoptions+=j

" Display as much of possible of lines that fill the whole screen instead of
" the default '@' display mode
set display+=lastline

" clipboard -- copy to system by default
" if has('unnamedplus')
"   set clipboard=unnamedplus
" elseif has('unamed')
"   set clipboard=unnamed
" endif

"###############################################################################
"# Highlight & Fold Settings                                                   #
"###############################################################################

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Use terminal background, need dark background
"colorscheme ir_black
"colorscheme pablo
"colorscheme oceandeep
"colorscheme elflord

" Change terminal background, use dark background
"colorscheme mustang
"colorscheme torte

" Change terminal background, use light background
"colorscheme morning
"colorscheme peaksea
"colorscheme shine

" Work with light or dark terminal background (call set background to change)
"colorscheme default
colorscheme solarized

" below order and command is needed to fix gnome-terminal issue
let g:solarized_termtrans=1
set background=dark

" if has("mac")
  " colorscheme default
" endif

syntax sync fromstart
let hs_minlines = 500

set nonu " line numbers
set cursorline
let c_comment_strings=1 " highlighting strings inside C comments
set gcr=a:blinkon0
set showmatch " show matching brace when inserting one

" Like to use this in general but implemented in an ugly way in Vim
"set colorcolumn=100

set foldenable
set foldmethod=syntax
set foldlevelstart=99 " open all folds by default
let g:xml_syntax_folding=1 " enable xml folding

" Use latex, not plaintex
let g:tex_flavor = "latex"

" Highlight trailing whitespace
highlight WhitespaceEOL ctermbg=DarkYellow ctermfg=white guibg=DarkYellow

" Highlight lines over 80 width
highlight OverLength ctermbg=Red ctermfg=White guibg=#592929

function! ToggleLongLines()
  if exists("w:long_line_match")
    call matchdelete(w:long_line_match)
    unlet w:long_line_match
  else
    let w:long_line_match = matchadd("WhitespaceEOL", '\s\+$', -1)
  endif
  if exists("w:trailing_spaces")
    call matchdelete(w:trailing_spaces)
    unlet w:trailing_spaces
  else
    let w:trailing_spaces = matchadd("OverLength", '\%>80v.\+', -1)
  endif
endfunction

nmap <silent> <Leader>h :call ToggleLongLines()<CR>
command! HighlightLongLines :call ToggleLongLines()

"###############################################################################
"# Indent Settings                                                             #
"###############################################################################

set tabstop=2 " tab space
set softtabstop=2 " fake tab spaces
set shiftwidth=2 " indent space
set expandtab " use spaces, not tabs
set smarttab " tab amount done according to previous lines
set indentexpr=syntax
set autoindent
set smartindent " go with smartindent if there is no plugin indent file


"###############################################################################
"# KeyMap Settings                                                             #
"###############################################################################

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" disable alt modifier for menu shortcuts
set winaltkeys=no

"---------------
"# F[0-9] Keys #
"---------------

" clear search highlight
map <silent> Q <Esc>:noh<CR>

" make F2 save and ,s
nmap <silent> <F2> <Esc>:w<CR>
imap <silent> <F2> <C-o>:w<CR>
nmap <silent> <Leader>s <Esc>:w<CR>

" toggle git-gutter
map <silent> <F9> <Esc>:GitGutterToggle<CR>

" enable/disable spell check
map <silent> <F6> <Esc>:setlocal spell! spelllang=en_au<CR>
imap <silent> <F6> <C-o>:setlocal spell! spelllang=en_au<CR>

" Switch to paste mode
set pastetoggle=<F7>

" Toggle between all buffers and all tabs
nnoremap <silent> <expr> <F8> ( tabpagenr('$') == 1 ? ':tab ball<Bar>tabn' : ':tabo' ) . '<CR>'

"----------------------------
"# Other Text Movement Keys #
"----------------------------

" Sadly the below only really work in GVim.

" enable eclipse style moving of lines (needs GVim)
if has("mac")
nmap <silent> ∆ mz:m+<CR>`z==
nmap <silent> ˚ mz:m-2<CR>`z==
imap <silent> ∆ <Esc>:m+<CR>==gi
imap <silent> ˚ <Esc>:m-2<CR>==gi
vmap <silent> ∆ :m'>+<CR>gv=`<my`>mzgv`yo`z
vmap <silent> ˚ :m'<-2<CR>gv=`>my`<mzgv`yo`z
else
nmap <silent> <A-J> mz:m+<CR>`z==
nmap <silent> <A-K> mz:m-2<CR>`z==
imap <silent> <A-J> <Esc>:m+<CR>==gi
imap <silent> <A-K> <Esc>:m-2<CR>==gi
vmap <silent> <A-J> :m'>+<CR>gv=`<my`>mzgv`yo`z
vmap <silent> <A-K> :m'<-2<CR>gv=`>my`<mzgv`yo`z
endif


" enable nice new line inserting in insert mode
imap <silent> <C-CR> <Esc>o
imap <silent> <C-S-CR> <Esc>O

" general windows delete commands
imap <silent> <C-BS> <Esc>vbc
imap <silent> <C-Del> <Esc>lvec

" map - to end of line, _ to start
noremap - ^
noremap _ $

" remap C-A to C-H as we want C-A for home
noremap <silent> <C-h> <C-a>

" Enable some emacs style keys
imap <silent> <C-e> <End>
imap <silent> <C-a> <Home>
nmap <silent> <C-e> $
nmap <silent> <C-a> ^
imap <silent> <C-f> <Right>
imap <silent> <C-b> <Left>
imap <silent> <C-h> <Backspace>
imap <silent> <C-d> <Delete>

"-----------------------
"# Nicer Remapped Keys #
"-----------------------

" Nicer tag jumping keys
map <silent> <A-j> <Esc>:tag<CR>
map <silent> <A-k> <Esc>:pop<CR>
noremap <silent> <A-l> <C-]>

" Better way to enter command line (get rid of pointless shift)
nnoremap ; :
cnoremap ; <C-C>

"---------------------
"# New Movement Keys #
"---------------------

" normally nothing
noremap <C-k> 2<C-Y>
noremap <C-j> 2<C-E>

"-------------------------------------
"# File/Window/Buffer Managment Keys #
"-------------------------------------

" quick file browse mapping
map <Leader>e :e %:p:h<CR>
map <Leader>E :lcd %:p:h<CR>

" Give tab cycling nicer keys (normally these just do same as j & k)
noremap <C-n> :tabnext<CR>
noremap <C-p> :tabNext<CR>

" new tab
nmap <Leader>t :tabe %:p:h<CR>
nmap <Leader>T :tabe .<CR>
"nmap <Leader>n :tabnew<CR>

" tab close (TODO: detect if on last tab and don't call previous)
map <Leader>w :tabclose\|tabprevious<CR>
" close window
map <Leader>q :q<CR>
" quit vim
map <Leader>Q :qall!<CR>

"----------------------
"# tab re-arrangement #
"----------------------

" Move current tab to first position
"nnoremap <C-S-M> :tabmove 0<CR>
" Move current tab to last position
"nnoremap <C-/> :tabmove<CR>
" Move current tab to the left
noremap <silent> <Leader>< :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
" Move current tab to the right
noremap <silent> <Leader>> :execute 'silent! tabmove ' . tabpagenr()<CR>


"###############################################################################
"# Diff Settings                                                               #
"###############################################################################

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis


"###############################################################################
"# New Functions                                                               #
"###############################################################################

" Delete trailing whitespace and tabs at the end of each line
command! DeleteTrailingWs :%s/\s\+$//e

" Search all subdirectories for word under cursor
command! Wgrep :execute 'noautocmd vimgrep /'.expand('<cword>').'/gj **/*'
                  \ .expand('%:e').' **/*\.h **/*\.c | cl'

" Easy .vimrc editing
command! Rlp :source $MYVIMRC
command! Ep :e $MYVIMRC

" Go to latest version of file
command! Latest :later 10000d


"###############################################################################
"# Plugins                                                                     #
"###############################################################################

"------------
"# YankRing #
"------------
let g:yankring_clipboard_monitor = 0
let g:yankring_replace_n_pkey = '<A-p>'
let g:yankring_replace_n_nkey = '<A-n>'
let g:yankring_max_display = 50
let g:yankring_history_dir = '$MYVIM'
nnoremap <silent> <Leader>y :YRShow<CR>

"---------------
"# ManPageView #
"---------------
" This plugin is included in vim runtime but not all loaded by default
runtime ftplugin/man.vim

"-----------------
"# Lust Explorer #
"-----------------
let g:LustyJugglerSuppressRubyWarning = 1

"-------------
"# Command-T #
"-------------
nnoremap <silent> <Leader>f :CommandT<CR>

"---------------
"# Delimitmate #
"---------------
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

"---------
"# Gundo #
"---------
nnoremap <silent> U :GundoToggle<CR>

"---------------
"# Local vimrc #
"---------------
let g:local_vimrc = ["_vimrc_local.vim", ".vimrc_local.vim", ".vimrc.vim"]

"------------
"# Fugutive #
"------------

command! Gflog :Glog | :Gedit | :copen | wincmd k

"----------------
"# Haskell Mode #
"----------------
" Enable increased Haskell highlighting
let hs_highlight_boolean = 1
let hs_highlight_types = 1
let hs_highlight_more_types = 1
let hs_highlight_debug = 1
let hs_highlight_classes = 1
let hs_highlight_functions = 1

"-----------
"# AirLine #
"-----------
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'

" allow spaces only after all tabs
let g:airline#extensions#whitespace#mixed_indent_algo = 2

" don't show hunks chancged
let g:airline#extensions#hunks#enabled = 0

"-------------
"# Syntastic #
"-------------
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++14'
let g:syntastic_python_python_exec = 'python2'

let g:syntastic_c_include_dirs = [ '../include', 'include' ]
let g:syntastic_c_check_header = 1
let g:syntastic_cpp_include_dirs = [ '../include', 'include' ]
let g:syntastic_cpp_check_header = 1

let g:syntastic_html_checkers = ["validator", "jshint"]

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_erros = 1

"----------
"# Vim-go #
"----------

" Disable gofmt on save.
let g:go_fmt_autosave = 0

au Filetype go nmap <leader>dv <Plug>(go-def-vertical)
au Filetype go nmap <leader>ds <Plug>(go-def-split)

au Filetype go nmap <leader>gd <Plug>(go-doc-vertical)
au Filetype go nmap <leader>gb <Plug>(go-doc-browser)

au Filetype go nmap <leader>I :exe "GoImports"<CR>
au Filetype go nmap <leader>i <Plug>(go-info)
au Filetype go nmap <leader>B <Plug>(go-build)
au Filetype go nmap <leader>R <Plug>(go-rename)

" Enable :Lint command
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim


"###############################################################################
"# File End                                                                    #
"###############################################################################

