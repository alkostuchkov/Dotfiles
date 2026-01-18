#!/bin/bash
# Mounts GoogleDrive

google-drive-ocamlfuse ~/GoogleDrive/ 2> ~/.myScripts/GoogleDriveStatus.txt 1> ~/.myScripts/GoogleDriveStatus.txt
isMounted=`cat ~/.myScripts/GoogleDriveStatus.txt`
if [ -z $isMounted ] #if not mounted (no errors - GoogleDriveStatus.txt is empty)
	then
		notify-send -i dialog-information "Google Drive mounted successfully"
		# notify-send -i dialog-information "$isMounted"
    else #if mounted
		# notify-send -i dialog-information "$isMounted"
		fusermount -u ~/GoogleDrive/  #unmount GoogleDrive
		# echo "" > ~/.myScripts/GoogleDriveStatus.txt
		notify-send -i dialog-information "Google Drive unmounted successfully"
fi
