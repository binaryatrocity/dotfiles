#!/bin/bash

dir=~/dotfiles
files="vimrc tmux.conf bashrc"

cd $dir
for file in $files; do
	ln -s $dir/$file ~/.$file
done

if [ ! -d ~/.vim/bundle/vundle ]; then
	git clone https://github.com/gmarik/vundle.git  ~/.vim/bundle/vundle
	vim +BundleInstall +qall
fi
