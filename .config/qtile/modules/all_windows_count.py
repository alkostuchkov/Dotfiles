from __future__ import annotations

from typing import Any

from libqtile import bar, hook
from libqtile.command.base import expose_command
from libqtile.widget import base


class WindowCount(base._TextBox):
    """A simple widget to show the number of ALL opened windows."""
    defaults: list[tuple[str, Any, str]] = [
        ("font", "sans", "Text font"),
        ("fontsize", None, "Font pixel size. Calculated if None."),
        ("fontshadow", None, "font shadow color, default is None(no shadow)"),
        ("padding", None, "Padding left and right. Calculated if None."),
        ("foreground", "#ffffff", "Foreground colour."),
        ("text_format", "{num}", "Format for message"),
        ("show_zero", False, "Show window count when no windows")
    ]  # type: List[Tuple[str, Any, str]]

    def __init__(self, text=" ", width=bar.CALCULATED, **config):
        base._TextBox.__init__(self, text=text, width=width, **config)
        self.add_defaults(WindowCount.defaults)
        self._count = 0

    def _configure(self, qtile, bar):
        base._TextBox._configure(self, qtile, bar)
        self._setup_hooks()

    def _setup_hooks(self):
        hook.subscribe.client_killed(self._decrease_count)
        hook.subscribe.client_new(self._increase_count)

    def _increase_count(self, *args):
        self._count += 1
        self.update()

    def _decrease_count(self, window):
        self._count -= 1
        self.update()

    def calculate_length(self):
        if self.text and (self._count or self.show_zero):
            return min(
                self.layout.width,
                self.bar.width
            ) + self.actual_padding * 2
        else:
            return 0

    def update(self):
        self.text = self.text_format.format(num=self._count)
        self.bar.draw()

    def calculate_length(self):
        if self._count or self.show_zero:
            return base._TextBox.calculate_length(self)
        return 0

    @expose_command()
    def get(self):
        """Retrieve the current text."""
        return self.text
