#!/usr/bin/env bash

DMENU="dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p"

declare options=(
"2017aaa - $HOME/.myScripts/mountUnmountGoogleDrive_2017aaa.sh"
"alkos - $HOME/.myScripts/mountUnmountGoogleDrive_alkos.sh"
"auto - $HOME/.myScripts/mountUnmountGoogleDrive_auto.sh"
"quit")

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
# fn='Iosevka-17:normal'
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

choice=$(printf '%s\n' "${options[@]}" | dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p 'Mount/Unmount:')
# choice=$(printf '%s\n' "${options[@]}" | ${DMENU} 'Mount/Unmount:')

if [[ "$choice" == "quit" ]]; then
    echo "Program terminated." && exit 1
elif [[ "$choice" ]]; then
    drive=$(printf '%s\n' "${choice}" | awk '{print $NF}')
    # $drive
    terminator -e "$drive"
else
    echo "Program terminated." && exit 1
fi
