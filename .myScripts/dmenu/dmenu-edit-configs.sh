#!/usr/bin/env bash
#  ____ _____
# |  _ \_   _|  Derek Taylor (DistroTube)
# | | | || |    http://www.youtube.com/c/DistroTube
# | |_| || |    http://www.gitlab.com/dwt1/
# |____/ |_|
#
# Dmenu script for editing some of my more frequently edited config files.

declare options=("alacritty
autostart_qtile
bash
conky
compton
dmenu-edit-configs
dmenu-system-exit
fish
i3
kitty
picom
polybar
qtile
qutebrowser
rofi
vifm
vim
xterm
xresources
zsh
quit")

# choice=$(echo -e "${options[@]}" | dmenu -p 'Edit config file: ' -nb '#222B2E' -nf '#09DBC9' -sb '#009185' -fn 'Sarasa Mono SC Nerd-17:normal')
# choice=$(echo -e "${options[@]}" | dmenu -p 'Edit config file: ' -nb '#222B2E' -nf '#09DBC9' -sb '#009185' -fn 'Ubuntu-18:normal')  # Materia Manjaro
choice=$(echo -e "${options[@]}" | dmenu -p 'Edit config file: ' -nb '#282828' -nf '#fea63c' -sb '#d79921' -fn 'Ubuntu-18:normal')  # Gruvbox

case $choice in
    alacritty)
		choice="$HOME/.config/alacritty/alacritty.yml";;
    autostart_qtile)
        choice="$HOME/.config/qtile/scripts/autostart.sh";;
	bash)
		choice="$HOME/.bashrc";;
	conky)
		choice="$HOME/.myScripts/conky/conkyrc1";;
	compton)
		choice="$HOME/.config/compton.conf";;
		# choice="$HOME/.config/compton/compton.conf";;
	dmenu-edit-configs)
		choice="$HOME/.myScripts/dmenu/dmenu-edit-configs.sh";;
	dmenu-system-exit)
		choice="$HOME/.myScripts/dmenu/dmenu-system-exit.sh";;
    fish)
		choice="$HOME/.config/fish/config.fish";;
	i3)
		choice="$HOME/.config/i3/config";;
	kitty)
		choice="$HOME/.config/kitty/kitty.conf";;
	picom)
		choice="$HOME/.config/picom/picom.conf";;
	polybar)
		choice="$HOME/.config/polybar/config";;
	qtile)
		choice="$HOME/.config/qtile/config.py";;
	qutebrowser)
		choice="$HOME/.config/qutebrowser/config.py";;
	rofi)
		choice="$HOME/.config/rofi/config";;
	vifm)
		choice="$HOME/.config/vifm/vifmrc";;
	vim)
		choice="$HOME/.vimrc";;
	xresources)
		choice="$HOME/.Xresources";;
	xterm)
		choice="$HOME/XTerm";;
	zsh)
		choice="$HOME/.zshrc";;
	quit)
		echo "Program terminated." && exit 1;;
	*)
		exit 1;;
esac

alacritty -e vim "$choice"
# terminator -e "vim $choice"

# alacritty -e nvim "$choice"
# emacsclient -c -a emacs "$choice"
