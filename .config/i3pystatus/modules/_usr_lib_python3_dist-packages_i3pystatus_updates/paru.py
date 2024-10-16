from i3pystatus.core.command import run_through_shell
from i3pystatus.updates import Backend


class Paru(Backend):
    """
    This module counts the available updates using yaourt.
    By default it will only count aur packages. Thus it can be used with the
    pacman backend like this:

    .. code-block:: python

        from i3pystatus.updates import pacman, yaourt
        status.register("updates", backends = \
[pacman.Pacman(), paru.Paru()])

    If you want to count both pacman and aur packages with this module you can
    set the variable count_only_aur = False like this:

    .. code-block:: python

        from i3pystatus.updates import paru
        status.register("updates", backends = [paru.Paru(False)])
    """

    def __init__(self, aur_only=True):
        self.aur_only = aur_only

    @property
    def updates(self):
        command = ["paru", "-Qua"]
        checkupdates = run_through_shell(command)
        out = checkupdates.out
        if(self.aur_only):
            out = [line for line in out if line.startswith("aur")]
        return out.count("\n"), out

Backend = Paru

if __name__ == "__main__":
    """
    Call this module directly; Print the update count and notification body.
    """
    print("Updates: {}\n\n{}".format(*Backend().updates))
