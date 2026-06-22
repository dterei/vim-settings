" ==============================================================================
" David Terei's .vimrc file
"
" Vim Version: 8.2
"
" ==============================================================================

"# Essential Settings {{{
"###############################################################################

" OS neutral variable for referring to user files
" assume unix, change if not
let $MYVIM=$HOME."/.vim"

if has("win32")
  let $MYVIM=$VIM
endif

" Set location to save sessions
let $SS=$MYVIM."/sessions"

" Setup fzf
set rtp+=~/.fzf
set rtp+=/usr/local/opt/fzf
set rtp+=/opt/homebrew/opt/fzf

" }}}

"# vim-plug Plugin Manager {{{
"###############################################################################
" https://github.com/junegunn/vim-plug

call plug#begin()

" With bufexplorer, you can quickly and easily switch between buffers.
Plug 'jlanzarotta/bufexplorer'
" NERD Tree filesystem explorer
Plug 'scrooloose/nerdtree'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" AutoSave
Plug '907th/vim-auto-save'

" Fuzzy file finding
Plug 'junegunn/fzf.vim'
" Provides a bookmarking facility for Vim. Mark lines of interest.
Plug 'dterei/VimBookmarking'
" Tag listing / Class explorer
Plug 'majutsushi/tagbar'
" Easy moving / jumping
Plug 'easymotion/vim-easymotion'

" Visualise the undo tree of vim.
Plug 'mbbill/undotree'
" Git plugin.
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" Display changes from git in side signs.
Plug 'airblade/vim-gitgutter'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Auto closing of quotes, parenthesis, brackets... ect
Plug 'Raimondi/delimitMate'
" Align text to columns
Plug 'godlygeek/tabular'
" Quickly surround some text (i.e bracket, html tags...)
Plug 'tpope/vim-surround'
" Toggle commenting
Plug 'tomtom/tcomment_vim'
" Argwrap - reformat function to single vs multi-line
Plug 'FooSoft/vim-argwrap'

" More repeat (.) support (for plugins)
Plug 'tpope/vim-repeat'
" Improved :man & :help (and other docs) viewer
Plug 'powerman/vim-plugin-viewdoc'
" Maintains a history of previous yanks and deletes.
Plug 'vim-scripts/YankRing.vim'
" Add some nice mappings for common commands like :lnext
Plug 'tpope/vim-unimpaired'

" Golang support
Plug 'fatih/vim-go'
" Haskell folding
Plug 'Twinside/vim-haskellFold'
" Markdown support (alternative)
Plug 'plasticboy/vim-markdown'
" Rust support
Plug 'rust-lang/rust.vim'
" TypeScript
Plug 'leafgarland/typescript-vim'
" Arcanist support
Plug 'solarnz/arcanist.vim'
" Ansible support
Plug 'pearofducks/ansible-vim'
" GraphQL support
Plug 'jparise/vim-graphql'
" Powershell support
Plug 'PProvost/vim-ps1'

" " === Colour Schemes! ===
Plug 'altercation/vim-colors-solarized'

call plug#end()

" }}}

"# Vim 8 Plugins {{{
"###############################################################################

" Comes with Vim, just not enabled by default - extended '%' matching
packadd! matchit

" }}}

"# General Settings {{{
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

" ensure use zsh with terminal
if executable('zsh')
  set shell=zsh
endif

" nice features but vim is very stable and I save a lot
set nobackup
set noswapfile

" enable autosave before some commands
set autowrite

" redraw only when we need to."
set lazyredraw

set encoding=utf-8
"set termencoding=latin1

set mouse= " disable mouse in terminal

set showcmd  " display incomplete commands
set wildmenu " way cooler command line mode completion

" completion settings
set completeopt=menuone

set history=100 " keep 100 lines of command line history
set viminfo='500,f1,<500,s50,:0,@30,/30,! " what to store for each file
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
" permanent undo
set undofile
set undodir=$MYVIM/undo

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

