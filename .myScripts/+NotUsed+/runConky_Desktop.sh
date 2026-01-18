#!/bin/bash

###isConnect=`wget -O - -q icanhazip.com`
###if [ -z $isConnect ] #если нет интернета
###   then
###   {
      killall conky 2>&1 > /dev/null &
      sleep 15
      # exec conky -c ~/.myScripts/conky/conkyrc2 2>&1 > /dev/null &
      conky -c ~/.myScripts/conky/conkyrc2 2>&1 > /dev/null &
      sleep 7
      conky -c ~/.myScripts/conky/conkyrc1 2>&1 > /dev/null &
      sleep 5

      # cp ~/.config/xfce4/desktop/icons.screen0-1264x976.rc ~/.config/xfce4/desktop/icons.screen0-1264x976.rc.bak
      # cp ~/.config/xfce4/desktop/icons.screen0-1264x952.rc ~/.config/xfce4/desktop/icons.screen0-1264x952.rc.bak
      # cp ~/.config/xfce4/desktop/icons.screen0-1264x950.rc ~/.config/xfce4/desktop/icons.screen0-1264x950.rc.bak
      # sleep 5
      # rm ~/.config/xfce4/desktop/*.rc
      # cp ~/.config/xfce4/desktop/icons.screen0-1264x976.rc.bak ~/.config/xfce4/desktop/icons.screen0-1264x976.rc
      # cp ~/.config/xfce4/desktop/icons.screen0-1264x952.rc.bak ~/.config/xfce4/desktop/icons.screen0-1264x952.rc
      # cp ~/.config/xfce4/desktop/icons.screen0-1264x950.rc ~/.config/xfce4/desktop/icons.screen0-1264x950.rc.bak
      ##sleep 20
      xfdesktop --reload
###   }
###   else #если есть интернет
###   {
###      killall conky
###      sleep 15
###      conky -c ~/conky/conkyrc2NoCon 2>&1 > /dev/null &
###      sleep 3
###      conky -c ~/conky/conkyrc1NoCon 2>&1 > /dev/null &
###
###      cp ~/.config/xfce4/desktop/icons.screen0-1264x976.rc ~/.config/xfce4/desktop/icons.screen0-1264x976.rc.bak
###      cp ~/.config/xfce4/desktop/icons.screen0-1264x952.rc ~/.config/xfce4/desktop/icons.screen0-1264x952.rc.bak
###      cp ~/.config/xfce4/desktop/icons.screen0-1264x950.rc ~/.config/xfce4/desktop/icons.screen0-1264x950.rc.bak
###      sleep 5
###      rm ~/.config/xfce4/desktop/*.rc
###      cp ~/.config/xfce4/desktop/icons.screen0-1264x976.rc.bak ~/.config/xfce4/desktop/icons.screen0-1264x976.rc
###      cp ~/.config/xfce4/desktop/icons.screen0-1264x952.rc.bak ~/.config/xfce4/desktop/icons.screen0-1264x952.rc
###      cp ~/.config/xfce4/desktop/icons.screen0-1264x950.rc.bak ~/.config/xfce4/desktop/icons.screen0-1264x950.rc
###      ##sleep 20
###      xfdesktop --reload
###   }
###fi
#echo $isConnect
###exit
