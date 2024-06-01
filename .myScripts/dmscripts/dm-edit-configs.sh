#!/usr/bin/env bash

# Dmenu script for editing some of my more frequently edited config files.

# declare options=("alacritty
options=(
"alacritty - $HOME/.config/alacritty/alacritty.toml"
"awesome - $HOME/.config/awesome/rc.lua"
"awesome - $HOME/.config/awesome/themes/mymaterial/theme.lua"
"awesome - $HOME/.config/awesome/themes/myeverforest/theme.lua"
"bash - $HOME/.bashrc"
"bat - $HOME/.config/bat/config"
"bspwm - $HOME/.config/bspwm/bspwmrc"
"conky - $HOME/.myScripts/conky/conkyrc"
"conky (bspwm) - $HOME/.myScripts/conky/bspwm_conkyrc"
"compton - $HOME/.config/compton.conf"
"dm-change-alacritty-colors - $HOME/.myScripts/dmscripts/dm-change-alacritty-colors.sh"
"dm-edit-configs - $HOME/.myScripts/dmscripts/dm-edit-configs.sh"
"dm-GoogleDrive - $HOME/.myScripts/dmscripts/dm-GoogleDrive.sh"
"dm-kill - $HOME/.myScripts/dmscripts/dm-kill.sh"
"dm-mountUnmountWinDisks - $HOME/.myScripts/dmscripts/dm-mountUnmountWinDisks.sh"
"dm-passmenu - $HOME/.myScripts/dmscripts/dm-passmenu.sh"
"dm-passmenu-name - $HOME/.myScripts/dmscripts/dm-passmenu-name.sh"
"dm-passmenu-url - $HOME/.myScripts/dmscripts/dm-passmenu-url.sh"
"dm-run-programs - $HOME/.myScripts/dmscripts/dm-run-programs.sh"
"dm-run-scripts - $HOME/.myScripts/dmscripts/dm-run-scripts.sh"
"dm-search - $HOME/.myScripts/dmscripts/dm-search.sh"
"dm-system-exit - $HOME/.myScripts/dmscripts/dm-system-exit.sh"
"dm-unicode - $HOME/.myScripts/dmscripts/dm-unicode.sh"
"dwm - $HOME/Programs/DWM/config.h"
"dwmblocks - $HOME/Programs/DWM/dwmblocks/blocks.h"
"dwmpatches - $HOME/Programs/DWM/patches.h"
"fish - $HOME/.config/fish/config.fish"
"fonts.conf - $HOME/.config/fontconfig/fonts.conf"
"helix - $HOME/.config/helix/config.toml"
"homepage - $HOME/.surf/homepage.html"
"i3 - $HOME/.config/i3/config"
"i3blocks - $HOME/.config/i3blocks/config"
"i3status - $HOME/.config/i3status/config"
"i3pystatus - $HOME/.config/i3pystatus/config.py"
"kitty - $HOME/.config/kitty/kitty.conf"
"nvim - $HOME/.config/nvim/init.vim"
"gvim - $HOME/.config/nvim/ginit.vim"
"picom - $HOME/.config/picom/picom.conf"
"polybar config - $HOME/.config/polybar/config.ini"
"polybar modules - $HOME/.config/polybar/modules.ini"
"polybar colors - $HOME/.config/polybar/colors.ini"
"polybar launch - $HOME/.config/polybar/launch.sh"
"profile - $HOME/.profile"
"qtile - $HOME/.config/qtile/config.py"
"qtile - $HOME/.config/qtile/scripts/autostart.sh"
"qtile - $HOME/.config/qtile/modules/colors.py"
"qtile - $HOME/.local/share/qtile/qtile.log"
"Qtile_My_Keys - $HOME/.config/qtile/Qtile_My_Keys.txt"
"qutebrowser - $HOME/.config/qutebrowser/config.py"
"ranger_rc.conf - $HOME/.config/ranger/rc.conf"
"ranger_rifle.conf - $HOME/.config/ranger/rifle.conf"
"ranger_commands.py - $HOME/.config/ranger/commands.py"
"redshift - $HOME/.config/redshift/redshift.conf"
"rofi - $HOME/.config/rofi/config.rasi"
"sxhkd - $HOME/.config/bspwm/sxhkd/sxhkdrc"
"terminator - $HOME/.config/terminator/config"
"udiskie - $HOME/.config/udiskie/config.yml"
"vifm - $HOME/.config/vifm/vifmrc"
"vim - $HOME/.vimrc"
"xterm - $HOME/.XTerm"
"xresources - $HOME/.Xresources"
"xsession-errors - $HOME/.xsession-errors"
"zsh - $HOME/.zshrc"
"Quit")

# Colors:
# # Materia Manjaro
# nf='#09dbc9'
# nb='#222b2e'
# sf='#dbdcd5'
# sb='#009185'

# Everforest
nf='#d3c6aa'
nb='#2d353b'
sf='#a7c080'
sb='#475258'
fn='Iosevka-18:normal'
# fn='Ubuntu-16:normal'

# Gruvbox
# nf='#fea63c'
# nb='#282828'
# # sf='#dbdcd5'
# sb='#d79921'
# fn='Sarasa Mono SC Nerd-17:normal'

# DMENU="rofi -dmenu -theme-str 'window {width: 80%;}' -p"
DMENU="dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p"
terminal="alacritty"
editor="hx"
# terminal="xfce4-terminal"

# names=$(printf '%s\n' "${options[@]}" | awk '{print $1}')
# choice=$(printf '%s\n' "${names}" | dmenu -l 10  -nf '#09dbc9' -nb '#222b2e' -sf '#dbdcd5' -sb '#009185' -fn 'Ubuntu-16:normal' -p 'Edit config file:')

# choice=$(printf '%s\n' "${options[@]}" | dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p 'Edit config file:')
choice=$(printf '%s\n' "${options[@]}" | ${DMENU} 'Edit config file:')

if [[ "$choice" == "quit" ]]; then
    echo "Program terminated." && exit 1
elif [[ "$choice" ]]; then
    conf=$(printf '%s\n' "${choice}" | awk '{print $NF}')
    gvim $conf  # gvim is either a link to neovim-qt or just gvim
    # # $terminal -e $SHELL -c "vim $conf"
    # # alacritty -e $SHELL -c "vim $conf"
    # # $terminal -e "$SHELL -c 'vim $conf'"
    # $terminal -e $editor $conf
    # # alacritty -e vim "$conf"
    # # terminator -e "vim $conf"
else
    echo "Program terminated." && exit 1
fi

