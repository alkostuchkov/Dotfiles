#!/usr/bin/env bash

# Dmenu script for running some of my more frequently used utils.

options=(
"Kvantum - kvantummanager"
"Appearance - lxappearance"
"Display - lxrandr"
"Sound - pavucontrol"
"Qt5 - qt5ct"
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

# choice=$(printf '%s\n' "${options[@]}" | dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p 'Run program:')
choice=$(printf '%s\n' "${options[@]}" | ${DMENU} 'Run program:')

if [[ "$choice" == "quit" ]]; then
    echo "Program terminated." && exit 1
elif [[ "$choice" ]]; then
    program=$(printf '%s\n' "${choice}" | awk '{print $NF}')
    $program
else
    echo "Program terminated." && exit 1
fi

