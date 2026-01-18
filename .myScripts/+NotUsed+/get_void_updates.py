#!/usr/bin/env python3
# -*- coding: utf-8 -*-


import subprocess
import os
import sys


def get_void_updates():
    updates = ""
    updates_list = []

    try:
        updates = subprocess.check_output(["xbps-install", "-n", "-u", "-M", "-S"], encoding="utf-8").strip()
        # updates = subprocess.check_output(["apt-show-versions", "-u", "-b"], encoding="utf-8").strip()
        #  updates = subprocess.check_output(["apt-show-versions", "-u", "-b"]).decode("utf-8").strip()
        updates_list = updates.splitlines()
    except subprocess.CalledProcessError:
        updates_output = ""
    else:
        updates_output = "\nAvailable: {}{}".format(len(updates_list), updates)

    # subprocess.call(["notify-send", "-i", "software-update-available", "Updates: {}".format(updates_output)])

    # print(updates_list, type(updates_list))
    # print(updates, type(updates))

    just_update_names_list = []
    for line in updates_list:
        tmp_list = []
        name_and_version_str = line.split(" ")[0]
        splited_list = name_and_version_str.split("-")
        just_update_names_list.append(" ".join(splited_list[:-1]))

    for line in just_update_names_list:
        print(line)


def get_updates_from_file(path_to_file=f"{os.getenv('HOME')}/Dropbox/-=HP=-/Void_InstalledPackages_HP.txt"):
# def get_updates_from_file():
#     path_to_file = input("Enter the path to file or will be used the current dir: ")
#     if not path_to_file:
#         path_to_file = f"{sys.path[0]}/Void_InstalledPackages_HP.txt"
    just_update_names_list = []
    try:
        for line in open(path_to_file, "r", encoding="utf-8"):
            tmp_list = []
            name_and_version_str = line.split(" ")[0]
            splited_list = name_and_version_str.split("-")
            # name_with_2spaces = "-".join(splited_list[:-1]) + "  "
            # just_update_names_list.append(name_with_2spaces)
            just_update_names_list.append("-".join(splited_list[:-1]))

        for line in just_update_names_list:
            print(line)
    except FileNotFoundError:
        print(f"File '{path_to_file}' not found.")


# get_void_updates()
get_updates_from_file()
