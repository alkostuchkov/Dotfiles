#!/usr/bin/env bash

rm -f ~/.myScripts/system_exit/screen.png &&
ICON=~/.myScripts/system_exit/lock.png
TMPBG=~/.myScripts/system_exit/screen.png
scrot ~/.myScripts/system_exit/screen.png
convert $TMPBG -scale 10% -scale 1000% $TMPBG
convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
i3lock -t -i $TMPBG
