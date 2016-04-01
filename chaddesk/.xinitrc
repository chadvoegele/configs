#!/bin/sh
source x_settings.sh
xbindkeys &

xrandr -s 1920x1200

/usr/bin/status_bar &

exec openbox
