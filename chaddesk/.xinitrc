#!/bin/sh
# keyboard
setxkbmap us_mod -option ctrl:nocaps
xset r rate 250 20
xbindkeys &

# no bell
xset b off

# screen settings
xset dpms 0 0 180
xrandr -s 1920x1200

source /home/chad/.config/feh/fehbg
/usr/bin/status_bar &

exec pekwm
