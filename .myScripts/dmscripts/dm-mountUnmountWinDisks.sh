#!/usr/bin/env bash

declare options=(
"mount C - $HOME/.myScripts/winC_mount.sh"
"mount D - $HOME/.myScripts/winD_mount.sh"
"unmount C - $HOME/.myScripts/winC_unmount.sh"
"unmount D - $HOME/.myScripts/winD_unmount.sh"
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

DMENU="dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p"

choice=$(printf '%s\n' "${options[@]}" | ${DMENU} 'Windows:')
# choice=$(printf '%s\n' "${options[@]}" | dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p 'Windows:')

if [[ "$choice" == "quit" ]]; then
    echo "Program terminated." && exit 1
elif [[ "$choice" ]]; then
    drive=$(printf '%s\n' "${choice}" | awk '{print $NF}')
    $drive
else
    echo "Program terminated." && exit 1
fi
