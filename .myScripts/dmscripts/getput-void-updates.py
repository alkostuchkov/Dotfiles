#!/usr/bin/env python3
# -*- coding: utf-8 -*-


import subprocess
import os

DISTRO_NAME = os.popen("lsb_release -a 2>/dev/null | grep -i 'distributor id' | awk '{print $3}'").read().strip()
HOST_NAME = os.popen("hostname").read().strip()


def print_available_updates():
    updates_list = []

    try:
        updates = subprocess.check_output(["xbps-install", "-n", "-u", "-M", "-S"], encoding="utf-8").strip()
        #  updates = subprocess.check_output(["apt-show-versions", "-u", "-b"]).decode("utf-8").strip()
        updates_list = updates.splitlines()
    except subprocess.CalledProcessError:
        updates_output = ""
    else:
        updates_output = "\nAvailable: {}{}".format(len(updates_list), updates)

    just_update_names_list = []
    for line in updates_list:
        name_and_version_str = line.split(" ")[0]
        splitted_list = name_and_version_str.split("-")
        just_update_names_list.append("-".join(splitted_list[:-1]))

    for line in just_update_names_list:
        print(line)


def get_installed_from_the_file(
        path_to_dir=f"{os.getenv('HOME')}/Dropbox/InstalledPackages/",
        file_name=f"{DISTRO_NAME}_InstalledPackages_{HOST_NAME}.txt"):
    try:
        for line in open(f"{path_to_dir}{file_name}", mode="r", encoding="utf-8"):
            print(line, end="")
    except FileNotFoundError:
        print(f"File '{path_to_dir}{file_name}' not found.")


def put_installed_to_the_file(
        path_to_dir=f"{os.getenv('HOME')}/Dropbox/InstalledPackages/",
        file_name=f"{DISTRO_NAME}_InstalledPackages_{HOST_NAME}.txt"):
    try:
        installed = subprocess.check_output(["xbps-query", "-m"], encoding="utf-8").strip()
        installed_list = installed.splitlines()
    except subprocess.CalledProcessError:
        print("No updates available.")
    else:
        with open(f"{path_to_dir}{file_name}", mode="w", encoding="utf-8") as f:
            for line in installed_list:
                name_and_version_str = line.split(" ")[0]
                splitted_list = name_and_version_str.split("-")
                ready_str = "-".join(splitted_list[:-1])
                f.write(f"{ready_str}\n")
            print(f"Wrote {len(installed_list)} packages into \n{path_to_dir}{file_name}")


if __name__ == "__main__":
    print(
        """
Choose what you want:

1 Get installed manually packages from the file
2 Put installed manually packages into the given file
3 Print available updates
"""

    )
    choice = input()
    if choice == "1":
        get_installed_from_the_file()
    elif choice == "2":
        put_installed_to_the_file()
    elif choice == "3":
        print_available_updates()
    else:
        print("Exit...")
