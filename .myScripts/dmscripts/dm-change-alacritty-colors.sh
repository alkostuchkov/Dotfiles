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


is_color_exists=0
config_file=${CONFIG_STORE_DIR-~/.config/alacritty/alacritty.toml}
prefix=${COLORS_STORE_DIR-~/.config/alacritty/colors}
color_files=("$prefix"/*.toml)
color_files=("${color_files[@]#"$prefix"/}")
color_files=("${color_files[@]%.toml}")

if [[ -n $WAYLAND_DISPLAY ]]; then
    # DMENU="wmenu"
    color=$(printf '%s\n' "${color_files[@]}" | wmenu -i -l 10 -f 'IosevkaTerm_IlovePlus 17' -p 'Alacritty colors you want:')
	xdotool="ydotool type --file -"
elif [[ -n $DISPLAY ]]; then
    DMENU="dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p"
    color=$(printf '%s\n' "${color_files[@]}" | ${DMENU} 'Alacritty colors you want:')
    # DMENU="dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p"
	xdotool="xdotool type --clearmodifiers --file -"
else
	echo "Error: No Wayland or X11 display detected" >&2
	exit 1
fi

[[ -n ${color} ]] || exit

is_color=$(is_color_exists ${color})

if [[ ${is_color} == "true" ]]
then
# import = ["/home/alexander/.config/alacritty/colors/Ayu-Mirage-Dark.toml"]
    # old_line=$(grep "\- ~/.config/alacritty/colors/" ${config_file})
    # new_line="  - ~/.config/alacritty/colors/"${color}".toml"
    old_line=$(grep "import" ${config_file} | awk -F/ '{print $NF}' | cut -d'"' -f1)
    new_line="${color}.toml"
    sed -i "s|${old_line}|${new_line}|" ${config_file}
    notify-send -t 5000 -i dialog-information "Colors" "changed to ${color}"
else
    notify-send -t 5000 -i dialog-information "Colors" "${color} doesn't exist."
fi

