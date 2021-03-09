#!/usr/bin/env bash
#  ____ _____
# |  _ \_   _|  Derek Taylor (DistroTube)
# | | | || |    http://www.youtube.com/c/DistroTube
# | |_| || |    http://www.gitlab.com/dwt1/
# |____/ |_|
#
# Dmenu script for editing some of my more frequently edited config files.

# declare options=("alacritty
options=(
"alacritty - $HOME/.config/alacritty/alacritty.yml"
"autostart_qtile - $HOME/.config/qtile/scripts/autostart.sh"
"bash - $HOME/.bashrc"
"conky - $HOME/.myScripts/conky/conkyrc1"
"compton - $HOME/.config/compton.conf"
"dmenu-edit-configs - $HOME/.myScripts/dmenu/dmenu-edit-configs.sh"
"dmenu-passmenu - $HOME/.myScripts/dmenu/dmenu-passmenu.sh"
"dmenu-system-exit - $HOME/.myScripts/dmenu/dmenu-system-exit.sh"
"fish - $HOME/.config/fish/config.fish"
"homepage - $HOME/.surf/homepage.html"
"i3 - $HOME/.config/i3/config"
"kitty - $HOME/.config/kitty/kitty.conf"
"picom - $HOME/.config/picom/picom.conf"
"polybar - $HOME/.config/polybar/config"
"qtile - $HOME/.config/qtile/config.py"
"qutebrowser - $HOME/.config/qutebrowser/config.py"
"rofi - $HOME/.config/rofi/config"
"udiskie - $HOME/.config/udiskie/config.yml"
"vifm - $HOME/.config/vifm/vifmrc"
"vim - $HOME/.vimrc"
"xterm - $HOME/XTerm"
"xresources - $HOME/.Xresources"
"zsh - $HOME/.zshrc"
"quit")

# names=$(printf '%s\n' "${options[@]}" | awk '{print $1}')
# choice=$(printf '%s\n' "${names}" | dmenu -l 10  -nf '#09dbc9' -nb '#222b2e' -sf '#dbdcd5' -sb '#009185' -fn 'Ubuntu-16:normal' -p 'Edit config file:')

choice=$(printf '%s\n' "${options[@]}" | dmenu -l 10  -nf '#09dbc9' -nb '#222b2e' -sf '#dbdcd5' -sb '#009185' -fn 'Ubuntu-16:normal' -p 'Edit config file:')

if [[ "$choice" == "quit" ]]; then
    echo "Program terminated." && exit 1
elif [[ "$choice" ]]; then
    conf=$(printf '%s\n' "${choice}" | awk '{print $NF}')
    alacritty -e vim "$conf"
    # terminator -e "vim $choice"
else
    echo "Program terminated." && exit 1
fi

# Colors
# choice=$(echo -e "${options[@]}" | dmenu -p 'Edit config file: ' -nb '#282828' -nf '#fea63c' -sb '#d79921' -fn 'Ubuntu-18:normal')  # Gruvbox
# choice=$(echo -e "${options[@]}" | dmenu -p 'Edit config file: ' -nb '#222B2E' -nf '#09DBC9' -sb '#009185' -fn 'Sarasa Mono SC Nerd-17:normal')
# choice=$(echo -e "${options[@]}" | dmenu -p 'Edit config file: ' -nb '#222B2E' -nf '#09DBC9' -sb '#009185' -fn 'Ubuntu-18:normal')  # Materia Manjaro

