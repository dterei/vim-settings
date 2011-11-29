" ==============================================================================
" David Terei's .vimrc file
"
" Vim Version: 7.3.0
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
call vundle#rc()
Bundle 'gmarik/vundle'

" === Plugins! ===

" Quickly switch between source files and header files.
Bundle 'a.vim'
" With bufexplorer, you can quickly and easily switch between buffers.
Bundle 'bufexplorer.zip'
" File finding command.
Bundle 'Command-T'
" A fuzzy search file and buffer browser.
Bundle 'LustyExplorer'
" Network browser (included with vim but want most up to date)
Bundle 'netrw.vim'

" Functions and mappings to close open HTML/XML tags.
Bundle 'closetag.vim'
" Extended % matching for HTML, LaTeX, and many other languages.
Bundle 'matchit.zip'
" An attempt to emulate TextMate's snippet expansion.
Bundle 'snipMate'
" Align text to columns
Bundle 'godlygeek/tabular'
" Quickly surround some text (i.e bracket, html tags...)
Bundle 'tpope/surround'
" Auto closing of quotes, parenthesis, brackets... ect
Bundle 'Raimondi/delimitMate'

" Run a terminal in vim.
Bundle 'Conque-Shell'
" Git plugin.
Bundle 'tpope/vim-fugitive'
" Git highlighting files.
Bundle 'tpope/vim-git'

" Provide a bookmarking facility for Vim. Mark lines of interest.
Bundle 'dterei/VimBookmarking'
" Maintains a history of previous yanks and deletes.
Bundle 'YankRing.vim'
" Visualise the undo tree of vim.
Bundle 'sjl/gundo.vim'
" Make <F12> switch mouse between Vim and Terminal
Bundle 'nvie/vim-togglemouse'

" A filetype plugin to help edit XML, HTML and SGML documents.
Bundle 'xmledit'
" Haskell indent file
"Bundle 'indenthaskell.vim'
" Haskell mode plugin.
Bundle 'lukerandall/haskellmode-vim'
" Haskell folding
Bundle 'Twinside/vim-haskellFold'


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
Bundle 'Solarized'
Bundle 'vilight.vim'
Bundle 'Wombat'
Bundle 'Zenburn'


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

" ignore these files for auto...
set wildignore+=*.o,*.obj,*.bak,*.exe,*~,*.hi,*.pyc,*.class,*.bak,*.swp

" don't lcd to the current buffers directory, this is a nice feature but
" causes a lot of problems, so instead I use some keyboard shortcuts to
" open tabs at the current files dir... ect.
set noacd

set ch=1 " Make command line one lines high
set laststatus=2 " enable status line always
set ruler " show the cursor position all the time

set scrolloff=3 " lines to always seeable when scrolling

" default text width, used with autoformatter and pasting
"set tw=80
"set wm=80

" just hide, dont close buffers (a lot of people love this, not me though)
set hidden

" Path setting for finding files
set path+=**,

" Function for saving when root priv required
cmap w!! w !sudo tee % >/dev/null

" allow more than 10 tabs with -p command
set tabpagemax=40

"###############################################################################
"# Highlight & Fold Settings                                                   #
"###############################################################################

" Use terminal background, need dark background
"colorscheme ir_black
"colorscheme pablo
"colorscheme oceandeep
"colorscheme elflord

" Change terminal background, use dark background
colorscheme mustang
"colorscheme torte

" Change terminal background, use light background
"colorscheme morning
"colorscheme peaksea
"colorscheme shine

" Work with light or dark terminal background (call set background to change)
"colorscheme default

if has("mac")
	colorscheme default
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

syntax sync fromstart
let hs_minlines = 500

set nonu " line numbers
set cursorline
let c_comment_strings=1 " highlighting strings inside C comments
set gcr=a:blinkon0
set showmatch " show matching brace when inserting one

" Like to use this in general but implemented in an ugly way in Vim
"set colorcolumn=100

let g:xml_syntax_folding=1 " enable xml folding
set foldenable
set foldmethod=syntax
set foldlevelstart=99 " open all folds by default

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

"###############################################################################
"# Indent Settings                                                             #
"###############################################################################

