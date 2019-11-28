# Start X if it is vc1 and X hasn't been started already
if [ -z "$WAYLAND_DISPLAY" ] && [ $(tty) = /dev/tty1 ] && [ $(whence sway) ]
then
  WAYLAND_DISPLAY="wayland-0"
  sway
  logout
fi
