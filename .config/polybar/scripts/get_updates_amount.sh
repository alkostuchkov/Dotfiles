#!/usr/bin/env bash
###################################################
# Shows available updates for Arch or Debian Linux.
###################################################

get_updates_amount_debian() {
# Get amount of updates for Debian Linux.

  amount_updates=$(apt-show-versions -u -b | wc -l)

  if [[ -z "$updates" ]]; then
    echo
  else
    echo "  ${amount_updates}"
  fi
}


get_updates_amount_arch() {
# Get amount of updates for Arch Linux.

  amount_updates=$(checkupdates-with-aur | wc -l)

  if [[ -z "${amount_updates}" ]] || [[ "${amount_updates}" -eq 0 ]]; then
    echo
  else
    echo "  ${amount_updates}"
  fi
}

terminal="alacritty"
distro=$(lsb_release -a 2>/dev/null | grep -i 'distributor id' | awk '{print $3}')

case $distro in
  "Debian") get_updates_amount_debian;;
  "Arch"|"ManjaroLinux") get_updates_amount_arch;;
  *) notify-send -i dialog-error "Error:" "Unknown distro $distro.";;
esac

exit 0

