#!/usr/bin/env bash

isActive=$(systemctl --user status syncthing.service |grep Active | awk '{print $2}') 

if [[ ${isActive} == "active" ]]
then
    systemctl --user stop syncthing.service &
    notify-send -i dialog-information "Syncthing service stopped"
else
    systemctl --user start syncthing.service &
    notify-send -i dialog-information "Syncthing service started"
fi

