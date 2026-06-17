#!/usr/bin/env bash

# Dmenu script for running some of my more frequently used utils.

options=(
"Kvantum - kvantummanager"
"Appearance - lxappearance"
"nwg-look - nwg-look"
"Display - lxrandr"
"Sound - pavucontrol"
"Sound - pavucontrol-qt"
"Qt5 - qt5ct"
"Qt6 - qt6ct"
)

# Colors:
# # Materia Manjaro
# nf='#09dbc9'
# nb='#222b2e'
# sf='#dbdcd5'
# sb='#009185'

# # Everforest
# nf='#d3c6aa'
# nb='#2d353b'
# sf='#a7c080'
# sb='#475258'
# fn='Iosevka-18:normal'
# fn='Ubuntu-17:normal'
fn='IosevkaTerm_IlovePlus-17:normal'
# fn='JetbrainsMonoNerdFont-16:normal'

# MyBlue
nf='#CFD6DF'
nb='#32343D'
sf='#F9F9F9'
sb='#3D5E87'

# Gruvbox
# nf='#fea63c'
# nb='#282828'
# # sf='#dbdcd5'
# sb='#d79921'
# fn='Sarasa Mono SC Nerd-17:normal'

if [[ -n $WAYLAND_DISPLAY ]]; then
    # DMENU="wmenu"
    choice=$(printf '%s\n' "${options[@]}" | wmenu -i -l 10 -f 'IosevkaTerm_IlovePlus 17' -p 'Run program:')
	xdotool="ydotool type --file -"
elif [[ -n $DISPLAY ]]; then
    DMENU="dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p"
    choice=$(printf '%s\n' "${options[@]}" | ${DMENU} 'Run program:')
	xdotool="xdotool type --clearmodifiers --file -"
else
	echo "Error: No Wayland or X11 display detected" >&2
	exit 1
fi

if [[ "$choice" == "quit" ]]; then
    echo "Program terminated." && exit 1
elif [[ "$choice" ]]; then
    program=$(printf '%s\n' "${choice}" | awk '{print $NF}')
    $program
else
    echo "Program terminated." && exit 1
fi

