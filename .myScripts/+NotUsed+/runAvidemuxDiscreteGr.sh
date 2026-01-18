#!/bin/bash

# Turn on the discrete graphics card.
integratedCard="ARUBA"
discreteCard="TURKS"

aruba_hex=$(xrandr --listproviders | grep "Provider 0" | cut -d":" -f3 | awk {'print $1'})
turks_hex=$(xrandr --listproviders | grep "Provider 1" | cut -d":" -f3 | awk {'print $1'})

# xrandr --setprovideroffloadsink "TURKS @ pci:0000:01:00.0"  "ARUBA @ pci:0000:00:01.0"
xrandr --setprovideroffloadsink $turks_hex $aruba_hex
notify-send -i dialog-information "$discreteCard : $turks_hex" "activated"

# Start Genymotion with discret graphics
# DRI_PRIME=1 gimp
DRI_PRIME=1 "/home/alexander/Programs/AppImageApplications/Avidemux.AppImage"

