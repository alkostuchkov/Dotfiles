#!/usr/bin/env bash

# Run Vifm as root for Qtile
# pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session $TERMINAL -e vifmrun
# # pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session alacritty -e vifmrun

if [[ -n $WAYLAND_DISPLAY ]]; then
    pkexec env WAYLAND_DISPLAY="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" XDG_RUNTIME_DIR=/run/user/0 dbus-run-session $TERMINAL -e vifmrun
elif [[ -n $DISPLAY ]]; then
    pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session $TERMINAL -e vifmrun
else
	echo "Error: No Wayland or X11 display detected" >&2
	exit 1
fi
