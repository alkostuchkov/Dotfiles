#!/usr/bin/env bash

# Run Vifm as root for Qtile
pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session $TERMINAL -e vifmrun
# pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session alacritty -e vifmrun
