#!/bin/bash

if pidof conky | grep [0-9] > /dev/null
then
  killall conky
else
    {
        conky -c ~/.myScripts/conky/conkyrc2 2>&1 > /dev/null &
        ###sleep 3
        conky -c ~/.myScripts/conky/conkyrc1 2>&1 > /dev/null &
    }
fi
