#!/usr/bin/env bash

# Add(Delete) qemu services to(from) autostart.

if [[ -L /etc/runit/runsvdir/default/libvirtd &&
      -L /etc/runit/runsvdir/default/virtlockd &&
      -L /etc/runit/runsvdir/default/virtlogd ]]; then
  alacritty -e bash -c '
    sudo rm -f /etc/runit/runsvdir/default/libvirtd &&
    sudo rm -f /etc/runit/runsvdir/default/virtlockd &&
    sudo rm -f /etc/runit/runsvdir/default/virtlogd &&
    notify-send -t 5000 -i dialog-information "Delete services:" "\nlibvirtd,\nvirtlockd,\nvirtlogd\nare deleted from autostart and downed"'
else
  alacritty -e bash -c '
    sudo ln -sf /etc/sv/libvirtd /etc/runit/runsvdir/default/libvirtd &&
    sudo ln -sf /etc/sv/virtlockd /etc/runit/runsvdir/default/virtlockd &&
    sudo ln -sf /etc/sv/virtlogd /etc/runit/runsvdir/default/virtlogd &&
    notify-send -t 5000 -i dialog-information "Add services:" "\nlibvirtd,\nvirtlockd,\nvirtlogd\nare added to autostart and upped"'
fi
