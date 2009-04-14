" Source other plugins and scripts

" Remove current syntax
unlet b:current_syntax

source $VIMRUNTIME/syntax/xml.vim
source $MYVIMFILES/ftplugin/xml.vim
source $MYVIMFILES/after/ftplugin/xslt.vim

" Set format
set foldmethod=syntax
set shiftwidth=2
set tabstop=2
set expandtab

" New Functions
nmap % <Localleader>5

" Rename tag
nmap <Leader>r mz_f:lywu%_t:ll"_dwP"_x'z_f:l"_dwP

" Done
echo "XML mode is on"

