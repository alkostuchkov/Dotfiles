#!/usr/bin/env bash

# Run ranger as root for Qtile
pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session $TERMINAL -e ranger
# pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session alacritty -e ranger
