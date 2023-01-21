#!/usr/bin/env bash

# with openrc use loginctl
[ "$(cat /proc/1/comm)" = "systemd" ] && logind=systemctl || logind=loginctl

# declare options=("lock
options=("lock
switch_user
logout
suspend
hibernate
reboot
shutdown")

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

DMENU="dmenu -i -l 10 -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p"

choice=$(${DMENU} 'System:'   <<< "$options")
# choice=$(dmenu -i -l 10  -nf ${nf} -nb ${nb} -sf ${sf} -sb ${sb} -fn ${fn} -p 'System:'   <<< "$options")

case $choice in
    lock)
        # blurlock
        # dm-tool lock
        $HOME/.myScripts/system_exit/lock.sh
        ;;
    logout)
        # i3-msg exit
        # $HOME/.myScripts/system_exit/exit_qtile.py
        id=$(pgrep qtile)
        kill -15 $id
        ;;
    switch_user)
        dm-tool switch-to-greeter
        ;;
    suspend)
        $HOME/.myScripts/system_exit/lock.sh && $logind suspend
        # blurlock && $logind suspend
        ;;
    hibernate)
        $HOME/.myScripts/system_exit/lock.sh && $logind hibernate
        # blurlock && $logind hibernate
        ;;
    reboot)
        $logind reboot
        ;;
    shutdown)
        $logind poweroff
        ;;
    *)
		exit 1;;
esac

exit 0