set tabstop=3 " tab space
set softtabstop=3 " fake tab spaces
set shiftwidth=3 " indent space
set noexpandtab " use tabs, not spaces
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

" nicer escape
imap jj <Esc>

"---------------
"# F[0-9] Keys #
"---------------

" enable/disable spell check
map <silent> <F6> <Esc>:setlocal spell! spelllang=en_au<CR>
imap <silent> <F6> <C-o>:setlocal spell! spelllang=en_au<CR>

" clear search highlight
map <silent> Q <Esc>:noh<CR>

" make F2 save and ,s
nmap <silent> <F2> <Esc>:w<CR>
imap <silent> <F2> <C-o>:w<CR>
nmap <silent> <Leader>s <Esc>:w<CR>

" Switch to paste mode
set pastetoggle=<F7>

"----------------------------
"# Other Text Movement Keys #
"----------------------------

" Sadly the below only really work in GVim.

" enable eclipse style moving of lines (needs GVim)
nmap <silent> <A-J> mz:m+<CR>`z==
nmap <silent> <A-K> mz:m-2<CR>`z==
imap <silent> <A-J> <Esc>:m+<CR>==gi
imap <silent> <A-K> <Esc>:m-2<CR>==gi
vmap <silent> <A-J> :m'>+<CR>gv=`<my`>mzgv`yo`z
vmap <silent> <A-K> :m'<-2<CR>gv=`>my`<mzgv`yo`z

" enable nice new line inserting in insert mode
imap <silent> <C-CR> <Esc>o
imap <silent> <C-S-CR> <Esc>O

" general windows delete commands
imap <silent> <C-BS> <Esc>vbc
imap <silent> <C-Del> <Esc>lvec

" map - to end of line, _ to start
noremap - ^
noremap _ $
nnoremap = $

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

" put pgdown pgup in nicer positions (normally same as l & h)
noremap <Space> <PageDown>
noremap <S-Space> <PageUp>

" scroll window but not line (normally same as i and x)
noremap <Ins> 2<C-Y>
noremap <Del> 2<C-E>

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
nmap <Leader>n :tabnew<CR>

" tab close (TODO: detect if on last tab and don't call previous)
map <Leader>w :tabclose\|tabprevious<CR>
" close window
map <Leader>q :q<CR>
" quit vim
map <Leader>Q :qall!<CR>


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
command! Wgrep :execute 'noautocmd vimgrep /'.expand('<cword>').'/gj **/*'.expand('%:e').' | cl'

command! Rlp :source $MYVIMRC
command! Ep :e $MYVIMRC


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
"runtime ftplugin/man.vim

"------------
"# snipMate #
"------------
let g:snips_author = 'David Terei'
"ino <silent> " "<c-r>=TriggerSnippetWord('"')<cr>
"ino <silent> ( (<c-r>=TriggerSnippetWord('(')<cr>
"ino <silent> { {<c-r>=TriggerSnippetWord('{')<cr>
"ino <silent> [ [<c-r>=TriggerSnippetWord('[')<cr>

"-----------------
"# Lust Explorer #
"-----------------
let g:LustyJugglerSuppressRubyWarning = 1

"---------
"# Gundo #
"---------
nnoremap U :GundoToggle<CR>

"----------------
"# Haskell Mode #
"----------------
" use ghc functionality for haskell files
au Bufenter *.hs  compiler ghc
au Bufenter *.lhs compiler ghc

" configure browser for haskell_doc.vim
if has("mac")
	let g:haddock_browser = "open"
	let g:haddock_browser_callformat = "%s %s"
elseif has("win32") || has ("win64")
	let g:haddock_browser = "C:/Program Files/Opera/Opera.exe"
else
	let g:haddock_browser = "opera"
	let g:haddock_docdir = "/usr/share/doc/ghc6-doc/html"
	let g:haddock_indexfiledir=$MYVIM."/"
	let g:ghc = "/usr/bin/ghc"
endif

" Enable increased Haskell highlighting
let hs_highlight_boolean = 1
let hs_highlight_types = 1
let hs_highlight_more_types = 1
let hs_highlight_debug = 1
let hs_highlight_classes = 1
let hs_highlight_functions = 1

"###############################################################################
"# File End                                                                    #
"###############################################################################

