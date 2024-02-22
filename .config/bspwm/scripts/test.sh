#!/usr/bin/env bash

if [[ -z "$(bspc query -N -n focused.floating)" ]]; then
    notify-send -t 5000 "Floating"
    bspc node focused -t floating
    bspc config -n focused border_width 1
else
    notify-send -t 5000 "Tiled"
    bspc node focused -t tiled
    bspc config -n focused border_width 3
fi
