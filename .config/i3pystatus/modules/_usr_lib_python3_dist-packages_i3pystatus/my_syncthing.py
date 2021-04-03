import os
import subprocess
from i3pystatus import IntervalModule


class MySyncthing(IntervalModule):
    """Shows and change Syncthing status."""

    #  path_to_script = "{}/.myScripts/get_syncthing_status.sh".format(home)
    path_to_script = None
    label = "Syncthing:  "
    syncthing_status = None
    color = "#ffffff"
    active_color = "#00ff00"
    inactive_color = "#ff0000"

    on_leftclick = "_change_status"
    #  on_leftclick = ["_change_status", arg]

    settings = (
        ("label", "text string used for output."),
        ("color", "standard color"),
        ("path_to_script", "path to script to get status"),
        ("active_color",
         "defines the color used when Syncthing status is active"),
        ("inactive_color",
         "defines the color used when Syncthing status is inactive"),
    )

    def _change_status(self):
        if self.syncthing_status == "active":
            os.system("systemctl --user stop syncthing.service")
            self.syncthing_status = "inactive"
        else:
            os.system("systemctl --user start syncthing.service")
            self.syncthing_status = "active"

    def run(self):
        try:
            self.syncthing_status = subprocess.check_output([self.path_to_script]).decode("utf-8").rstrip()
        except Exception:
            self.label = "Unknown path_to_script"
            self.color = "#ff0000"
        else:
            self.color = self.active_color if self.syncthing_status == "active" else self.inactive_color
        finally:
            self.output={
                "full_text": self.label,
                "color": self.color
            }

