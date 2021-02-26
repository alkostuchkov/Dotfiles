#!/usr/bin/env bash 

# picom --experimental-backends &
# picom --config $HOME/.config/picom/picom.conf &
# compton --config $HOME/.config/compton/compton.conf &
# urxvtd -q -o -f &
# /usr/bin/emacs --daemon &
# xfce4-clipman &
kbdd &
nitrogen --restore &
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
volumeicon &
nm-applet &
xfce4-power-manager &
diodon &
conky -c ~/.myScripts/conky/conkyrc1 &
dropbox start -i &
compton --config $HOME/.config/compton.conf &
$HOME/Programs/CheckEmail/CheckEmail &
xrdb $HOME/.Xresources &
# -a (--automount) -n (--notify) -t (--tray) -s (--smart-tray)
# -A (--no-automount) -N (--no-notify) -T (--no-tray)
udiskie &
# udiskie --no-automount -n -t &
# udiskie -a -n -t &
