#!/usr/bin/env bash

# Dmenu script for choice a book I wanna read right now.

options=(
"$HOME/Documents/Books/"
"$HOME/Documents/Books/Rodnaja_mova/Knihi/"
"$HOME/Documents/Books/Rodnaja_mova/Padručniki/"
"$HOME/Documents/Books/Rodnaja_mova/Słoŭniki/"
"$HOME/Documents/Books/Programming/Algorithms/"
"$HOME/Documents/Books/Programming/Android/"
"$HOME/Documents/Books/Programming/ASM/"
"$HOME/Documents/Books/Programming/C/"
"$HOME/Documents/Books/Programming/C++/"
"$HOME/Documents/Books/Programming/DB/"
"$HOME/Documents/Books/Programming/Electronic/"
"$HOME/Documents/Books/Programming/Encryption/"
"$HOME/Documents/Books/Programming/Git/"
"$HOME/Documents/Books/Programming/Go/"
"$HOME/Documents/Books/Programming/Haskell/"
"$HOME/Documents/Books/Programming/IT_ebooks/"
"$HOME/Documents/Books/Programming/Java/"
"$HOME/Documents/Books/Programming/LISP/EmacsLISP/"
"$HOME/Documents/Books/Programming/LISP/CommonLISP/"
"$HOME/Documents/Books/Programming/Lua/"
"$HOME/Documents/Books/Programming/Markdown/"
"$HOME/Documents/Books/Programming/Math/"
"$HOME/Documents/Books/Programming/Memorization/"
"$HOME/Documents/Books/Programming/Networks/"
"$HOME/Documents/Books/Programming/OAuth/"
"$HOME/Documents/Books/Programming/Other/"
"$HOME/Documents/Books/Programming/Pascal_Delphi_Lazarus/"
"$HOME/Documents/Books/Programming/Python/"
"$HOME/Documents/Books/Programming/Rust/"
"$HOME/Documents/Books/Programming/Shell/"
"$HOME/Documents/Books/Programming/StackOverflow_Learning_Books/"
"$HOME/Documents/Books/Programming/Tmux_terminal/"
"$HOME/Documents/Books/Programming/Vim/"
"$HOME/Documents/Books/Programming/Web/"
)

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

# # dmenu colors
# # DMENU="rofi -dmenu -theme-str 'window {width: 80%;}' -p"
# DMENU="dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p"
if [[ -n $WAYLAND_DISPLAY ]]; then
	xdotool="ydotool type --file -"
elif [[ -n $DISPLAY ]]; then
    DMENU="dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p"
	xdotool="xdotool type --clearmodifiers --file -"
else
	echo "Error: No Wayland or X11 display detected" >&2
	exit 1
fi

get_dirpath() {
    # Get dirpath.
    if [[ -n $WAYLAND_DISPLAY ]]; then
        # DMENU="wmenu"
        dirpath=$(printf '%s\n' "${options[@]}" | wmenu -i -l 10 -f 'IosevkaTerm_IlovePlus 17' -p 'Choose path:')
    elif [[ -n $DISPLAY ]]; then
        dirpath=$(printf '%s\n' "${options[@]}" | ${DMENU} 'Choose path:')
    else
        echo "Error: No Wayland or X11 display detected" >&2
        exit 1
    fi

    # # Get dirpath.
    # dirpath=$(printf '%s\n' "${options[@]}" | ${DMENU} 'Choose path:')
    # # dirpath=$(echo "$dirpath" | awk -F: '{print $NF}')
    # # dirpath=$(printf '%s\n' "${options[@]}" | awk -F: '{print $NF}' | ${DMENU} 'Choose path:')
    check_input "$dirpath"
}

get_bookname() {
    # Get bookname of chosen book.
    if [[ -n $WAYLAND_DISPLAY ]]; then
        # DMENU="wmenu"
        bookname=$(ls "$dirpath" | wmenu -i -l 10 -f 'IosevkaTerm_IlovePlus 17' -p 'Choose book:')
    elif [[ -n $DISPLAY ]]; then
        bookname=$(ls "$dirpath" | ${DMENU} 'Choose book:')
    else
        echo "Error: No Wayland or X11 display detected" >&2
        exit 1
    fi

    # # Get bookname of chosen book.
    # bookname=$(ls "$dirpath" | ${DMENU} 'Choose book:')
    check_input "$bookname"

    # while [[ -d "$dirpath$bookname" ]]; do
    until [[ -f "$dirpath$bookname" ]]; do
        dirpath=$dirpath$bookname/
        get_bookname "$dirpath"
    done
}

get_extention() {
    # Get extention of chosen book.
    ext=${bookname##*.}
}

open_book() {
    # Open chosen book in the sertain app depending of the extention.
    case $ext in
        pdf|djvu) zathura "$dirpath$bookname" || qpdfview "$dirpath$bookname";;
        fb2|epub) foliate "$dirpath$bookname" || FBReader "$dirpath$bookname";;
        *) notify-send -t 5000 -i dialog-information "Unknown book extention: $ext";;
    esac
}

check_input() {
    # Exit program if chosen "Quit".
    if [[ "$1" == "" && -n $DISPLAY ]]; then
        notify-send -t 3000 -i dialog-information "Program terminated"
        exit 1
    elif [[ "$1" == "" && -n $WAYLAND_DISPLAY ]]; then
        notify-send -t 3000 -i dialog-information "Program terminated"
        exit 1
    fi

    # if [[ "$1" == "" ]]; then
    #     notify-send -t 3000 -i dialog-information "Program terminated" && exit 1
    # fi
}

get_dirpath
get_bookname
get_extention
open_book

