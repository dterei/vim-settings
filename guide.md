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

TODO: preview window, location list, quickfix

2. Vim Regex
------------

TODO

3. Functions, Commands, Expressions
-----------------------------------

Vim has a confusing using of types for its Ex language.

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

$ :A "toggles current file between .h/.c
$ :AS "loads .h/.c alternate in horizontal split
$ :AV "loads .h/.c alternate in vertical split
$ :AT "loads .h/.c alternate in new tab

5. Bufexplorer
--------------

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
  rvm use system "have to install against vim ruby version
  cd ~/.vim/ruby/command-t
  ruby extconf.rb
  make

$ <Leader>t OR :CommandT "Bring up Command-T window

On file can use:
  <CR>        open the selected file
  <C-CR>      open the selected file in a new split window
  <C-s>       open the selected file in a new split window
  <C-v>       open the selected file in a new vertical split window
  <C-t>       open the selected file in a new tab

7. LustyExplorer
---------------- 

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

$ :Tabularize /, "align selected text to ',', note can often not
                  select text and just let tabularize figure out
                  Left aligned
$ :Tabularize /,/r0 "as above but right aligned with no spaces

Format specifier is: [lrc][\d]

10. Surround
------------

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

$ gc{motion}   "Toggle comments (for small comments within one line 
                the &filetype_inline style will be used, if 
                defined)
$ gcc          "Toggle comment for the current line
$ gC{motion}   "Comment region
$ gCc          "Comment the current line

14. Conque-Shell
----------------

15. Fugutive (Git)
------------------

16. Bookmarking
---------------

17. YankRing
------------

18. Gundo
---------

19. ToggleMouse
---------------

20. EasyMotion
--------------

21. HaskellMode
---------------

22. XmlEdit
-----------

