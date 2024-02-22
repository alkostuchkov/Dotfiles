#!/usr/bin/env bash

# Colors:
# Materia Manjaro
nf='#09dbc9'
nb='#222b2e'
sf='#dbdcd5'
sb='#009185'
fn='Iosevka-17:normal'
# fn='Ubuntu-16:normal'
# Gruvbox
# nf='#fea63c'
# nb='#282828'
# # sf='#dbdcd5'
# sb='#d79921'
# fn='Sarasa Mono SC Nerd-17:normal'


# shopt -s nullglob globstar

if [[ -n "$WAYLAND_DISPLAY" ]]; then
	DMENU=dmenu-wl
	xdotool="ydotool type --file -"
elif [[ -n "$DISPLAY" ]]; then
  DMENU="dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p"
	xdotool="xdotool type --clearmodifiers --file -"
else
	echo "Error: No Wayland or X11 display detected" >&2
	exit 1
fi

prefix=${SCRIPTS_STORE_DIR-~/.myScripts/dmscripts}
script_files=( "$prefix"/*.sh )
script_files=( "${script_files[@]#"$prefix"/}" )
# script_files=( "${script_files[@]%.sh}" )

# password=$(printf '%s\n' "${password_files[@]}" | "$dmenu" "$@")
script_name=$(printf '%s\n' "${script_files[@]}" | ${DMENU} 'Run script:')
# script_name=$(printf '%s\n' "${script_files[@]}" | "$dmenu" -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p 'Run script:')

[[ -n "$script_name" ]] || exit

# Run chosen script
$prefix/$script_name


