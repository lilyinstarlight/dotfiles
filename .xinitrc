#!/bin/sh
[ -n "$XDG_SESSION_DESKTOP" ] || export XDG_SESSION_DESKTOP="Xsession"
exec /etc/X11/Sessions/$XDG_SESSION_DESKTOP
