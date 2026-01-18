#!/bin/sh

if pidof conky | grep [0-9] > /dev/null
then
  exec killall conky
else
    {
        exec conky -c ~/conky/conkyrc2NoCon 2>&1 > /dev/null &
        sleep 3
        exec conky -c ~/conky/conkyrc1NoCon 2>&1 > /dev/null &
    }
fi
