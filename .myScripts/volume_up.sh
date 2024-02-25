#!/usr/bin/env bash

# pactl list sinks | grep '^[[:space:]]Volume:' | \
    # head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'

pactl set-sink-volume 0 +5%

current_volume=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

notify-send -t 1000 -i dialog-information "Volume: $current_volume%"

