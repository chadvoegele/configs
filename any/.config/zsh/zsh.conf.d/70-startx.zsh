# Start X if it is vc1 and X hasn't been started already
if [ -z "$DISPLAY" ] && [ $(tty) = /dev/tty1 ] && [ $(whence startx) ]
then
  sway
  logout
fi
