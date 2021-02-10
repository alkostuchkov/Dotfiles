#!/bin/bash

#while [ true ]; do
###   isConnect=`wget -O - -q icanhazip.com` #получаем IP
###   if [ -z $isConnect ] #если нет интернета
###      then
###      {
###         killall conky
###         sleep 10
###         conky -c ~/conky/conkyrc1NoCon 2>&1 > /dev/null &
###         sleep 3
###         conky -c ~/conky/conkyrc2NoCon 2>&1 > /dev/null &
###
###         cp ~/.config/xfce4/desktop/icons.screen0-1350x720.rc ~/.config/xfce4/desktop/icons.screen0-1350x720.rc.bak
###         sleep 5
###         rm ~/.config/xfce4/desktop/*.rc
###         cp ~/.config/xfce4/desktop/icons.screen0-1350x720.rc.bak ~/.config/xfce4/desktop/icons.screen0-1350x720.rc
###         xfdesktop --reload
###      }
###      else #если есть интернет
###      {
         killall conky
         sleep 10
         conky -c ~/conky/conkyrc1 2>&1 > /dev/null &
         sleep 3
         conky -c ~/conky/conkyrc2 2>&1 > /dev/null &

         cp ~/.config/xfce4/desktop/icons.screen0-1350x720.rc ~/.config/xfce4/desktop/icons.screen0-1350x720.rc.bak
         sleep 5
         rm ~/.config/xfce4/desktop/*.rc
         cp ~/.config/xfce4/desktop/icons.screen0-1350x720.rc.bak ~/.config/xfce4/desktop/icons.screen0-1350x720.rc
         xfdesktop --reload
###      }
###   fi
###   exit
#   sleep 60
#done
