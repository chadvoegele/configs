#!/bin/sh
setxkbmap -v -option ctrl:nocaps colemak && xset r 66
xset r rate 250 20
numlockx

rm $HOME/.vimrc
ln -s $HOME/.config/vim/vimrc_colemak $HOME/.vimrc

rm $HOME/.screenrc
ln -s $HOME/.config/screen/screenrc_colemak $HOME/.screenrc

rm $HOME/.lesskey
ln -s $HOME/.config/less/lesskey_colemak $HOME/.lesskey
lesskey

rm $HOME/.vromerc
ln -s $HOME/.config/vrome/vromerc_colemak $HOME/.vromerc
