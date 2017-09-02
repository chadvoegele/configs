#!/bin/sh
source x_settings.sh
xbindkeys &

xrdb -merge ~/.Xresources
source /home/chad/.fehbg
/usr/bin/status_bar &

exec openbox
