#!/bin/bash
# Mounts GoogleDrive_auto

google-drive-ocamlfuse -label auto ~/GoogleDrive_auto/ 2> ~/.myScripts/GoogleDriveStatus_auto.txt 1> ~/.myScripts/GoogleDriveStatus_auto.txt
isMounted=`cat ~/.myScripts/GoogleDriveStatus_auto.txt`
if [ -z $isMounted ] #if not mounted (no errors - GoogleDriveStatus.txt is empty)
	then
		notify-send -i dialog-information "GoogleDrive_auto mounted successfully"
		# notify-send -i dialog-information "$isMounted"
    else #if mounted
		# notify-send -i dialog-information "$isMounted"
		fusermount -u ~/GoogleDrive_auto/  #unmount GoogleDrive
		# echo "" > ~/.myScripts/GoogleDriveStatus.txt
		notify-send -i dialog-information "GoogleDrive_auto unmounted successfully"
fi
