#!/bin/bash

# Turn on the discrete graphics card.
integratedCard="ARUBA"
discreteCard="TURKS"
xrandr --setprovideroffloadsink "TURKS @ pci:0000:01:00.0"  "ARUBA @ pci:0000:00:01.0"
notify-send -i dialog-information "$discreteCard" "activated"
# Start program (glxinfo) with discrete graphics card by DRI_PRIME=1.
#DRI_PRIME=1 glxinfo | grep "OpenGL renderer"

# Start Genymotion with discret graphics
DRI_PRIME=1 palemoon
# DRI_PRIME=1 /home/alexander/Programs/FirefoxBeta/firefox
