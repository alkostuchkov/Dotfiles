#!/usr/bin/env bash

# Run yazi as root for Qtile
# pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session $TERMINAL -e yazi
# pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session alacritty -e yazi
pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session kitty -e yazi
