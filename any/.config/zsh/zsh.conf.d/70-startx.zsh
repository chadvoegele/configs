# Start X if it is vc1 and X hasn't been started already
if [ -z "$DISPLAY" ] && [ $(tty) = /dev/tty1 ]
then
  startx -- -dpi 180 -ardelay 250 -arinterval 20 vt1
  logout
fi
