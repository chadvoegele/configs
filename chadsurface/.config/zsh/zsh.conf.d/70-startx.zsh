if [ -z "$DISPLAY" ] && [ $(tty) = /dev/tty1 ] && [ $(whence startx) ]
then
  startx -- -dpi 180 -ardelay 250 -arinterval 20 vt1
  logout
fi
