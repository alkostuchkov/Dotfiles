#!/usr/bin/env bash

# apt list --upgradable 2> /dev/null | grep -c unstable &
# updates=$(apt list --upgradable 2> /dev/null | grep -c upgradable);
# updates=$(apt list --upgradable 2> /dev/null | grep -c unstable);
updates=$(expr $(apt list --upgradable 2> /dev/null | wc -l) - 1)
# notify-send -t 3000 "Updates $updates"

if [ "$updates" -gt 0 ]; then
    echo " $updates"
else
    echo ""
fi
