#!/bin/bash

# Shows/Hides xfce4 Desktop icons and turns on/off conky at the same time.
# isIconsShown=$(xfconf-query -c xfce4-desktop -l -v | grep '/desktop-icons/style' | awk '{print $2}')
isIconsShown=$(xfconf-query -c xfce4-desktop -l -v | awk '$1 == "/desktop-icons/style" {print $2}')

if [ $isIconsShown -eq 0 ]
then
    # Show Desktop icons.
    xfconf-query -c xfce4-desktop -p '/desktop-icons/style' int -s 2
    ~/.myScripts/on-off_conky.sh
else
    # Hide Desktop icons.
    xfconf-query -c xfce4-desktop -p '/desktop-icons/style' int -s 0
    ~/.myScripts/on-off_conky.sh
fi

# notify-send -i dialog-information "CapsLock turned off."
