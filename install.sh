#!/bin/bash

dir=~/dotfiles
files="vimrc tmux.conf bashrc"

cd $dir
for file in $files; do
	ln -s $dir/$file ~/.$file
done

if [ ! -d ~/.vim/bundle/vundle ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle
	vim +PluginInstall +qall
fi
