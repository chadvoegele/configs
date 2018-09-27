#!/bin/sh
source x_settings.sh
xbindkeys &
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock &

xrdb -merge ~/.Xresources

/usr/bin/status_bar &

exec openbox
