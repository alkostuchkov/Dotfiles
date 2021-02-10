#!/bin/bash

cp ~/.config/xfce4/desktop/icons.screen0-1350x727_backup.rc ~/.config/xfce4/desktop/icons.screen0-1350x727.rc
sleep 2
xfdesktop --reload &
