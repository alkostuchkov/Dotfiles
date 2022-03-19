#!/usr/bin/env bash

# Run Thunar as root for Qtile
pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session thunar
