#!/bin/sh

idConky=`pidof conky | grep [0-9]`
# if pidof conky | grep [0-9] > /dev/null
if [ -z ${idConky} ]
then
    {
        cp ~/.config/xfce4/desktop/icons.screen0-1264x955.rc ~/.config/xfce4/desktop/icons.screen0-1264x977.rc
        exec conky -c ~/.myScripts/conky/conkyrc2 2>&1 > /dev/null &
        sleep 3
        exec conky -c ~/.myScripts/conky/conkyrc1 2>&1 > /dev/null &
    }
else
    {
       kill -9 $idConky
       notify-send -i dialog-information "conky with id = $idConky was killed"
       # echo "conky with id = $idConky was killed"
    }
fi
