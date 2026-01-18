#!/bin/bash

###isConnect=`wget -O - -q icanhazip.com`
###if [ -z $isConnect ] #если нет интернета
###   then
###   {
      killall conky
      ##### cp ~/.config/xfce4/desktop/icons.screen0-1264x955.rc ~/.config/xfce4/desktop/icons.screen0-1264x977.rc
      sleep 15
      exec conky -c ~/.myScripts/conky/conkyrc2 2>&1 > /dev/null &
      sleep 7
      # exec conky -c ~/.myScripts/conky/conkyrc1 2>&1 > /dev/null &

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
      sleep 3
      exec conky -c ~/.myScripts/conky/conkyrc1 2>&1 > /dev/null &
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
