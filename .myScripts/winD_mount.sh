#!/usr/bin/env bash

winDisk="/dev/sda2"
mountingResult=$(udisksctl mount -b $winDisk 2>&1)

if [[ $? = 0 ]]
then  # if mounted successfully
    notify-send -i dialog-information -t 3000 "$(echo $mountingResult | awk '{print $1 " " $2 " " $3}')" "$(echo $mountingResult | awk '{print $4}')"
else
    # notify-send -i dialog-error -t 3000 " " "$(echo $mountingResult | cut -d"'" -f1)"
    errHead=$(echo ${mountingResult} | awk -F: '{print $1}')
    errSkip=$(echo ${mountingResult} | cut -d" " -f4)
    skipLength=`expr ${#errSkip} + ${#errHead} + 2`  # 2 = two spaces
    errTail=$(echo ${mountingResult:$skipLength:${#mountingResult}} | cut -d"." -f1)
    notify-send -i dialog-error -t 3000 "$errHead:" "$errTail"
fi
