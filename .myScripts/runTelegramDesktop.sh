#!/bin/bash
# Run Telegram Desktop 

sleep 30  # delay to avoid error.
~/Programs/Telegram/Telegram -startintray -- %u &

# notify-send -i dialog-information "runTelegramDesktop... $$"
kill -9 $$
# notify-send -i dialog-information "runTelegramDesktop... $$"

