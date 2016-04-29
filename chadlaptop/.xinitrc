#!/bin/sh
source x_settings.sh
xbindkeys &

source /home/chad/.fehbg
/usr/bin/status_bar &

exec openbox
