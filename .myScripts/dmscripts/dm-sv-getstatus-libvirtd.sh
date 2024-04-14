#!/usr/bin/env bash

# Get status qemu services (libvirtd, virtlockd, virtlogd).

status="Unknown"

if [[ -L /etc/runit/runsvdir/default/libvirtd &&
      -L /etc/runit/runsvdir/default/virtlockd &&
      -L /etc/runit/runsvdir/default/virtlogd ]]; then
  status="Upped"
else
  status="Downed"
fi
    notify-send -t 5000 -i dialog-information "Services status:" "\nlibvirtd, virtlockd, virtlogd are\n${status}"
