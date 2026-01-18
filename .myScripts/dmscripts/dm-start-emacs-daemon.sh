#!/usr/bin/env bash

# Start Emacs daemon
killall emacs || notify-send -t 5000 -i dialog-information "Emacs server not running"; /usr/bin/emacs --daemon
# emacsclient -c -a 'emacs'
