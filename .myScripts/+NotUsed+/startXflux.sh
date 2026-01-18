#!/bin/bash
# Script to automatically start xflux 
# http://stereopsis.com/flux/

# Place in /home/$USER/.kde4/Autostart to automatically start xflux on user login.

# Usage: /usr/local/bin/xflux [-z zipcode | -l latitude] [-g longitude] [-k colortemp (default 3400)] [-nofork]
# protip: Say where you are (use -z or -l).

isStarted=`ps -U $USER |grep [x]flux` # проверяем запущен ли xflux пользователем $USER
idXflux=${isStarted::5} # присваиваем name первый символ переменной isStarted 

if [ -z ${isStarted::5} ] 
   then /usr/bin/xflux -l 52.4452778 -g 30.9841667
   else 
   {
      kill -9 $idXflux
      /usr/bin/xflux -l 52.4452778 -g 30.9841667
      isStarted=`ps -U $USER |grep [x]flux`
      echo "$USER started xflux with id =${isStarted::5}" 
   }
fi

