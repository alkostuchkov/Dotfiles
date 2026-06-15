#!/usr/bin/env bash

# Run yazi as root for Qtile
# # pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session $TERMINAL -e yazi
# # pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session alacritty -e yazi
# # pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session kitty -e yazi
# pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session ghostty -e "$SHELL -c 'yazi --cwd-file ~/.config/yazi/cwd (cat ~/.config/yazi/cwd)'"
# # pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session alacritty -e $SHELL -c 'yazi --cwd-file ~/.config/yazi/cwd (cat ~/.config/yazi/cwd)'

if [[ -n $WAYLAND_DISPLAY ]]; then
    pkexec env WAYLAND_DISPLAY="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" XDG_RUNTIME_DIR=/run/user/0 dbus-run-session ghostty -e "$SHELL -c 'yazi --cwd-file ~/.config/yazi/cwd (cat ~/.config/yazi/cwd)'"
elif [[ -n $DISPLAY ]]; then
    pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session ghostty -e "$SHELL -c 'yazi --cwd-file ~/.config/yazi/cwd (cat ~/.config/yazi/cwd)'"
else
	echo "Error: No Wayland or X11 display detected" >&2
	exit 1
fi
