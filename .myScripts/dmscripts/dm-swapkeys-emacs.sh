#!/usr/bin/env bash

xmodmap -e 'keycode 37 = Super_L'   &  # Super_L -> Control_L
xmodmap -e 'keycode 133 = Alt_L'    &  # Alt_L -> Super_L
xmodmap -e 'keycode 64 = Control_L' &  # Map the menu button to right super

