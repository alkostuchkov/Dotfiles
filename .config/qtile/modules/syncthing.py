# -*- coding: utf-8 -*-
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
import os
import subprocess

from libqtile.widget import base

__all__ = ["Syncthing"]


class Syncthing(base.ThreadPoolText):
    """Displays and change Syncthing status."""

    orientations = base.ORIENTATION_HORIZONTAL
    defaults = [
        ("format", "{label}{error}", "Formatting for field names."),
        ("error", "", "Label for Errors."),
        ("update_interval", 30.0, "Update interval for the Syncthing."),
        ("label", "Syncthing:  ", "Label for the output."),
        ("path_to_script", None, "Path to a script to get status."),
        ("active_color", "#00ff00", "Color for active status."),
        ("inactive_color", "#ff0000", "Color for inactive status."),
    ]

    def __init__(self, **config):
        super().__init__("", **config)
        self.add_defaults(Syncthing.defaults)
        self.add_callbacks({"Button1": self._change_status, "Button3": self._run_webUI})
        self._get_status()

    def _get_status(self):
        try:
            self.syncthing_status = subprocess.check_output([self.path_to_script]).decode("utf-8").rstrip()
        except Exception:
            self.error = "Error"
            self.label = "Unkonown path_to_script"
            self.foreground = "#ff0000"
            #  self.syncthing_status = None
        else:
            self.error = ""
            self.foreground = self.active_color if self.syncthing_status == "active" else self.inactive_color

    def _run_webUI(self):
        """Starts Syncthing Web UI."""
        os.system("xdg-open 'http://127.0.0.1:8384/'") 

    def _change_status(self):
        """Turns on/off Syncthing."""
        if self.syncthing_status == "active":
            os.system("systemctl --user stop syncthing.service")
            self.syncthing_status = "inactive"
            #  os.system("notify-send -i dialog-information 'Syncthing service stopped'")
        else:
            os.system("systemctl --user start syncthing.service")
            self.syncthing_status = "active"
            #  os.system("notify-send -i dialog-information 'Syncthing service started'")
        self._get_status()

    def poll(self):
        self._get_status()
        val = {}
        val["label"] = self.label
        val["error"] = self.error
        return self.format.format(**val)
