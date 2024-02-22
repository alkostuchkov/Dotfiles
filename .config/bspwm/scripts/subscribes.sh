#!/usr/bin/env bash

# BSPWM

# Set border_width to 1 for floating nodes and 3 to others
bspc subscribe node_state | while read line
do
  is_floating=$(echo "$line" | awk '{print $5, $6}')

  if [[ "$is_floating" == "floating on" ]]; then
    bspc config -n focused border_width 1
  else
    bspc config -n focused border_width 3
  fi
done

