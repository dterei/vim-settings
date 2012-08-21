Vim Guide
=========

The purpose of this guide is to serve as a quick reference to myself
to remember some of the useful but less used Vim features and plugins
that can be helpful.

1. Buffers, Windows, Tabs
-------------------------

Summary:
   A buffer is the in-memory text of a file.
   A window is a viewport on a buffer.
   A tab page is a collection of windows.

$ <CTRL-W r> "rotate windows
$ <CTRL-W T> "move current window to far left (horiz -> vert)
$ <CTRL-W K> "move current window to far top (vert -> horiz)
$ :ls "list buffers (with their id)
$ :e #<id> "switch to buffer <id>

Vim has a concept of an 'alternate file'. This is simply the last file
other than the current one you editted. The idea is to allow quickly
switching between two files:

$ <CTRL-6> "swap between the alternate and current file
$ :e # "as above

1.2 Quickfix and Co.
---------------------

Original idea of quickfix is a buffer (and mappings) for storing
error messages from a compiler to speed up edit-compile-edit cycle.

$ :cl
$ :cc [nr]
$ :cn
$ :cp

TODO: preview window, location list...

2. Vim Regex
------------

TODO

3. Functions, Commands, Expressions
-----------------------------------

Vim has a confusing use of types for its Ex language.

$ :<command>
$ :echo <expr> "expr can be a function
$ :call <function> "only really for side effects
$ :<command> | <command> "append commands together
$ :execute <expr_str> "execute a string as an expr

$ :echo expand("%") "echos current file name
$ :echo expand("#") "echos alternative file name

Note 'echo' is a command.

* 'va{<expr>}xe': create a dynamic variable name

