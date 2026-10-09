#!/usr/bin/env bash

if [[ -n $WAYLAND_DISPLAY ]]; then
    # Wayland
    conky -c ~/.myScripts/conky/conkyrc_wayland
elif [[ -n $DISPLAY ]]; then
    # X11
    conky -c ~/.myScripts/conky/conkyrc_x11
else
    echo "ERROR"
    exit 1
fi
