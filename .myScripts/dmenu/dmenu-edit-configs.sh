#!/usr/bin/env bash
#  ____ _____
# |  _ \_   _|  Derek Taylor (DistroTube)
# | | | || |    http://www.youtube.com/c/DistroTube
# | |_| || |    http://www.gitlab.com/dwt1/
# |____/ |_|
#
# Dmenu script for editing some of my more frequently edited config files.


# declare options=("alacritty
# awesome
# bash
# broot
# bspwm
# doom.d/config.el
# doom.d/init.el
# dunst
# dwm
# emacs.d/init.el
# herbstluftwm
# i3
# neovim
# picom
# polybar
# qtile
# quickmarks
# qutebrowser
# spectrwm
# st
# stumpwm
# surf
# sxhkd
# tabbed
# termite
# vifm
# vim
# vimb
# xmobar
# xmonad
# xresources
# zsh
# quit")

declare options=("autostart_qtile
bash
fish
dunst
dmenu-edit-configs
dmenu-system-exit
i3
picom
conky
compton
polybar
qtile
qutebrowser
rofi
vifm
vim
xresources
xterm
zsh
quit")

choice=$(echo -e "${options[@]}" | dmenu -p 'Edit config file: ' -nb '#222B2E' -nf '#09DBC9' -sb '#009185' -fn 'Ubuntu-R 12')
# choice=$(echo -e "${options[@]}" | dmenu -p 'Edit config file: ' -nb '#222B2E' -nf '#fea63c' -fn 'Ubuntu-R 12')

case $choice in
	quit)
		echo "Program terminated." && exit 1;;
    autostart_qtile)
        choice="$HOME/.config/qtile/scripts/autostart.sh";;
	bash)
		choice="$HOME/.bashrc";;
    fish)
		choice="$HOME/.config/fish/config.fish";;
	dunst)
		choice="$HOME/.config/dunst/dunstrc";;
	dmenu-edit-configs)
		choice="$HOME/.myScripts/dmenu/dmenu-edit-configs.sh";;
	dmenu-system-exit)
		choice="$HOME/.myScripts/dmenu/dmenu-system-exit.sh";;
	i3)
		choice="$HOME/.config/i3/config";;
	picom)
		choice="$HOME/.config/picom/picom.conf";;
	compton)
		choice="$HOME/.config/compton.conf";;
		# choice="$HOME/.config/compton/compton.conf";;
	conky)
		choice="$HOME/.myScripts/conky/conkyrc1";;
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
	*)
		exit 1;;
esac

terminator -e "vim $choice"

# alacritty -e nvim "$choice"
# emacsclient -c -a emacs "$choice"
