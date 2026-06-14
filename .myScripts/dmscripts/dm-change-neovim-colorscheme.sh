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
prefix=${COLORS_STORE_DIR-~/.config/nvim/lua/alex/plugins}

old_colorscheme_filename=("$prefix"/colorscheme-*.lua)
color_files=("$prefix"/colorscheme-*.lua+)
color_files=("${color_files[@]#"$prefix"/}")

if [[ -n $WAYLAND_DISPLAY ]]; then
    # DMENU="wmenu"
    color=$(printf '%s\n' "${color_files[@]}" | wmenu -i -l 10 -f 'IosevkaTerm_IlovePlus 17' -p 'Neovim colors you want:')
	xdotool="ydotool type --file -"
elif [[ -n $DISPLAY ]]; then
    DMENU="dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p"
    color=$(printf '%s\n' "${color_files[@]}" | ${DMENU} 'Neovim colors you want:')
	xdotool="xdotool type --clearmodifiers --file -"
else
	echo "Error: No Wayland or X11 display detected" >&2
	exit 1
fi

new_colorscheme_filename_withplus="${prefix}/${color}"
new_colorscheme_filename="${new_colorscheme_filename_withplus%.*}.lua"

[[ -n ${color} ]] || exit

is_color=$(is_color_exists ${color})

if [[ ${is_color} == "true" ]]
then
    mv ${old_colorscheme_filename} ${old_colorscheme_filename}+
    mv ${new_colorscheme_filename_withplus} ${new_colorscheme_filename}
    notify-send -t 5000 -i dialog-information "Colors" "changed to ${color}"
else
    notify-send -t 5000 -i dialog-information "Colors" "${color} doesn't exist."
fi

