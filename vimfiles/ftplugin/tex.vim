" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
setlocal noexpandtab
setlocal textwidth=70

" Smartindent is stupid on Latex
set nosmartindent

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

