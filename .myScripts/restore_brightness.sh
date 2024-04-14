#!/usr/bin/env bash

current_brightness=$(cat < $HOME/.myScripts/current_brightness.txt) || echo 50
brightnessctl set ${current_brightness}
notify-send -t 500 -i dialog-information "Brightness $current_brightness"
