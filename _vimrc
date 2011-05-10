" ==============================================================================
" David Terei's .vimrc file
"
" Vim Version: 7.2.0
" Plugins Used:
"  - a:
"      Quickly switch between source files and header files.
"  - autoclose:
"      Close braces, brackets and quotations.
"  - bookmarking:
"      Provide a bookmarking facility for Vim. Mark lines of interest.
"  - bufexplorer:
"     With bufexplorer, you can quickly and easily switch between buffers.
"  - closetag:
"     Functions and mappings to close open HTML/XML tags.
"  - fugutive:
"     Git plugin.
"  - HaskellMode.vba:
"     Haskell mode plugin.
"  - Lusty-Explorer
"     A fuzzy search file and buffer browser.
"  - Matchit:
"     Extended % matching for HTML, LaTeX, and many other languages.
"  - snipMate:
"     An attempt to emulate TextMate's snippet expansion.
"  - YankRing:
"     Maintains a history of previous yanks and deletes.
"  - xmledit:
"     A filetype plugin to help edit XML, HTML and SGML documents.
"
" Colour Schemes:
"     - cobalt.vim
"     - darkZ.vim
"     - darkslategray.vim
"     - darkspectrum.vim
"     - fruity.vim
"     - ir_black.vim
"     - kib_darktango.vim
"     - oceandeep.vim
"     - ps_color.vim
"     - pyte.vim
"     - twilight.vim
"     - zenburn.vim
"
" ==============================================================================


"###############################################################################
"# Essential Settings                                                          #
"###############################################################################
set nocompatible

" OS neutral variable for referring to user files
" assume unix, change if not
let $MYVIM=$HOME."/.vim"

" if on WIN32
if has("win32")
	"source $VIMRUNTIME/mswin.vim
	let $MYVIM=$VIM
endif

let $SS=$MYVIM."/sessions"

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


"###############################################################################
"# General Settings                                                            #
"###############################################################################

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

set history=30 " keep 30 lines of command line history
set viminfo='500,f1,<500,s50,:0,@30,/30,! " what to store for each file
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize

set incsearch  " do incremental searching
set ignorecase " make this default, turn on case in search with /<search>\C/
" type small case will search case independent, type mixed case will use exact
set smartcase

" ignore these files for auto...
set wildignore+=*.o,+=*.obj,+=*.bak,+=*.exe,+=*~,+=*.hi

" don't lcd to the current buffers directory, this is a nice feature but
" causes a lot of problems, so instead I use some keyboard shortcuts to
" open tabs at the current files dir... ect.
set noacd

set ch=1 " Make command line one lines high
set laststatus=2 " enable status line always
set ruler " show the cursor position all the time

set scrolloff=3 " lines to always seeable when scrolling

"set tw=80 " default text width, used with autoformatter and pasting
"set wm=80
" gq " autoformatter command

" My spell file, used to store new words
"set spellfile='$MYVIM/spellfile'

" Path setting for finding files
set path+=**,

"###############################################################################
"# Highlight & Fold Settings                                                   #
"###############################################################################

" Set colour map
if has("gui_running")
	"colorscheme blue
	"colorscheme cobalt
	colorscheme cobaltish
	"colorscheme darkZ
	"colorscheme darkslategray
	"colorscheme fruity
	"colorscheme ir_black
	"colorscheme kib_darktango
	"colorscheme oceandeep
	"colorscheme ps_color
	"colorscheme pyte
	"colorscheme twilight
	"colorscheme zenburn
else
	set background=dark
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

set colorcolumn=100

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

"----------------------------
"# Other Text Movement Keys #
"----------------------------

" enable eclipse style moving of lines (needs GVim)
nmap <silent> <A-S-j> mz:m+<CR>`z==
nmap <silent> <A-S-k> mz:m-2<CR>`z==
imap <silent> <A-S-j> <Esc>:m+<CR>==gi
imap <silent> <A-S-k> <Esc>:m-2<CR>==gi
vmap <silent> <A-S-j> :m'>+<CR>gv=`<my`>mzgv`yo`z
vmap <silent> <A-S-k> :m'<-2<CR>gv=`>my`<mzgv`yo`z

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
cnoremap <C-[> <Esc>
cnoremap <Esc> <C-C>

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

" tab close
map <Leader>w :tabclose<CR>
" close window
map <Leader>q :q<CR>
" quit vim
map <Leader>Q :qall!<CR>


"###############################################################################
"# Diff Settings                                                               #
"###############################################################################

" Setup diffexpr for proper diff call
set diffexpr=MyDiff()
function! MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	let eq = ''
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			let cmd = '""' . $VIMRUNTIME . '\diff"'
			let eq = '"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	else
		let cmd = $VIMRUNTIME . '\diff'
	endif
	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis


"###############################################################################
"# New Functions                                                               #
"###############################################################################

" Delete trailing whitespace and tabs at the end of each line
command! DeleteTrailingWs :%s/\s\+$//e

command! Wgrep :execute 'noautocmd vimgrep /'.expand('<cword>').'/gj **/*'.expand('%:e').' | cl'

command! Rlp :source $MYVIMRC


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

