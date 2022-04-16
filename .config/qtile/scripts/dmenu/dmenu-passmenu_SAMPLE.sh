#!/usr/bin/env bash
#
# Dmenu script (SAMPLE) for choose a password I want to paste somewhere.

choose_category(){
    local catergories=(
        "Email"
        "Tracker"
        "quit")

    local category=$(printf '%s\n' "${catergories[@]}" | dmenu  -l 10  -nf '#09dbc9' -nb '#222b2e' -sf '#dbdcd5' -sb '#009185' -fn 'Ubuntu-16:normal' -p 'Choose category:')

    case $category in
        Email)
            choose_email;;
        Tracker)
            choose_tracker;;
        quit)
            echo "Quit." && exit 1;;
        *)
            echo "Wrong choice." && exit 1;;
    esac
}

choose_email(){
    local emails=(
        "email_1"
        "email_2"
        "email_3"
        "quit")

    local email=$(printf '%s\n' "${emails[@]}" | dmenu  -l 10  -nf '#09dbc9' -nb '#222b2e' -sf '#dbdcd5' -sb '#009185' -fn 'Ubuntu-16:normal' -p 'Password for email:')

    get_user $(echo Email) $email

    # if [[ "$email" == "quit" ]]; then
        # echo "Program terminated." && exit 1
    # elif [[ "$email" ]]; then
        # user="Email/"$email
    # else
        # echo "Program terminated." && exit 1
    # fi
#
    # # case $email in
        # # email_1)
            # # user="Email/$email";;
        # # email_2)
            # # user="Email/$email";;
        # # email_3)
            # # user="Email/$email";;
        # # quit)
            # # echo "Program terminated." && exit 1;;
        # # *)
            # # echo "Wrong choice." && exit 1;;
    # # esac
}

choose_tracker(){
    local trackers=(
        "tracker_1"
        "tracker_2"
        "quit")

    local tracker=$(printf '%s\n' "${trackers[@]}" | dmenu  -l 10  -nf '#09dbc9' -nb '#222b2e' -sf '#dbdcd5' -sb '#009185' -fn 'Ubuntu-16:normal' -p 'Password for tracker:')

    get_user $(echo Tracker) $tracker

    # if [[ "$tracker" == "quit" ]]; then
        # echo "Program terminated." && exit 1
    # elif [[ "$tracker" ]]; then
        # user="Tracker/"$tracker
    # else
        # echo "Program terminated." && exit 1
    # fi
#
    # # case $tracker in
        # # tracker_1)
            # # user="Tracker/$tracker";;
        # # tracker_2)
            # # user="Tracker/$tracker";;
        # # quit)
            # # echo "Program terminated." && exit 1;;
        # # *)
            # # echo "Wrong choice." && exit 1;;
    # # esac
}

get_user(){
    if [[ "$2" == "quit" ]]; then
        echo "Quit." && exit 1
    else
        user="$1/$2"
    fi
}

choose_category

password=$(pass $user)
if [[ $? == 1 ]]; then
    notify-send -t 3000 -i dialog-information "$user doesn't exist."
elif [ $password ]; then
    for_notify=$(echo $user | cut -d "/" -f2)
    echo $password | xclip -selection clipboard
    notify-send -t 3000 -i dialog-information "Copied $for_notify to clipboard.
    Will clear in 30 seconds."
    sleep 30
    cat /dev/null | xclip -sel clip
    notify-send -t 3000 -i dialog-information "Cleared."
else
    notify-send -t 3000 -i dialog-information "Bad Passphrase."
fi

# Colors
# choice=$(echo -e "${emails[@]}" | dmenu -p 'Edit config file: ' -nb '#282828' -nf '#fea63c' -sb '#d79921' -fn 'Ubuntu-18:normal')  # Gruvbox
# choice=$(echo -e "${emails[@]}" | dmenu -p 'Edit config file: ' -nb '#222B2E' -nf '#09DBC9' -sb '#009185' -fn 'Ubuntu-18:normal')  # Materia Manjaro