* <Leader> "remapable key for plugins to create mappings under (e.g
            plugin key namespace) (default key is '\')
* <Plug> "create key mapping that matches nothing so the user can
          remap at will

4. a.vim
--------

Mappings for dealing with .c/.h related files in C.

$ :A "toggles current file between .h/.c
$ :AS "loads .h/.c alternate in horizontal split
$ :AV "loads .h/.c alternate in vertical split
$ :AT "loads .h/.c alternate in new tab

5. Bufexplorer
--------------

Buffer manager.

$ <Leader>be "open buf explorer in current window
$ <Leader>bs "open be in new horiz split
$ <Leader>bv "open be in new vert split

In be window:

$ <enter> "open buffer
$ <shift-enter> "open buffer in new tab
$ d "delete buffer
$ q "quit be

6. Command-T
------------

Fast file finder. Requires Ruby.

Install: 
  rvm use system "have to install against Vim ruby version
  cd ~/.vim/ruby/command-t
  ruby extconf.rb
  make

$ <Leader>f OR :CommandT "Bring up Command-T window

On file can use:
  <CR>        open the selected file
  <C-CR>      open the selected file in a new split window
  <C-s>       open the selected file in a new split window
  <C-v>       open the selected file in a new vertical split window
  <C-t>       open the selected file in a new tab

7. LustyExplorer
---------------- 

Fuzzy matching filesystem explorer (quicklist like operation).

$ <Leader>lf "Opens filesystem explorer. 
$ <Leader>lr "Opens filesystem explorer at the directory of the current file. 
$ <Leader>lb "Opens buffer explorer. 
$ <Leader>lg "Opens buffer grep. Uses ruby style regrex

During Use:
  $ <CTRL-R> "Directory contents are memoized, refresh.

8. Ragtag
---------

TODO

9. Tabular
----------

Alignment tool for text.

$ :Tabularize /, "align selected text to ',', note can often not
                  select text and just let tabularize figure out
                  Left aligned
$ :Tabularize /,/r0 "as above but right aligned with no spaces

Format specifier is: [lrc][\d]

10. Surround
------------

Mapping for dealing with wrapping text.

* "Hello *world!"           ds"     =>  Hello world!
* {123+4*56}/2              cs])    =>  (123+456)/2
* "Look ma, I'm *HTML!"     cs"<q>  =>  <q>Look ma, I'm HTML!</q>
* if *x>3 {                 ysW(    =>  if ( x>3 ) {
* my $str = *whee!;         vllllS' =>  my $str = 'whee!';
* <ul>hello world</ul>      cst<ol> => <ol>hello world</ol>

$ ds<surrounding> "delete surrounding
$ cs<old><new> "change surrounding
$ ys<movement><surrounding> "take movement and wrap text object
$ yss<surrounding> "wrap current line
$ S<surrounding> "wrap selected text

Insert mode mappings:
  $ <C-S><surround> "create surround
  $ <C-G>S<surround> "put on new lines

11. DelimitMate
---------------

Mostly auto insertion of closing pair but:

$ <S-BS> "after insertion of pair deletes closing element

12. SnipMate
------------

TODO

13. T-Comment
-------------

Comment out code.

$ gc{motion}   "Toggle comments (for small comments within one line 
                the &filetype_inline style will be used, if 
                defined)
$ gcc          "Toggle comment for the current line
$ gC{motion}   "Comment region
$ gCc          "Comment the current line

14. Conque-Shell
----------------

Shell inside Vim.

$ :ConqueTerm bash
$ :ConqueTermSplit mysql -h localhost -u joe Menu
$ :ConqueTermVSplit <command>


15. Fugutive (Git)
------------------

Git plugin.

$ :Git <command> "run arbitrary git command

$ :Gstatus
$ :Glog "load all previous revisions of file into quicklist
$ :Glog -- "as above, but for all commits (so all files...)
$ :Gdiff [revision] "git diff of current file with working copy
$ :Gblame "git blame currrent file

$ :Gbrowse "open the current file, revision... on github or git-instaweb
$ :Gcommit
$ :Gedit [revision] "edit a specific revision of a file
$ :Gwrite "write the current file to disk + do git add
$ :Gmove {dest} "git move the file
$ :Gremove "remove the file from git

Mappings:
    <C-N> next file
    <C-P> previous file
    <CR>  |:Gedit|
    P     Go to the current file in the [count]th parent
    -     |:Git| add
    -     |:Git| reset (staged files)
    C     |:Gcommit|
    cA    |Gcommit| --amend --reuse-message=HEAD
    ca    |Gcommit| --amend
    D     |:Gdiff|
    ds    |:Gsdiff|
    dp    |:Git!| diff (p for patch; use :Gw to apply)
    dp    |:Git| add --intent-to-add (untracked files)
    dv    |:Gvdiff|
    O     |:Gtabedit|
    o     |:Gsplit|
    p     |:Git| add --patch
    p     |:Git| reset --patch (staged files)
    q     close status
    R     reload status

16. Bookmarking
---------------

Plugin for adding 'bookmarks' to a file (no need to remember them).

In .vimrc:
$ map <silent> <F3> :ToggleBookmark<CR>
$ map <silent> <F4> :PreviousBookmark<CR>
$ map <silent> <F5> :NextBookmark<CR>

17. YankRing
------------

A ring (history) of previous yanks.

$ <Leader>y "open yankring

Use normal keys to browse, q to close, <enter> to paste

18. Gundo
---------

Undo tree GUI.

$ U "In normal mode, toggles Gundo GUI

19. ToggleMouse
---------------

Press `<F12>` to toggle mouse focus between Vim and your terminal emulator,
allowing terminal emulator mouse commands, like copy/paste.

20. EasyMotion
--------------

New way to jump around in Vim.

$ <Leader><Leader>w

Note: Most movement keys [w,f,t,T...] work.

21. HaskellMode
---------------

Haskell plugin.

:make                load into GHCi, show errors (quickfix :copen)
_ct                  create |tags| file 
_si                  show info for id under cursor
_t                   show type for id under cursor
_T                   insert type declaration for id under cursor
balloon              show type for id under mouse pointer
_?                   browse Haddock entry for id under cursor
_?1                  search Hoogle for id under cursor
_?2                  search Hayoo! for id under cursor
:IDoc {identifier}   browse Haddock entry for unqualified {identifier}
:MDoc {module}       browse Haddock entry for {module}
:FlagReference {s}   browse Users Guide Flag Reference for section {s}
_.                   qualify unqualified id under cursor
_i                   add 'import <module>(<identifier>)' for id under cursor
_im                  add 'import <module>' for id under cursor
_iq                  add 'import qualified <module>(<identifier>)' for id under cursor
_iqm|                 add 'import qualified <module>' for id under cursor
_ie                  make imports explit for import statement under cursor
_opt                 add OPTIONS_GHC pragma
_lang                add LANGUAGE pragma
i_CTRL-X_CTRL-O      insert-mode completion based on imported ids (haskellmode-XO)
i_CTRL-X_CTRL-U      insert-mode completion based on documented ids (haskellmode-XU)
i_CTRL-N             insert-mode completion based on imported sources
:GHCi|{command/expr} run GHCi command/expr in current module

:GHCStaticOptions    edit static GHC options for this buffer
:DocSettings         show current Haddock-files-related plugin settings
:DocIndex            populate Haddock index 
:ExportDocIndex      cache current Haddock index to a file
:HpasteIndex         Read index of most recent entries from hpaste.org
:HpastePostNew       Submit current buffer as a new hpaste 

22. XmlEdit
-----------

XML editing plugin.

<LocalLeader><Space>
        Normal or Insert - Continue editing after the ending tag.
<LocalLeader>x
        Visual - Place a custom XML tag to suround the selected text.
<LocalLeader>d
        Normal - Deletes the surrounding tags from the cursor.

23. ToDo
--------

Bundle 'Mark'
Bundle 'tpope/unimpaired.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'ujihisa/neco-ghc'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'netrw.vim'
Bundle 'matchit.zip'
Bundle 'nathanaelkane/vim-indent-guides'

