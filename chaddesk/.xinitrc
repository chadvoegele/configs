#!/bin/sh
source x_settings.sh
xbindkeys &

xrdb -merge ~/.Xresources

/usr/bin/status_bar &

exec openbox
