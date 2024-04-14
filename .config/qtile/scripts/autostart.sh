#!/usr/bin/env bash 

# picom --experimental-backends &
# compton --config $HOME/.config/compton/compton.conf &
# compton --config $HOME/.config/compton.conf &
# diodon &
# /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
/usr/bin/kbdd &
setxkbmap -layout us,ru -option grp:caps_toggle &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &  # for Arch
# /usr/libexec/polkit-gnome-authentication-agent-1 &  # for Void
/usr/libexec/xfce-polkit &  # for Void
xrdb $HOME/.Xresources &
nitrogen --restore &
volumeicon &
nm-applet &
xfce4-power-manager &
clipit &
# diodon &
# xfce4-clipman &
picom -b --config $HOME/.config/picom/picom.conf &
conky -c ~/.myScripts/conky/conkyrc &
udiskie &  # ~/.config/udiskie/config.yml
xiccd &
python /usr/bin/redshift-gtk &
$HOME/Programs/AppImageApplications/BreakTimer.AppImage &
$HOME/Programs/CheckInternetConnection/CheckInternetConnection &
birdtray &
xmodmap -e 'keycode 135 = Super_R' &  # Map the menu button to right super
# sh -c "GDK_BACKEND=x11 pamac-tray" &
# ~/Programs/MEGAsync/megasync &
# megasync &
# dropbox start -i &

