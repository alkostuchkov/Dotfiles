#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Shows available updates for Arch and Debian Linux.

import subprocess


def show_updates_debian():
    """Show updates for Debian Linux."""
    updates = ""
    updates_list = []
    
    try:
        updates = subprocess.check_output(["apt-show-versions", "-u", "-b"]).decode("utf-8").strip()
        updates_list = updates.splitlines()
    except subprocess.CalledProcessError:
        updates_output = ""
    else:
        updates_output = "\nAvailable: {}{}".format(len(updates_list), updates)
        
    subprocess.call(["notify-send", "-i", "software-update-available", "Updates: {}".format(updates_output)])

    #  subprocess.call(["notify-send", "-i", "software-update-available", "Updates: {} \n\n{}".format(len(updates_list), updates)])


def show_updates_arch():
    """Show updates for Arch Linux."""
    amount_updates = 0

    def check_community():
        """Check community repo."""
        updates_community = ""
        updates_community_list = []

        try:
            updates_community = subprocess.check_output(["pacman", "-Q", "-u"]).decode("utf-8").strip()
            updates_community_list = updates_community.splitlines()
        except subprocess.CalledProcessError:
            community_output = ""
        else:
            community_output = ("\n\ncommunity: {}\n{}".format(len(updates_community_list), updates_community)
                    if updates_community_list else "")
            nonlocal amount_updates
            amount_updates += len(updates_community_list)
        return community_output

    def check_aur():
        """Check AUR repo."""
        updates_aur = ""
        updates_aur_list = []
        try:
            updates_aur = subprocess.check_output(["paru", "-Q", "-u", "-a"]).decode("utf-8").strip()
            updates_aur_list = updates_aur.splitlines()
        except subprocess.CalledProcessError:
            aur_output = ""
        else:
            aur_output = ("\n\nAUR: {}\n{}".format(len(updates_aur_list), updates_aur)
                    if updates_aur_list else "")
            nonlocal amount_updates
            amount_updates += len(updates_aur_list)
        return aur_output

    subprocess.call(["notify-send", "-i", "software-update-available", "Updates: {amount_updates}{}{}".format(check_community(), check_aur(), amount_updates=amount_updates)])


