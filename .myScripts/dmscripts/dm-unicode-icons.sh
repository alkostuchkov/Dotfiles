#!/usr/bin/env bash

# The famous "get a menu of emojis to copy" script.

# Colors:
# Materia Manjaro
nf='#09dbc9'
nb='#222b2e'
sf='#dbdcd5'
sb='#009185'
fn='Iosevka-16:normal'
# fn='Ubuntu-16:normal'
# Gruvbox
# nf='#fea63c'
# nb='#282828'
# # sf='#dbdcd5'
# sb='#d79921'
# fn='Sarasa Mono SC Nerd-17:normal'

DMENU="dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p"

# Get user selection via dmenu from emoji file.
chosen=$(cut -d ';' -f1 ~/.myScripts/dmscripts/emoji | ${DMENU} 'Choose an icon:' | awk '{print $1}')
# chosen=$(cut -d ';' -f1 ~/.myScripts/dmscripts/emoji | dmenu -l 20 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p 'Choose an icon:' | awk '{print $1}')

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
