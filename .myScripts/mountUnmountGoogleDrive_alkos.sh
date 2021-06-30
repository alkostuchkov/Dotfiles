#!/usr/bin/env bash

gdrive_name="GoogleDrive_alkos"
gdrive_path="$HOME/GoogleDrive_alkos/"
gdrive_statusfile_path="$HOME/.myScripts/GoogleDriveStatus_alkos.txt"
is_mounted=$(mount | grep "$gdrive_name")

if [[ "$is_mounted" ]]; then  # if mounted
    notify-send -i dialog-information -t 3000 "$gdrive_name" "is already mounted. Try to unmount"
    fusermount -u "$gdrive_path" 2> "$gdrive_statusfile_path" 1> "$gdrive_statusfile_path"  # try to unmount GoogleDrive
    result_unmount=$(cat "$gdrive_statusfile_path" | cut -d":" -f3)
    if [[ -z "$result_unmount" ]]; then
        notify-send -i dialog-information -t 3000 "$gdrive_name" "unmounted successfully"
    else
        notify-send -i dialog-information -t 3000 "$gdrive_name" "Can't unmount: $result_unmount"
    fi
else  # if not mounted
    google-drive-ocamlfuse -label alkos "$gdrive_path"  # try to mount GoogleDrive
    if [[ "$?" == 0 ]]; then
        notify-send -i dialog-information -t 3000 "$gdrive_name" "mounted successfully"
    else
        notify-send -i dialog-information -t 3000 "Error" "Failed to mount $gdrive_name"
    fi
fi

