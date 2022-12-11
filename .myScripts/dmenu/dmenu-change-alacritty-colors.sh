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

is_color_exists() {
    for c in "${color_files[@]}"
    do
        if [[ "$1" == "${c}" ]]
        then
            echo "true"
            return
        fi
    done
    echo "false"
}

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

is_color_exists=0
config_file=${CONFIG_STORE_DIR-~/.config/alacritty/alacritty.yml}
prefix=${COLORS_STORE_DIR-~/.config/alacritty/colors}
color_files=("$prefix"/*.yml)
color_files=("${color_files[@]#"$prefix"/}")
color_files=("${color_files[@]%.yml}")

color=$(printf '%s\n' "${color_files[@]}" | dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p 'Alacritty colors you want:')

[[ -n ${color} ]] || exit

is_color=$(is_color_exists ${color})

if [[ ${is_color} == "true" ]]
then
    old_line=$(grep "\- ~/.config/alacritty/colors/" ${config_file})
    new_line="  - ~/.config/alacritty/colors/"${color}".yml"
    sed -i "s|${old_line}|${new_line}|" ${config_file}
    notify-send -t 5000 -i dialog-information "Colors" "changed to ${color}"
else
    notify-send -t 5000 -i dialog-information "Colors" "${color} doesn't exist."
fi

