#!/bin/bash

cp ~/.config/xfce4/desktop/icons.screen0-1264x983_backup.rc ~/.config/xfce4/desktop/icons.screen0-1264x983.rc
# cp ~/.config/xfce4/desktop/icons.screen0-1264x952.rc ~/.config/xfce4/desktop/icons.screen0-1264x952.rc.bak
# rm ~/.config/xfce4/desktop/*.rc
# cp ~/.config/xfce4/desktop/icons.screen0-1264x976.rc.bak ~/.config/xfce4/desktop/icons.screen0-1264x976.rc
# cp ~/.config/xfce4/desktop/icons.screen0-1264x952.rc.bak ~/.config/xfce4/desktop/icons.screen0-1264x952.rc
sleep 3
xfdesktop --reload
