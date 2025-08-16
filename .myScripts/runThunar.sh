#!/usr/bin/env bash

# Run Thunar as user for Qtile
env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-run-session thunar
