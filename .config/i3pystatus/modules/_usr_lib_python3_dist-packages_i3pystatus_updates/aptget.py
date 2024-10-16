#  import os
import subprocess

#  from i3pystatus.core.command import run_through_shell
from i3pystatus.updates import Backend


class AptGet(Backend):
    """
    Gets update count for Debian based distributions.

    This mimics the Arch Linux `checkupdates` script
    but with apt-get and written in python.
    """

    @property
    def updates(self):
        #  output = subprocess.check_output(["apt-show-versions", "-u", "-b"]).decode("utf-8").strip().split("\n")
        output_str = subprocess.check_output(["apt-show-versions", "-u", "-b"]).decode("utf-8")
        output = output_str.splitlines()

        #  cache_dir = "/tmp/update-cache-" + os.getenv("USER")
        #  if not os.path.exists(cache_dir):
            #  os.mkdir(cache_dir)
#
        #  command = "apt-get update -o Dir::State::Lists=" + cache_dir
        #  run_through_shell(command.split())
        #  command = "apt-get upgrade -s -o Dir::State::Lists=" + cache_dir
        #  apt = run_through_shell(command.split())
        #  out = apt.out.splitlines(True)

        #  out = "".join([line[5:] for line in out if line.startswith("Inst ")])
        #  return out.count("\n"), out
        return len(output), output_str

Backend = AptGet

if __name__ == "__main__":
    """
    Call this module directly; Print the update count and notification body.
    """
    print("Updates: {}\n\n{}".format(*Backend().updates))
    #  print("Updates: {}".format(Backend().updates))