set switchbuf=useopen

" Display as much of possible of lines that fill the whole screen instead of
" the default '@' display mode
set display+=lastline

" Use better grep if available
if executable('rg')
  set grepprg=rg\ --no-heading\ --with-filename\ --line-number
elseif executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

set cryptmethod=blowfish2

" Avoid showing quickfix list as a buffer
augroup qf
  autocmd!
  autocmd FileType qf set nobuflisted
augroup END

" }}}

"# Highlight & Fold Settings {{{
"###############################################################################

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  let python_highlight_all=1
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
colorscheme solarized

" below order and command is needed to fix gnome-terminal issue
let termprog = $TERM_PROGRAM
if termprog == 'Apple_Terminal'
  set t_Co=256
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
endif
set background=dark

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
set foldmethod=indent
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

" }}}

"# Indent Settings {{{
"###############################################################################

set tabstop=2 " tab space
set softtabstop=2 " fake tab spaces
set shiftwidth=2 " indent space
set expandtab " use spaces, not tabs
set smarttab " tab amount done according to previous lines
set autoindent

" }}}

"# KeyMap Settings {{{
"###############################################################################

" better handling of <Esc> key
set timeoutlen=1000 ttimeoutlen=10

" setup mapleader
let mapleader=","
let maplocalleader="\\"

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" disable alt modifier for menu shortcuts
set winaltkeys=no

" quick reload
nmap <silent> <Leader>5 :edit<CR>

"---------------
"# F[0-9] Keys #
"---------------

" clear search highlight
nmap <silent> Q :nohlsearch<CR>

" make F2 save
nmap <silent> <F2> :w<CR>
imap <silent> <F2> <C-o>:w<CR>

" super-save!
nnoremap <Leader>S :mksession! $SS/Session.vim<CR>
command! SaveSession :mksession! $SS/Session.vim
command! LastSession :source $SS/Session.vim

" enable/disable spell check
nmap <silent> <F6> :setlocal spell! spelllang=en_au<CR>
imap <silent> <F6> <C-o>:setlocal spell! spelllang=en_au<CR>

" Tagbar
nnoremap <silent> <F9> :TagbarToggle<CR>

" default is 'undercurl' that can be a wriggly underline but alacritty doesn't
" seem to support it
hi clear SpellBad
hi SpellBad cterm=underline

" Switch to paste mode
set pastetoggle=<F7>

" Toggle between all buffers and all tabs
"nnoremap <silent> <expr> <F8> ( tabpagenr('$') == 1 ? ':tab ball<Bar>tabn' : ':tabo' ) . '<CR>'

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

" map _ to end of line, - to start
nnoremap _ ^
nnoremap - $

" remap incr/decr since using them for other purposes
nnoremap <silent> <C-y> <C-a>
nnoremap <silent> <C-h> <C-x>

" remap complete cancel since remap to emacs
inoremap <silent> <C-l> <C-e>

" enable some emacs style keys
imap <silent> <C-e> <End>
imap <silent> <C-a> <Home>
nmap <silent> <C-e> $
nmap <silent> <C-a> ^
imap <silent> <C-f> <Right>
imap <silent> <C-b> <Left>
imap <silent> <C-h> <Backspace>
imap <silent> <C-d> <Delete>

" Stay in visual mode when indenting.
vnoremap < <gv
vnoremap > >gv

"-----------------------
"# Nicer Remapped Keys #
"-----------------------

" Nicer tag jumping keys
nmap <silent> <A-j> :tag<CR>
nmap <silent> <A-k> :pop<CR>
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

" nicer buffer switch
nmap <C-@> :b#<CR>

" Give tab cycling nicer keys (normally these just do same as j & k)
noremap <C-n> :bn<CR>
noremap <C-p> :bp<CR>

