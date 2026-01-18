#!/bin/bash

isBluemanApplet=$(pgrep blueman-applet)

if [ -z $isBluemanApplet ] 
   then /usr/bin/blueman-applet &
   else kill -9 $isBluemanApplet
fi