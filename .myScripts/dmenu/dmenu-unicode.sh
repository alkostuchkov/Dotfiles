#!/usr/bin/env bash

# The famous "get a menu of emojis to copy" script.

# Get user selection via dmenu from emoji file.
# chosen=$(cut -d ';' -f1 ~/.myScripts/dmenu/emoji |dmenu -l 20  -nf '#09dbc9' -nb '#222b2e' -sf '#dbdcd5' -sb '#009185' -fn 'Ubuntu Nerd Font Book-16:normal' -p 'Choose an icon:' | sed "s/ .*//")
chosen=$(cut -d ';' -f1 ~/.myScripts/dmenu/emoji |dmenu -l 20  -nf '#09dbc9' -nb '#222b2e' -sf '#dbdcd5' -sb '#009185' -fn 'Ubuntu Nerd Font-16:normal' -p 'Choose an icon:' | awk '{print $1}')

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