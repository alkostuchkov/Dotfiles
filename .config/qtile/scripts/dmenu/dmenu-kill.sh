#!/usr/bin/env bash
#
# Script name: dmkill
# Description: Search for a process to kill.
# Dependencies: dmenu
# GitLab: https://www.gitlab.com/dwt1/dmscripts
# License: https://www.gitlab.com/dwt1/dmscripts/LICENSE
# Contributors: Derek Taylor

# Colors:
# Materia Manjaro
nf='#09dbc9'
nb='#222b2e'
sf='#dbdcd5'
sb='#009185'
fn='Ubuntu-16:normal'
# Gruvbox
# nf='#fea63c'
# nb='#282828'
# # sf='#dbdcd5'
# sb='#d79921'
# fn='Sarasa Mono SC Nerd-17:normal'

# Running ps to get running processes and display in dmenu.
selected="$(ps --user "$(id -u)" -F --no-headers | \
            awk '{print $1" "$2" "$11}' | \
            dmenu -i -l 20 -nf ${nf} -nb ${nb} \
            -sf ${sf} -sb ${sb} \
            -fn ${fn} -p "Search for process to kill:")"

# Nested 'if' statements.  The outer 'if' statement is what to do
# when we select one of the 'selected' options listed in dmenu.
if [[ -n $selected ]]; then
    # Piping No/Yes into dmenu as a safety measure, in case you
    # select a process that you don't actually want killed.
    answer="$(echo -e "No\nYes" | dmenu -i -l 2 -nf '#09dbc9' -nb '#222b2e' \
            -sf '#dbdcd5' -sb '#009185' \
            -fn 'Ubuntu-14:normal'  -p "Kill $selected?")"

    if [[ $answer == "Yes" ]]; then
        selpid="$(awk '{print $2}' <<< "$selected")";
        kill -9 "$selpid"
		echo "Process $selected has been killed." && exit 0
    else
		echo "Program terminated." && exit 0
    fi
fi

exit 0
