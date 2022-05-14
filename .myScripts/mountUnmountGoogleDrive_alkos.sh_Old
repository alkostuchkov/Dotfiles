#!/bin/bash
# Mounts GoogleDrive_auto

google-drive-ocamlfuse -label alkos ~/GoogleDrive_alkos/ 2> ~/.myScripts/GoogleDriveStatus_alkos.txt 1> ~/.myScripts/GoogleDriveStatus_alkos.txt
isMounted=`cat ~/.myScripts/GoogleDriveStatus_alkos.txt`
if [ -z $isMounted ] #if not mounted (no errors - GoogleDriveStatus.txt is empty)
	then
		notify-send -i dialog-information "GoogleDrive_alkos mounted successfully"
		# notify-send -i dialog-information "$isMounted"
    else #if mounted
		# notify-send -i dialog-information "$isMounted"
		fusermount -u ~/GoogleDrive_alkos/  #unmount GoogleDrive
		# echo "" > ~/.myScripts/GoogleDriveStatus.txt
		notify-send -i dialog-information "GoogleDrive_alkos unmounted successfully"
fi
