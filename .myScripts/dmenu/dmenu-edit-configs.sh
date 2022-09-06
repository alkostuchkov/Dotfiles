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
"bat - $HOME/.config/bat/config"
"conky - $HOME/.myScripts/conky/conkyrc1"
"conky - $HOME/.myScripts/conky/conkyrc_i3"
"compton - $HOME/.config/compton.conf"
"dmenu-change-alacritty-colors - $HOME/.myScripts/dmenu/dmenu-change-alacritty-colors.sh"
"dmenu-edit-configs - $HOME/.myScripts/dmenu/dmenu-edit-configs.sh"
"dmenu-GoogleDrive - $HOME/.myScripts/dmenu/dmenu-GoogleDrive.sh"
"dmenu-kill - $HOME/.myScripts/dmenu/dmenu-kill.sh"
"dmenu-mountUnmountWinDisks - $HOME/.myScripts/dmenu/dmenu-mountUnmountWinDisks.sh"
"dmenu-passmenu - $HOME/.myScripts/dmenu/dmenu-passmenu.sh"
"dmenu-passmenu-name - $HOME/.myScripts/dmenu/dmenu-passmenu-name.sh"
"dmenu-passmenu-url - $HOME/.myScripts/dmenu/dmenu-passmenu-url.sh"
"dmenu-run-utils - $HOME/.myScripts/dmenu/dmenu-run-utils.sh"
"dmenu-search - $HOME/.myScripts/dmenu/dmenu-search.sh"
"dmenu-system-exit - $HOME/.myScripts/dmenu/dmenu-system-exit.sh"
"dmenu-unicode - $HOME/.myScripts/dmenu/dmenu-unicode.sh"
"fish - $HOME/.config/fish/config.fish"
"fonts.conf - $HOME/.config/fontconfig/fonts.conf"
"homepage - $HOME/.surf/homepage.html"
"i3 - $HOME/.config/i3/config"
"i3blocks - $HOME/.config/i3blocks/config"
"i3status - $HOME/.config/i3status/config"
"i3pystatus - $HOME/.config/i3pystatus/config.py"
"kitty - $HOME/.config/kitty/kitty.conf"
"nvim - $HOME/.config/nvim/init.vim"
"picom - $HOME/.config/picom/picom.conf"
"polybar - $HOME/.config/polybar/config"
"profile - $HOME/.profile"
"qtile - $HOME/.config/qtile/config.py"
"Qtile_My_Keys - $HOME/.config/qtile/Qtile_My_Keys.txt"
"qutebrowser - $HOME/.config/qutebrowser/config.py"
"ranger_rc.conf - $HOME/.config/ranger/rc.conf"
"ranger_rifle.conf - $HOME/.config/ranger/rifle.conf"
"ranger_commands.py - $HOME/.config/ranger/commands.py"
"rofi - $HOME/.config/rofi/config.rasi"
"terminator - $HOME/.config/terminator/config"
"udiskie - $HOME/.config/udiskie/config.yml"
"vifm - $HOME/.config/vifm/vifmrc"
"vim - $HOME/.vimrc"
"xterm - $HOME/.XTerm"
"xresources - $HOME/.Xresources"
"zsh - $HOME/.zshrc"
"quit")

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

terminal="alacritty"
# terminal="xfce4-terminal"

# names=$(printf '%s\n' "${options[@]}" | awk '{print $1}')
# choice=$(printf '%s\n' "${names}" | dmenu -l 10  -nf '#09dbc9' -nb '#222b2e' -sf '#dbdcd5' -sb '#009185' -fn 'Ubuntu-16:normal' -p 'Edit config file:')

choice=$(printf '%s\n' "${options[@]}" | dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p 'Edit config file:')

if [[ "$choice" == "quit" ]]; then
    echo "Program terminated." && exit 1
elif [[ "$choice" ]]; then
    conf=$(printf '%s\n' "${choice}" | awk '{print $NF}')
    gvim $conf  # gvim is either a link to neovim-qt or just gvim
    # $terminal -e $SHELL -c "vim $conf"
    # alacritty -e $SHELL -c "vim $conf"
    # $terminal -e "$SHELL -c 'vim $conf'"
    # alacritty -e vim "$conf"
    # terminator -e "vim $conf"
else
    echo "Program terminated." && exit 1
fi

