#!/usr/bin/env bash

syncthing_status=$(systemctl --user status syncthing.service | grep Active | awk '{print $2}') 

if [[ ${syncthing_status} == "active" ]]
then
    # systemctl --user stop syncthing.service &
    # notify-send -i dialog-information "Syncthing service stopped"
    # echo "inactive"

    echo "active"
else
    # systemctl --user start syncthing.service &
    # notify-send -i dialog-information "Syncthing service started"
    # echo "active"

    echo "inactive"
fi