" new tab
nmap <Leader>e :edit %:p:h<CR>
nmap <Leader>E :edit .<CR>
"nmap <Leader>n :tabnew<CR>

" tab clsoe
map <Leader>q :bp\|bd #<CR>
" window close
map <Leader>w :close<CR>
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
noremap <silent> <Leader>< :execute 'silent! tabmove -1'<CR>
" Move current tab to the right
noremap <silent> <Leader>> :execute 'silent! tabmove +1'<CR>

" }}}

"# Diff Settings {{{
"###############################################################################

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis

" }}}

"# New Functions {{{
"###############################################################################

" Delete trailing whitespace and tabs at the end of each line
command! DeleteTrailingWs :%s/\s\+$//e

" Search all subdirectories for word under cursor
command! Wgrep :execute 'silent grep! '.expand('<cword>').' | copen'

" Easy .vimrc editing
command! Sv :source $MYVIMRC
command! Ev :e $MYVIMRC

" Go to latest version of file
command! Latest :later 10000d

" }}}

"# Plugins {{{
"###############################################################################

"# YankRing {{{
"--------------

let g:yankring_clipboard_monitor = 0
let g:yankring_replace_n_pkey = '<A-p>'
let g:yankring_replace_n_nkey = '<A-n>'
let g:yankring_max_display = 50
let g:yankring_history_dir = '$MYVIM'
nnoremap <silent> <Leader>y :YRShow<CR>

" }}}

"# netrw {{{
"-----------

let g:netrw_liststyle = 3
let g:netrw_banner = 0

" }}}

"# NERDTree {{{
"--------------

let NERDTreeHijackNetrw = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeQuitOnOpen = 0
let NERDTreeIgnore=[
\    '\~$[[file]]',
\    '\.o$[[file]]',
\    '\.hi$[[file]]',
\    '\.pyc$[[file]]',
\    '__init__.py$[[file]]',
\    '__pycache__$[[dir]]'
\  ]

nnoremap <silent> <F10> :NERDTreeToggle<CR>

autocmd FileType nerdtree setl bufhidden=delete

" }}}

"# ManPageView {{{
"-----------------

" This plugin is included in vim runtime but not all loaded by default
runtime ftplugin/man.vim

" }}}

"# FZF {{{
"---------------

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <silent> <Leader>t :Files<CR>
nnoremap <silent> <Leader>bb :Buffers<CR>
nnoremap <silent> <Leader>c :BTag<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" Text search
noremap <silent> <Leader>f :Rg<space>
noremap <silent> <Leader>F :Rg!<space>
noremap <silent> <Leader>G :execute 'Rg '.expand('<cword>')<CR>

" }}}

"# Delimitmate {{{
"-----------------

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" }}}

"# Undotree {{{
"-----------

nnoremap <silent> U :UndotreeToggle<CR>

" }}}

"# Fugutive {{{
"--------------

command! Gflog :Glog | :Gedit | :copen | wincmd k

" }}}

"# Haskell Mode {{{
"------------------

" Enable increased Haskell highlighting
let hs_highlight_boolean = 1
let hs_highlight_types = 1

let hs_highlight_more_types = 1
let hs_highlight_debug = 1
let hs_highlight_classes = 1
let hs_highlight_functions = 1

" }}}

"# Airline {{{
"--------------

" change layout
let g:airline#extensions#default#layout = [
  \ [ 'a', 'b', 'x', 'c' ],
  \ [ 'warning', 'z' ]
  \ ]

let g:airline_powerline_fonts = 1
" let g:airline_symbols_ascii = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" " unicode symbols
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '◀'
" let g:airline_left_alt_sep = '>'
" let g:airline_right_alt_sep = '<'
"
" " powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''

let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇ '
let g:airline_symbols.readonly = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Disable tagbar integration as forces early load slowing startup
let g:airline#extensions#tagbar#enabled = 0
" allow spaces only after all tabs
let g:airline#extensions#whitespace#mixed_indent_algo = 2
" don't show hunks changed
let g:airline#extensions#hunks#enabled = 0

