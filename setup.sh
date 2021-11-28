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

# load vundle
git submodule init
git submodule update

# load plugins
vim -c PluginInstall -c q -c q
