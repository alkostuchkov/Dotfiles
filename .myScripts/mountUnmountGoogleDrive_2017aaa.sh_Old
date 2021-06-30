#!/bin/bash
# Mounts GoogleDrive_2017aaa

google-drive-ocamlfuse -label 2017aaa ~/GoogleDrive_2017aaa/ 2> ~/.myScripts/GoogleDriveStatus_2017aaa.txt 1> ~/.myScripts/GoogleDriveStatus_2017aaa.txt
isMounted=`cat ~/.myScripts/GoogleDriveStatus_2017aaa.txt`
if [ -z $isMounted ] #if not mounted (no errors - GoogleDriveStatus.txt is empty)
	then
		notify-send -i dialog-information "GoogleDrive_2017aaa mounted successfully"
		# notify-send -i dialog-information "$isMounted"
    else #if mounted
		# notify-send -i dialog-information "$isMounted"
		fusermount -u ~/GoogleDrive_2017aaa/  #unmount GoogleDrive
		# echo "" > ~/.myScripts/GoogleDriveStatus.txt
		notify-send -i dialog-information "GoogleDrive_2017aaa unmounted successfully"
fi