" display paste status
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_crypt=1
let g:airline_detect_spell=1

let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" }}}

"# Vim-go {{{
"-------------

" Enable features
let g:go_code_completion_enabled = 1
let g:go_gopls_enabled = 1
let g:go_asmfmt_autosave = 0
let g:go_fmt_autosave = 1
let g:go_imports_autosave = 1
let g:go_auto_sameids = 0
let g:go_auto_type_info = 0
let g:go_metalinter_autosave = 0
let g:go_diagnostics_enabled = 1

" Doc
let g:go_doc_keywordprg_enabled = 1
let g:go_doc_popup_window = 1

" Testing
let g:go_test_show_name = 1
let g:go_test_timeout= '20s'

" Engines
let g:go_info_mode = 'gopls'
let g:go_fmt_command = 'gopls'
let g:go_imports_mode = 'goimports'
let g:go_metalinter_command = 'golangci-lint'
let g:go_implements_mode = 'gopls'
let g:go_def_mode = 'gopls'
let g:go_fillstruct_mode = 'fillstruct'
let g:go_referrers_mode = 'gopls'

" Syntax highlighting
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 0
let g:go_highlight_function_calls = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 0

" Configure goimports
let g:go_gopls_local = 'rubrik'
let g:go_fmt_options = {
\ 'gofmt': '-s',
\ 'goimports': '-local rubrik',
\}

" Configure GoMetaLinter
let g:go_metalinter_enabled = [
\ 'deadcode',
\ 'goimports',
\ 'ineffassign',
\ 'lll',
\ 'misspell',
\ 'nakedret',
\ 'vetshadow',
\]

" Share gopls
let g:go_gopls_options = ['-remote=auto']

au Filetype go nmap <leader>dv <Plug>(go-def-vertical)
au Filetype go nmap <leader>ds <Plug>(go-def-split)

au Filetype go nmap <leader>D <Plug>(go-doc)
au Filetype go nmap <leader>gd <Plug>(go-doc-vertical)
au Filetype go nmap <leader>gb <Plug>(go-doc-browser)

au Filetype go nmap <leader>I :exe "GoImports"<CR>
au Filetype go nmap <leader>B <Plug>(go-build)
au Filetype go nmap <leader>R <Plug>(go-run)
au Filetype go nmap <leader>T :exe "GoTest -short"<CR>
au Filetype go nmap <leader>gT <Plug>(go-test-func)
au Filetype go nmap <leader>gi <Plug>(go-info)
au Filetype go nmap <leader>gr <Plug>(go-rename)
au Filetype go nmap <leader>gf <Plug>(go-format)
au Filetype go nmap <leader>gl <Plug>(go-metalinter)
au Filetype go nmap <leader>gt :exe "GoDecls"<CR>

" Enable GoAlternate with tranditional mappings
augroup mygo
  autocmd!
  autocmd Filetype go
    \  command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go
    \ command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go
    \ command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go
    \ command! -bang AT call go#alternate#Switch(<bang>0, 'tabedit')
augroup END

" }}}

"# Ultisnips {{{
"---------------

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" }}}

"# Ansible {{{
"-------------

let g:ansible_extra_syntaxes = 'yaml.vim'

" }}}

"# TmuxLine {{{
"-------------

let g:tmuxline_powerline_separators = 1

let g:tmuxline_preset = {
    \'a'       : '#S',
    \'win'     : '#I #W',
    \'cwin'    : '#I #W',
    \'z'       : '#H',
    \'options' : {'status-justify' : 'left'}}

" }}}

"# ArgWrap {{{
"------------

let g:argwrap_tail_comma = 1

nnoremap <silent> <leader>a :ArgWrap<CR>

" }}}

" }}}

" vim:foldmethod=marker:foldlevel=0
