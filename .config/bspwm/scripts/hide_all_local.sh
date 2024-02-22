#!/usr/bin/env bash

# BSPWM

# Hide all local nodes
for i in $(bspc query -N -n .local)
do
  bspc node $i -g hidden=on
done
