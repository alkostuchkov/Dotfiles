#!/bin/bash

idConky=`pidof conky | grep [0-9]`
# if pidof conky | grep [0-9] > /dev/null

# cp ~/.config/xfce4/desktop/icons.screen0-1350x726_backup.rc ~/.config/xfce4/desktop/icons.screen0-1350x726.rc
sleep 60
# cp ~/.config/xfce4/desktop/icons.screen0-1350x726_backup.rc ~/.config/xfce4/desktop/icons.screen0-1350x726.rc
# sleep 2
# xfdesktop --reload

if [ -z ${idConky} ]
then
    {
        # exec conky -c ~/.myScripts/conky/conkyrc2 2>&1 > /dev/null &
        #sleep 3
        exec conky -c ~/.myScripts/conky/conkyrc1 2>&1 > /dev/null &
    }
else
    {
       kill -9 $idConky
       notify-send -i dialog-information "conky with id = $idConky was killed"
       # echo "conky with id = $idConky was killed"
    }
fi

cp ~/.config/xfce4/desktop/icons.screen0-1350x727_backup.rc ~/.config/xfce4/desktop/icons.screen0-1350x727.rc
sleep 2
xfdesktop --reload


# if [ -z ${idConky} ]
# then
#     {
#         # exec conky -c ~/.myScripts/conky/conkyrc2 2>&1 > /dev/null &
#         # #sleep 3
#         # exec conky -c ~/.myScripts/conky/conkyrc1 2>&1 > /dev/null &
        
#        # cp ~/.config/xfce4/desktop/icons.screen0-1350x698.rc ~/.config/xfce4/desktop/icons.screen0-1350x698.rc.bak
#        # sleep 3
#        # rm ~/.config/xfce4/desktop/*.rc
#        # cp ~/.config/xfce4/desktop/icons.screen0-1350x698.rc.bak ~/.config/xfce4/desktop/icons.screen0-1350x698.rc

#        sleep 10
#        conky -c ~/.myScripts/conky/conkyrc2 2>&1 > /dev/null &
#        cp ~/.config/xfce4/desktop/icons.screen0-1350x698.rc ~/.config/xfce4/desktop/icons.screen0-1350x721.rc
#        sleep 10
#        xfdesktop --reload
#        sleep 10
#        conky -c ~/.myScripts/conky/conkyrc1 2>&1 > /dev/null &

#        # xfdesktop --reload
#     }
# else
#     {
#        kill -9 $idConky
#        echo "conky with id = $idConky was killed"
#          # killall conky

#        # cp ~/.config/xfce4/desktop/icons.screen0-1350x698.rc ~/.config/xfce4/desktop/icons.screen0-1350x698.rc.bak
#        # sleep 3
#        # rm ~/.config/xfce4/desktop/*.rc
#        # cp ~/.config/xfce4/desktop/icons.screen0-1350x698.rc.bak ~/.config/xfce4/desktop/icons.screen0-1350x698.rc

#        sleep 10
#        conky -c ~/.myScripts/conky/conkyrc2 2>&1 > /dev/null &
#        cp ~/.config/xfce4/desktop/icons.screen0-1350x698.rc ~/.config/xfce4/desktop/icons.screen0-1350x721.rc
#        sleep 10
#        xfdesktop --reload
#        sleep 10
#        conky -c ~/.myScripts/conky/conkyrc1 2>&1 > /dev/null &

#        # xfdesktop --reload
#     }
# fi

