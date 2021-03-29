#!/usr/bin/env bash

# Shows available updates

updates=$(apt-show-versions -u -b)
count=$(apt-show-versions -u -b | wc -l)
notify-send -i software-update-available "Updates: $count" "\n$updates"

