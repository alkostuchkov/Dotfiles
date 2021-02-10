#!/bin/bash

# max_brightness=255
# current_brightness=$(cat /sys/class/backlight/radeon_bl0/brightness)
#
# # current_brightness=$(expr $current_brightness + 12)
# current_brightness=$((current_brightness + 5))
#
# if [ $current_brightness -le $max_brightness ]
    # then
        # echo $current_brightness > /sys/class/backlight/radeon_bl0/brightness
        # notify-send -t 500 -i dialog-information "Brightness $current_brightness"
    # else
        # current_brightness=$max_brightness
        # echo $current_brightness > /sys/class/backlight/radeon_bl0/brightness
        # notify-send -t 500 -i dialog-information "Brightness $current_brightness"
# fi

brightnessctl set +5
current_brightness=$(brightnessctl get)
notify-send -t 500 -i dialog-information "Brightness $current_brightness"

