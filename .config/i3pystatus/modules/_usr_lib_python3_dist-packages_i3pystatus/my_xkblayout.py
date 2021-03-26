import subprocess
from itertools import zip_longest

from i3pystatus import IntervalModule
from xkbgroup import XKeyboard


class Xkblayout(IntervalModule):
    """Displays and changes current keyboard layout.

    ``change_layout`` callback finds the current layout in the
    ``layouts`` setting and enables the layout following it. If the
    current layout is not in the ``layouts`` setting the first layout
    is enabled.

    ``layouts`` can be stated with or without variants,
    e.g.: ``status.register("xkblayout", layouts=["de neo", "de"])``

    Requires xkbgroup (from PyPI)

    .. rubric:: Available formatters

    * `{num}` — current group number
    * `{name}` — current group name
    * `{symbol}` — current group symbol
    * `{variant}` — current group variant
    * `{count}` — number of all groups
    * `{names}` — names of all groups
    * `{symbols}` — symbols of all groups
    * `{variants}` — variants of all groups
    * `{flag}` — flag instead of symbol
    """

    interval = 1
    color = "#FFFFFF"
    format = "\u2328 {symbol}"
    layouts = []
    uppercase = True
    settings = (
        ("color", "RGB hexadecimal color code specifuer, defaults to #FFFFFF"),
        ("format", "Format string"),
        ("layouts", "List of layouts"),
        ("uppercase", "Flag for uppercase output"),
    )
    flags = {
        "US": "🇺🇸",
        "RU": "🇷🇺" 
    }

    on_leftclick = ["change_layout", 1]
    on_upscroll = ["change_layout", 1]
    on_downscroll = ["change_layout", -1]

    def init(self):
        if self.layouts:
            self.set_layouts(self.layouts)

        self._xkb = XKeyboard(auto_open=True)

    def set_layouts(self, layouts):
        self.layouts = layouts    # Set, so that it could be used as a callback

        layouts_parts = [x.split() for x in self.layouts]
        symbols_variants_zipped = zip_longest(*layouts_parts, fillvalue="")
        symbols_variants_str = [",".join(x) for x in symbols_variants_zipped]
        assert len(symbols_variants_str) > 0

        if len(symbols_variants_str) == 1:
            symbols = symbols_variants_str[0]
            args = "setxkbmap -layout {}".format(symbols)
        elif len(symbols_variants_str) == 2:
            (symbols, variants) = symbols_variants_str
            args = "setxkbmap -layout {} -variant {}".format(symbols, variants)
        else:
            raise ValueError("Wrong layouts value: {}".format(self.layouts))

        subprocess.check_call(args.split())

    def change_layout(self, increment=1):
        self._xkb.group_num += increment

    def run(self):
        cdict = {
            "num": self._xkb.group_num,
            "name": self._xkb.group_name,
            "symbol": self._xkb.group_symbol,
            "variant": self._xkb.group_variant,
            "count": self._xkb.groups_count,
            "names": self._xkb.groups_names,
            "symbols": self._xkb.groups_symbols,
            "variants": self._xkb.groups_variants,
            "flag": self.flags.get(self._xkb.group_symbol.upper(), self._xkb.group_symbol),
        }

        full_text = self.format.format(**cdict)
        full_text = full_text.upper() if self.uppercase else full_text

        self.data = cdict
        self.output = {
            "full_text": full_text,
            "color": self.color,
        }
