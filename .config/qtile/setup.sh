xrdb -merge ~/.Xresources
feh --no-xinerama --bg-scale ~/.background.png
xsetroot -cursor_name left_ptr
/usr/libexec/polkit-gnome-authentication-agent-1 &
chromium-browser --type=service --ignore-gpu-blacklist
