#!/usr/bin/env bash

# Run Thunar as root for Qtile
# pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session thunar

if [[ -n $WAYLAND_DISPLAY ]]; then
    pkexec env WAYLAND_DISPLAY="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" XDG_RUNTIME_DIR=/run/user/0 dbus-run-session thunar
elif [[ -n $DISPLAY ]]; then
    pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session thunar
else
	echo "Error: No Wayland or X11 display detected" >&2
	exit 1
fi
