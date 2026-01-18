#!/usr/bin/env bash

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

DMENU="dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p"

# Get user selection via dmenu from emoji file.
# chosen=$(cut -d ';' -f1 ~/.myScripts/dmscripts/transcription.txt | dmenu -l 20 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p 'Choose a symbol:' | awk '{print $1}')
chosen=$(cut -d ';' -f1 ~/.myScripts/dmscripts/transcription.txt | ${DMENU} 'Choose a symbol:' | awk '{print $1}')

# Exit if none chosen.
[ -z "$chosen" ] && exit

# If you run this command with an argument, it will automatically insert the
# character. Otherwise, show a message that the emoji has been copied.
if [ -n "$1" ]; then
	xdotool type "$chosen"
else
	printf "$chosen" | xclip -selection clipboard
	notify-send "'$chosen' copied to clipboard." &
fi
