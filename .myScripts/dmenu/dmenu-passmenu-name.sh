#!/usr/bin/env bash

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

shopt -s nullglob globstar

if [[ -n $WAYLAND_DISPLAY ]]; then
	dmenu=dmenu-wl
	xdotool="ydotool type --file -"
elif [[ -n $DISPLAY ]]; then
	# dmenu=dmenu
	xdotool="xdotool type --clearmodifiers --file -"
else
	echo "Error: No Wayland or X11 display detected" >&2
	exit 1
fi

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

# password=$(printf '%s\n' "${password_files[@]}" | "$dmenu" "$@")
username=$(printf '%s\n' "${password_files[@]}" | dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p 'Username for:')

[[ -n $username ]] || exit

got_username=$(pass show $username | grep "username:" | awk '{print $2}')
if [[ -z $got_username ]]; then
    notify-send -t 5000 -i dialog-information "$username" "doesn't have a 'username:' field."
else
    for_notify=$(echo $username | cut -d "/" -f2)
    echo $got_username | xclip -selection clipboard
    notify-send -t 5000 -i dialog-information "Copied $for_notify to clipboard.
    Will clear in 45 seconds."
    sleep 45
    cat /dev/null | xclip -sel clip
    notify-send -t 5000 -i dialog-information "Cleared."
fi

