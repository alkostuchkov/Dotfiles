#!/usr/bin/env bash
#
# Dmenu script (SAMPLE) for choose a password I want to paste somewhere.
 

choose_category(){
    local catergories=("Email
Tracker
quit")

    local category=$(dmenu  -l 10  -nf '#09dbc9' -nb '#222b2e' -sf '#dbdcd5' -sb '#009185' -fn 'Ubuntu-16:normal' -p 'Choose category:'   <<< "$catergories")

    case $category in
        Email)
            choose_email;;
        Tracker)
            choose_tracker;;
        quit)
            echo "Program terminated." && exit 1;;
        *)
            echo "Wrong choice." && exit 1;;
    esac
}

choose_email(){
    local emails=("email_1
email_2
email_3
quit")

    local email=$(dmenu  -l 10  -nf '#09dbc9' -nb '#222b2e' -sf '#dbdcd5' -sb '#009185' -fn 'Ubuntu-16:normal' -p 'Password for email:'   <<< "$emails")

    case $email in
        email_1)
            user="Email/$email";;
        email_2)
            user="Email/$email";;
        email_3)
            user="Email/$email";;
        quit)
            echo "Program terminated." && exit 1;;
        *)
            echo "Wrong choice." && exit 1;;
    esac
}

choose_tracker(){
    local trackers=("tracker_1
tracker_2
quit")

    local tracker=$(dmenu  -l 10  -nf '#09dbc9' -nb '#222b2e' -sf '#dbdcd5' -sb '#009185' -fn 'Ubuntu-16:normal' -p 'Password for tracker:'   <<< "$trackers")

    case $tracker in
        tracker_1)
            user="Tracker/$tracker";;
        tracker_2)
            user="Tracker/$tracker";;
        quit)
            echo "Program terminated." && exit 1;;
        *)
            echo "Wrong choice." && exit 1;;
    esac
}

choose_category

for_notify=$(echo $user | cut -d "/" -f2)
pass $user | xclip -selection clipboard
# echo "Copied $for_notify to clipboard. Will clear in 45 seconds."
notify-send -t 5000 -i dialog-information "Copied $for_notify to clipboard.
Will clear in 45 seconds."
sleep 45
cat /dev/null | xclip -sel clip
notify-send -t 3000 -i dialog-information "Cleared."

# Colors
# choice=$(echo -e "${emails[@]}" | dmenu -p 'Edit config file: ' -nb '#282828' -nf '#fea63c' -sb '#d79921' -fn 'Ubuntu-18:normal')  # Gruvbox
# choice=$(echo -e "${emails[@]}" | dmenu -p 'Edit config file: ' -nb '#222B2E' -nf '#09DBC9' -sb '#009185' -fn 'Ubuntu-18:normal')  # Materia Manjaro

