from i3pystatus.core.command import run_through_shell
from i3pystatus.updates import Backend


class CheckupdatesPlusAur(Backend):
    """
    This module counts the available updates (pacman and aur) using checkupdates+aur.

    .. code-block:: python

        from i3pystatus.updates import checkupdates_plus_aur
        status.register(
            "updates",
            backends=[checkupdates_pus_aur.CheckupdatesPlusAur()]
        )

    """

    #  def __init__(self, aur_only=True):
        #  self.aur_only = aur_only

    @property
    def updates(self):
        command = ["checkupdates+aur"]
        checkupdates = run_through_shell(command)
        out = checkupdates.out
        #  if(self.aur_only):
            #  out = [line for line in out if line.startswith("aur")]
        return len(out.split("\n")), out
        #  return out.count("\n"), out

Backend = CheckupdatesPlusAur

if __name__ == "__main__":
    """
    Call this module directly; Print the update count and notification body.
    """
    print("Updates: {}\n\n{}".format(*Backend().updates))
