#!/usr/bin/env bash

if [[ -n $WAYLAND_DISPLAY ]]; then
	DMENU="dmenu-wl_run"
	xdotool="ydotool type --file -"
elif [[ -n $DISPLAY ]]; then
    DMENU="dmenu_run"
	xdotool="xdotool type --clearmodifiers --file -"
else
	echo "Error: No Wayland or X11 display detected" >&2
	exit 1
fi

# # dmenu_run -i -l 10 -nb '#32343D' -nf '#CFD6DF' -sb '#3D5E87' -sf '#F9F9F9' -p 'Run: ' -fn 'Iosevka-18:normal'
# # dmenu_run -i -l 10 -nb '#32343D' -nf '#CFD6DF' -sb '#3D5E87' -sf '#F9F9F9' -p 'Run: ' -fn 'Ubuntu-17:normal'
# dmenu_run -i -l 10 -nb '#32343D' -nf '#CFD6DF' -sb '#3D5E87' -sf '#F9F9F9' -p 'Run: ' -fn 'JetbrainsMonoNerdFont-16:normal'
${DMENU} -i -l 10 -nb '#32343D' -nf '#CFD6DF' -sb '#3D5E87' -sf '#F9F9F9' -p 'Run: ' -fn 'JetbrainsMonoNerdFont-16:normal'

# # MyBlue
# nf='#CFD6DF'
# nb='#32343D'
# sf='#F9F9F9'
# sb='#3D5E87'
