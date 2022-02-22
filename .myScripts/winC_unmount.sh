#!/usr/bin/env bash

winDisk="/dev/sda1"
unmountingResult=$(udisksctl unmount -b $winDisk 2>&1)

if [[ $? = 0 ]]
then  # if unmounted successfully
    # notify-send -i dialog-information -t 3000 "$(echo $unmountingResult | awk '{print $1 " " $2 " " $3}')" "$(echo $unmountingResult | awk '{print $4}')"
    notify-send -i dialog-information -t 3000 "$(echo $unmountingResult | cut -d"." -f1)"
else
    # notify-send -i dialog-error -t 3000 " " "$(echo $unmountingResult | cut -d"'" -f1)"
    errHead=$(echo ${unmountingResult} | awk -F: '{print $1}')
    errSkip=$(echo ${unmountingResult} | cut -d" " -f4)
    skipLength=`expr ${#errSkip} + ${#errHead} + 2`  # 2 = two spaces
    errTail=$(echo ${unmountingResult:$skipLength:${#unmountingResult}} | cut -d"." -f1)
    notify-send -i dialog-error -t 3000 "$errHead:" "$errTail"
fi
