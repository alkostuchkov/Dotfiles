#!/usr/bin/env bash

if [ $(du -m /var/log/cron.log | cut -f 1) -gt 500 ]
then
    cat /dev/null > /var/log/cron.log
    # echo "More than 500M"
# else
    # echo "Less or equal than 500M"
fi

