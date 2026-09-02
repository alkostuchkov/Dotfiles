#!/usr/bin/env bash

max_brightness=255
current_brightness=$(cat /sys/class/backlight/radeon_bl0/brightness)

# current_brightness=$(expr $current_brightness + 12)
current_brightness=$((current_brightness + 5))
current_percents=$(((current_brightness * 100) / 255))

if [ $current_brightness -le $max_brightness ]
    then
        echo $current_brightness > /sys/class/backlight/radeon_bl0/brightness
        echo ${current_brightness} > $HOME/.myScripts/current_brightness.txt
        # notify-send -t 1000 -i dialog-information -a "" "Brightness: $current_brightness"

        noctalia msg brightness-osd $current_percents
    else
        current_brightness=$max_brightness
        echo $current_brightness > /sys/class/backlight/radeon_bl0/brightness
        echo ${current_brightness} > $HOME/.myScripts/current_brightness.txt
        # notify-send -t 1000 -i dialog-information -a "" "Brightness: $current_brightness"

        noctalia msg brightness-osd $current_percents
fi

# brightnessctl set +5
# current_brightness=$(brightnessctl get)
# notify-send -t 500 -i dialog-information "Brightness $current_brightness"
# echo ${current_brightness} > $HOME/.myScripts/current_brightness.txt

