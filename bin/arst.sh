#!/bin/sh
setxkbmap -v -option ctrl:nocaps us_mod && xset r 66
xset r rate 250 20
numlockx

rm $HOME/.vimrc
ln -s $HOME/.config/vim/vimrc_us_mod $HOME/.vimrc

rm $HOME/.screenrc
ln -s $HOME/.config/screen/screenrc_us_mod $HOME/.screenrc

rm $HOME/.lesskey
ln -s $HOME/.config/less/lesskey_us_mod $HOME/.lesskey
lesskey

rm $HOME/.vromerc
ln -s $HOME/.config/vrome/vromerc_us_mod $HOME/.vromerc
