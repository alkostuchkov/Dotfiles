#!/usr/bin/env bash

DMENU="dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p"

declare options=(
"2017aaa - $HOME/.myScripts/mountUnmountGoogleDrive_2017aaa.sh"
"alkos - $HOME/.myScripts/mountUnmountGoogleDrive_alkos.sh"
"auto - $HOME/.myScripts/mountUnmountGoogleDrive_auto.sh"
"quit")

# Colors:
# Materia Manjaro
nf='#09dbc9'
nb='#222b2e'
sf='#dbdcd5'
sb='#009185'
fn='Ubuntu-16:normal'
# Gruvbox
# nf='#fea63c'
# nb='#282828'
# # sf='#dbdcd5'
# sb='#d79921'
# fn='Sarasa Mono SC Nerd-17:normal'

# choice=$(printf '%s\n' "${options[@]}" | dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p 'Mount/Unmount:')
choice=$(printf '%s\n' "${options[@]}" | ${DMENU} 'Mount/Unmount:')

if [[ "$choice" == "quit" ]]; then
    echo "Program terminated." && exit 1
elif [[ "$choice" ]]; then
    drive=$(printf '%s\n' "${choice}" | awk '{print $NF}')
    # $drive
    terminator -e "$drive"
else
    echo "Program terminated." && exit 1
fi
