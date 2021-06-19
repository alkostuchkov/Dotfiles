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

typeit=0
if [[ $1 == "--type" ]]; then
	typeit=1
	shift
fi

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
password=$(printf '%s\n' "${password_files[@]}" | dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p 'Password for:')

[[ -n $password ]] || exit

if [[ $typeit -eq 0 ]]; then
	# pass show -c "$password" 2>/dev/null
    got_password=$(pass show $password)
    if [[ $? == 1 ]]; then
        notify-send -t 3000 -i dialog-information "$password doesn't exist."
    elif [ $got_password ]; then
        for_notify=$(echo $password | cut -d "/" -f2)
        echo $got_password | xclip -selection clipboard
        notify-send -t 3000 -i dialog-information "Copied $for_notify to clipboard.
        Will clear in 30 seconds."
        sleep 30
        cat /dev/null | xclip -sel clip
        notify-send -t 3000 -i dialog-information "Cleared."
    else
        notify-send -t 3000 -i dialog-information "Bad Passphrase."
    fi
else
	pass show "$password" | { IFS= read -r pass; printf %s "$pass"; } | $xdotool
fi

