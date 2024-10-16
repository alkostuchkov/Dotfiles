#!/usr/bin/env bash
###################################################
# Shows available updates for Arch or Debian Linux.
###################################################

show_updates_debian() {
# Show updates for Debian Linux.
  updates=$(apt-show-versions -u -b)

  if [[ -z "$updates" ]]; then
    updates_output=
  else
    amount_updates=$(echo "$updates" | wc -l)
    updates_output=$(echo -e "$amount_updates\n$updates")
  fi

  if [[ $amount_updates -lt 31 ]]; then
    notify-send -i software-update-available "Updates: $updates_output"
  else
    $terminal --hold -e echo "Updates: $updates_output"
    # --hold option exists for terminals: alacritty, xfce4-terminal
  fi
}


show_updates_arch() {
# Show updates for Arch Linux.
  amount_updates=0

# Check community and AUR repos.
  updates_community=$(checkupdates)
  updates_aur=$(yay -Q -u -a)

  if [[ -z "$updates_community" ]]; then
    community_output=
  else
    updates_community_count=$(echo "$updates_community" | wc -l)
    community_output=$(echo -e "\n\nCommunity: $updates_community_count\n$updates_community")
    let "amount_updates += $updates_community_count"
  fi

  if [[ -z "$updates_aur" ]]; then
    aur_output=
  else
    updates_aur_count=$(echo "$updates_aur" | wc -l)
    aur_output=$(echo -e "\n\nAUR: $updates_aur_count\n$updates_aur")
    let "amount_updates += $updates_aur_count"
  fi

  if [[ $amount_updates -lt 31 ]]; then
    notify-send -i software-update-available "Updates: $amount_updates $community_output $aur_output"
  else
    $terminal --hold -e echo "Updates: $amount_updates $community_output $aur_output"
    # --hold option exists for terminals: alacritty, xfce4-terminal
  fi
}

show_updates_void() {
# Show updates for Void Linux.
  updates=$(xbps-install -nuMS)

  if [[ -z "$updates" ]]; then
    updates_output=
  else
    amount_updates=$(echo "$updates" | wc -l)
    updates_output=$(echo -e "$amount_updates\n\n$updates" | awk '{print $1}')
  fi

  if [[ $amount_updates -lt 31 ]]; then
    notify-send -i software-update-available "Updates: $updates_output"
  else
    $terminal --hold -e echo "Updates: $updates_output"
    # --hold option exists for terminals: alacritty, xfce4-terminal
  fi
}


terminal="alacritty"
distro=$(lsb_release -a 2>/dev/null | grep -i 'distributor id' | awk '{print $3}')

case $distro in
  "Debian") show_updates_debian;;
  "Arch"|"ManjaroLinux") show_updates_arch;;
  "VoidLinux") show_updates_void;;
  *) notify-send -i dialog-error "Error:" "Unknown distro $distro.";;
esac

exit 0

