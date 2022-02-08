#!/usr/bin/bash

# Shows amount of available updates for Arch Linux.
community=$(checkupdates | wc -l)
aur=$(yay -Qu | wc -l)
echo `expr $community + $aur`
