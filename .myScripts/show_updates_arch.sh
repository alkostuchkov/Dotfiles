#!/usr/bin/env bash

# Shows available updates

updates_community=$(pacman -Qu)
updates_aur=$(paru -Qua)
count_community=$(pacman -Qu | wc -l)
count_aur=$(paru -Qua | wc -l)
notify-send -i software-update-available "Updates:" "\ncommunity: $count_community\n$updates_community\n\nAUR: $count_aur\n$updates_aur"


