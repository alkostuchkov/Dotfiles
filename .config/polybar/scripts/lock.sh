#!/bin/bash
rm -f ~/.config/polybar/scripts/screen.png &&
ICON=~/.config/polybar/scripts/lock.png
TMPBG=~/.config/polybar/scripts/screen.png
scrot ~/.config/polybar/scripts/screen.png
convert $TMPBG -scale 10% -scale 1000% $TMPBG
convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
i3lock -t -i $TMPBG
