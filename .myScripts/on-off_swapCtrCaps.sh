#!/bin/bash

# on/off toggle swapping between Ctrl <-> Caps
isCtrlCapsLockSwitched=`setxkbmap -query | grep ctrl:nocaps`
if [ -z ${isCtrlCapsLockSwitched} ] # default
    then
	{
	    setxkbmap -option ctrl:nocaps  
      notify-send -i dialog-information "CapsLock turned off."
	}
    else  # switched
  {
	    setxkbmap -option &&
	    setxkbmap -layout us,ru -option grp:menu_toggle,grp_led:scroll,grp:win_space_toggle
      notify-send -i dialog-information "CapsLock turned on." 
  }
fi