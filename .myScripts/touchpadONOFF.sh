#!/bin/bash

# Получаем id нашего TouchPad'а
tmp1=`xinput list | grep SynPS/2\ Synaptics\ TouchPad`
tmp2=${tmp1#*id=}
# id=${tmp2::3}
id=`expr match "$tmp2" '\([0-9]\{1,3\}\)'` # '\([0-9]\{1,3\}\)'` is regexp
# Включаем или выключаем в зависимости от состояния
if xinput list-props $id | grep -i "device enabled.*1$" &> /dev/null ; then # если девайс включен
    xinput set-int-prop $id "Device Enabled" 8 0
    notify-send -t 2000 -i dialog-information "Synaptics TouchPad turned off."
else # если выключен
    xinput set-int-prop $id "Device Enabled" 8 1
    notify-send -t 2000 -i dialog-information "Synaptics TouchPad turned on."
fi 
