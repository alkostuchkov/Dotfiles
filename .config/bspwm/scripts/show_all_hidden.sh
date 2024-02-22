#!/usr/bin/env bash

# BSPWM

# Show all hidden local nodes
for i in $(bspc query -N -n .local.hidden)
do
  bspc node $i -g hidden=off
done


# if [[ -n "$(bspc query -N -n .local.hidden)" ]]; then
  # flag=off
# else
  # flag=on
# fi
#
# &&
#
# for i in $(bspc query -N)
# do
  # bspc node $i -g hidden=$flag
# done
