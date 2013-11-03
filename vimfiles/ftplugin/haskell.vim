setlocal shiftwidth=2
setlocal tabstop=8
setlocal softtabstop=2
setlocal expandtab
setlocal textwidth=79

map <Leader>ll :call Send_to_Tmux("ghci " . expand("%:p") . "\n")<CR>

