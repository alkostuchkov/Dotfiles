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
# fn='Iosevka-18:normal'
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

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

if [[ -n $WAYLAND_DISPLAY ]]; then
    # DMENU="wmenu"
    url=$(printf '%s\n' "${password_files[@]}" | wmenu -i -l 10 -f 'IosevkaTerm_IlovePlus 17' -p 'URL for:')
	xdotool="ydotool type --file -"
elif [[ -n $DISPLAY ]]; then
    DMENU="dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p"
    url=$(printf '%s\n' "${password_files[@]}" | ${DMENU} 'URL for:')
	xdotool="xdotool type --clearmodifiers --file -"
else
	echo "Error: No Wayland or X11 display detected" >&2
	exit 1
fi

[[ -n $url ]] || exit

got_url=$(pass show $url | grep "url:" | awk '{print $2}')
if [[ -z $got_url ]]; then
    notify-send -t 5000 -i dialog-information "$url" "doesn't have a 'url:' field."
else
    for_notify=$(echo $url | cut -d "/" -f2)
    echo $got_url | xclip -selection clipboard
    echo $got_username | wl-copy # Wayland
    notify-send -t 5000 -i dialog-information "Copied $for_notify to clipboard.
    Will clear in 45 seconds."
    sleep 45
    cat /dev/null | xclip -sel clip
    wl-copy -c # Wayland
    notify-send -t 5000 -i dialog-information "Cleared."
fi

