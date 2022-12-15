#!/usr/bin/env bash

#       v                      
#        🌐♬ 🌡 🖬  ⟳ ₿   ⮋⮉🡇 🡅 ⇓⇑        

# dunstify -t 5000 "$(ps axch -o cmd:17,%mem --sort=-%mem | head -5)"
notify-send -t 3000 "      CPU usage:
$(ps axch -o cmd:17,%cpu --sort=-%cpu | head -5)"

