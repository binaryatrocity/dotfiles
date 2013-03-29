#!/bin/bash

dir=~/dotfiles
files="vimrc tmux.conf conkyrc"

cd $dir
for file in $files; do
	ln -s $dir/$file ~/.$file
done

chmod +x dwmstart
ln -s $dir/dwmstart ~/dwmstart

if [ ! -d ~/.vim/bundle/vundle ]; then
	git clone https://github.com/gmarik/vundle.git  ~/.vim/bundle/vundle
	vim +BundleInstall +qall
fi

