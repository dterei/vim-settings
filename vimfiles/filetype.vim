"------------------
"# Haskell Syntax #
"------------------
augroup filetype
	au BufRead,BufNewFile *.hsc  set filetype=haskell
	au BufRead,BufNewFile *.x    set filetype=haskell
	au BufRead,BufNewFile *.y    set filetype=haskell
	au BufRead,BufNewFile *.y.pp set filetype=haskell
	au BufRead,BufNewFile *.hc   set filetype=c
	au BufRead,BufNewFile *.cmm  set filetype=c
augroup END

"--------------
"# Goc Syntax #
"--------------
augroup filetype
	au BufRead,BufNewFile *.goc set filetype=c
augroup END

"---------------
"# LLVM Syntax #
"---------------
augroup filetype
	au BufRead,BufNewFile *.ll set filetype=llvm
	au BufRead,BufNewFile *.td set filetype=tablegen
augroup END

"-------------------
"# Markdown Syntax #
"-------------------
augroup filetype
	au BufRead,BufNewFile *.md  set filetype=markdown
augroup END

