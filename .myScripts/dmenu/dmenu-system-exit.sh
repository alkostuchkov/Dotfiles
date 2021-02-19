#!/usr/bin/env bash
# /usr/bin/system_exit

# with openrc use loginctl
[ "$(cat /proc/1/comm)" = "systemd" ] && logind=systemctl || logind=loginctl

declare options=("lock
switch_user
suspend
hibernate
reboot
shutdown")

# choice=$(echo -e "${options[@]}" | dmenu -p 'System: ' -nb '#222B2E' -nf '#09DBC9' -sb '#009185' -fn 'Ubuntu-18:normal')  # Materia Manjaro
choice=$(echo -e "${options[@]}" | dmenu -p 'Edit config file: ' -nb '#282828' -nf '#fea63c' -sb '#d79921' -fn 'Ubuntu-18:normal')  # Gruvbox

case $choice in
    lock)
        # blurlock
        # dm-tool lock
        $HOME/.myScripts/system_exit/lock.sh
        ;;
    # logout)
        # # i3-msg exit
        # $HOME/.myScripts/system_exit/exit_qtile.py
        # ;;
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
