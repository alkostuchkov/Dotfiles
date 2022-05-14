#!/usr/bin/env python3

# Shows available updates

# updates=$(apt-show-versions -u -b)
# count=$(apt-show-versions -u -b | wc -l)
# notify-send -i software-update-available "Updates: $count" "\n$updates"

import subprocess

updates = subprocess.check_output(["apt-show-versions", "-u", "-b"]).decode("utf-8").strip()
updates_list = updates.splitlines()
subprocess.call(["notify-send", "-i", "software-update-available", "Updates: {} \n\n{}".format(len(updates_list), updates)])

