#!/usr/bin/env bash 

# picom --experimental-backends &
# compton --config $HOME/.config/compton/compton.conf &
# compton --config $HOME/.config/compton.conf &
# urxvtd -q -o -f &
# xfce4-clipman &
# setxkbmap -layout us,ru -option grp:caps_toggle &
# /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &  # for Debian
xmodmap -e 'keycode 135 = Super_R' # Map the menu button to right super
kbdd &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &  # for Arch
xrdb $HOME/.Xresources &
nitrogen --restore &
volumeicon &
nm-applet &
xfce4-power-manager &
diodon &
picom --config $HOME/.config/picom/picom.conf &
conky -c ~/.myScripts/conky/conkyrc1 &
$HOME/Programs/CheckEmail/CheckEmail &
udiskie &  # ~/.config/udiskie/config.yml
# megasync &
# dropbox start -i &

