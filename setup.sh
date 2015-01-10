#!/bin/sh

#DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd  )
DIR="$HOME/Vim"

# setup config files
ln -sf "${DIR}/_vimrc" ~/.vimrc
ln -sf "${DIR}/_vgimrc" ~/.gvimrc
if [ -x ~/.vim ]; then
  rm ~/.vim
fi
ln -sf "${DIR}/vimfiles" ~/.vim

# load vundle
git submodule init
git submodule update

# load plugins
vim -c VundleInstall -c q -c q

