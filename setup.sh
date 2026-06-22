#!/bin/sh

# determine git repo directory
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd  )

# setup config files
ln -sf "${DIR}/_vimrc" ~/.vimrc
ln -sf "${DIR}/_gvimrc" ~/.gvimrc
if [ -x ~/.vim ]; then
  rm ~/.vim
fi
ln -sf "${DIR}/vimfiles" ~/.vim

# setup vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# load plugins
vim -c PlugInstall -c q -c q
