# -*- coding: utf-8 -*-

import os
import re
import socket
import subprocess
from typing import List
from libqtile import qtile, bar, layout, widget, hook
from libqtile.config import (
        Click,
        Drag,
        Group,
        Key,
        Screen,
        KeyChord,
        Match,
        )
from libqtile.lazy import lazy
from libqtile.backend.base import Internal

##### IMPORTs from my modules #####
from modules import (
        colors,
        memory,
        all_windows_count,
        syncthing,
        show_updates,
        )


def get_all_netifaces(path_to_state="/sys/class/net/"):
    """
    Get all netifaces in the /sys/class/net/ and
    add all to the list except 'lo'.
    """
    netifaces_list = []
    for dir in os.listdir(path_to_state):
        if os.path.isdir(f"{path_to_state}{dir}"):
            if dir != "lo":
                netifaces_list.append(dir)
    return netifaces_list


def get_upped_netiface(netifaces=[]):
    """
    Check which interface is upped for widget.Net.
    Returns the first upped netiface.
    """
    if netifaces:
        for netiface in netifaces:
            state = subprocess.check_output(["cat", f"{path_to_state}{netiface}/operstate"]).decode("utf-8").rstrip()
            if state == "up":
                return netiface
    return None


def parse_windowname(text):
    """Return parsed window name for WindowName widget."""
    text_lst = text.split()
    if len(text_lst) > 2:
        #  text = text_lst[-1] + " : " + " ".join(text_lst[:-2])
        text = f"{text_lst[-1]} : {' '.join(text_lst[:-2])}"
    return text.replace("—", "-")

##### VARIABLES #####
mod = "mod4"
alt = "mod1"
my_term = "alacritty"
#  my_term_extra = "xfce4-terminal"
my_term_extra = "kitty"
my_font = "Ubuntu"
my_nerd_font = "Ubuntu Nerd Font"
my_nerd_font_extra = "Sarasa Mono SC Nerd"
my_mono_font = "Ubuntu Mono"
my_mono_bold_font = "Ubuntu Mono Bold"
SHELL = os.getenv("SHELL")
HOME = os.path.expanduser("~")
USER = os.getenv("USER")
#  my_config = f"{HOME}/.config/qtile/config.py"
colors = colors.everforest
#  colors = colors.materia_manjaro

# Check which network iface is upped.
path_to_state = "/sys/class/net/"  # enp2s0/operstate"
#  default_upped_netiface = "wlo1"
netifaces = get_all_netifaces(path_to_state)
upped_netiface = get_upped_netiface(netifaces)

##### COLORS #####
# All color schemes are in dir colors. This theme is for example.
#  # Materia Manjaro
#  colors = {
    #  "bg_panel": "#263238",  # background
    #  "bg_current_screentab": "#585E72",  # 00
    #  "fg_group_names": "#dbdcd5",  # 00 (08)
    #  "bg_current_tab": "#009185",  # 00 (foreground)
    #  "bg_other_tabs_and_odd_widgets": "#6182b8",  # 5
    #  "bg_even_widgets": "#82aaff",  # 13
    #  "fg_windowname": "#24d2af",  # 00 (06)
    #  "fg_cpu": "#89ddff",  # 15
    #  "fg_memory": "#ffcb6b",  # 12
    #  "fg_netspeed": "#c3e88d",  # 11
    #  "fg_layout": "#eeffff",  # foreground (08)
    #  "fg_keyboard": "#39adb5",  # 7
    #  "fg_date": "#39adb5",  # 7
    #  "bg_systray": "#263238",  # background
    #  "fg_updates": "#e2e0a5",  # 00
    #  "fg_weather": "#eb7bef",  # 00 (14)
    #  "bg_chord_dmenu": "#ffcb6b",  # 12
    #  "fg_chord_dmenu": "#000000",  # 1
    #  "fg_syncthing_active": "#91b859",  # 3
    #  "fg_syncthing_inactive": "#ff5370",  # 10
    #  "fg_active_group": "#e4c962",  # 00 (04)
    #  "border_focus": "#2eb398",  # 00 (foreground)
    #  "border_normal": "#1d2330",  # 00
    #  "fg_textbox": "#89ddff"  # 15
#  }

##### KEYBINDINGS #####
keys = [
# <SUPER> + <ALT> + KEYS
    Key([mod, alt], "space", lazy.spawn(f"{HOME}/.myScripts/touchpadONOFF.sh"), desc="Touchpad On/Off"),
    #  # FLIP LAYOUT FOR BSP LAYOUT
    #  Key([mod], "k", lazy.layout.flip_up(), desc=""),
    #  Key([mod], "j", lazy.layout.flip_down(), desc=""),
    #  Key([mod], "h", lazy.layout.flip_left(), desc=""),
    #  Key([mod], "l", lazy.layout.flip_right(), desc=""),

    #  Key([mod], "Return", lazy.spawn(f"{HOME}/.myScripts/runAlacrittyDiscreteGr.sh"), desc="Launch terminal"),
    Key([mod], "Return", lazy.spawn(my_term), desc="Launch terminal"),
    Key([mod, alt], "Return", lazy.spawn(my_term_extra), desc="Launch extra terminal"),
    Key([mod, alt], "r", lazy.spawn("rofi run -show drun -show-icons"), desc="Run App Lancher"),
    Key([mod, alt], "d", lazy.spawn(f"dmenu_run -i -l 10 -nb '#2d353b' -nf '#d3c6aa' -sb '#475258' -sf '#a7c080' -p 'Run: ' -fn 'Iosevka-18:normal'"), desc="Run dmenu"),  # Everforest
    #  Key([mod, alt], "d", lazy.spawn(f"dmenu_run -i -l 10 -nb '#263238' -nf '#24d2af' -sb '#009185' -p 'Run: ' -fn 'Iosevka-18:normal'"), desc="Run dmenu"),  # Materia Manjaro
    #  Key([mod, alt], "d", lazy.spawn("dmenu_run -nb #282828 -nf #e3a84e -sb #665c54 -p 'Run: ' -fn 'Ubuntu-18:normal'"), desc="Run dmenu"),  # Gruvbox
    Key([mod, alt], "Print", lazy.spawn("flameshot gui"), desc="Launch flameshot (take screenshot)"),
    Key([mod, alt], "w", lazy.spawn("/usr/bin/firefox"), desc="Launch Firefox"),
    Key([mod, alt], "u", lazy.spawn("qutebrowser"), desc="Launch qutebrowser"),
    Key([mod, alt], "e", lazy.spawn("dolphin"), desc="Launch File Manager"),
    Key([mod, alt], "n", lazy.spawn("thunar"), desc="Launch File Manager"),
    Key([mod, alt], "i", lazy.spawn("/usr/bin/octopi"), desc="Launch Octopi"),
    Key([mod, alt], "a", lazy.spawn(f"{my_term} -e {SHELL} -c ranger"), desc="Launch ranger"),
    Key([mod, alt], "y", lazy.spawn(f"{my_term_extra} -e {SHELL} -c 'yazi --cwd-file ~/.config/yazi/cwd (cat ~/.config/yazi/cwd)'"), desc="Launch yazi"),
    Key([mod, alt], "t", lazy.spawn(f"{HOME}/Programs/Telegram/Telegram -workdir {HOME}/.local/share/TelegramDesktop/ -- %u"), desc="Launch Telegram"),
    Key([mod, alt], "v", lazy.spawn(f"{my_term} -e {HOME}/.config/vifm/scripts/vifmrun"), desc="Launch vifm"),
    Key([mod, alt], "p", lazy.spawn(f"{HOME}/Programs/PyCharm-Community/bin/pycharm.sh"), desc="Launch PyCharm"),
    Key([mod, alt], "c", lazy.spawn("code"), desc="Launch VSCodium"),
    Key([mod, alt], "g", lazy.spawn("goldendict"), desc="Launch GoldenDict"),
    Key([mod, alt], "m", lazy.spawn("gvim"), desc="Launch GVim"),
    Key([mod, alt], "s", lazy.spawn(f"{HOME}/Programs/SublimeText/sublime_text"), desc="Run Sublime Text"),
    Key([mod, alt], "b", lazy.spawn("brave"), desc="Run Brave"),
    #  Key([mod, alt], "m", lazy.spawn("/usr/bin/emacsclient -c -a 'emacs'"), desc="Launch Emacsclient"),
    #  Key([mod, alt], "w", lazy.spawn(f"{HOME}/.myScripts/runFirefoxDiscreteGr.sh"), desc="Launch Firefox"),
    #  Key([mod, alt], "g", lazy.spawn(f"{HOME}/.myScripts/runGimpDiscreteGr.sh"), desc="Run GIMP DiscreteGraphics"),
    #  Key([mod, alt], "a", lazy.spawn(f"{my_term} -e {SHELL} -c {HOME}/.myScripts/runRangerDiscreteGr.sh"), desc="Run ranger DiscreteGraphics"),
    #  Key([mod, alt], "x", lazy.spawn("xterm"), desc="Run XTerm"),

# <SUPER> + <ALT> + <SHIFT> + KEYS
    #  Key([mod, alt, "shift"], "a", lazy.spawn(f"{my_term} -e pkexec ranger"), desc="Launch ranger as root"),
    #  Key([mod, alt, "shift"], "a", lazy.spawn(f"{my_term} -e sudo ranger"), desc="Launch ranger as root"),
    Key([mod, alt, "shift"], "v", lazy.spawn(f"{HOME}/.myScripts/runVifmAsRoot.sh"), desc="Launch Vifm as root"),
    Key([mod, alt, "shift"], "a", lazy.spawn(f"{HOME}/.myScripts/runRangerAsRoot.sh"), desc="Launch ranger as root"),
    Key([mod, alt, "shift"], "y", lazy.spawn(f"{HOME}/.myScripts/runYaziAsRoot.sh"), desc="Launch yazi as root"),
    Key([mod, alt, "shift"], "n", lazy.spawn(f"{HOME}/.myScripts/runThunarAsRoot.sh"), desc="Launch Thunar as root"),
    #  Key([mod, alt, "shift"], "p", lazy.spawn(f"{HOME}/.myScripts/runThunarAsRoot.sh"), desc="Launch Thunar as root"),
    Key([mod, alt, "shift"], "w", lazy.spawn("google-chrome-stable"), desc="Launch Chrome"),
    #  Key([mod, alt, "shift"], "y", lazy.spawn(f"{HOME}/.config/qtile/scripts/start-stop_syncthing.sh"), desc="Start-Stop Syncthing (for Dropbox sync)"),

# <SUPER> + <SHIFT> + KEYS
    # QTILE: reload_config, restart, quit WINDOW: kill, xkill
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "x", lazy.spawn("xkill"), desc="Kill not answered window"),
    Key([mod, "shift", "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload qtile config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    # TOGGLE FLOATING LAYOUT
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), lazy.window.center(), desc="Toggle floating"),
    # MOVE WINDOWS UP OR DOWN IN CURRENT STACK
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up in current stack "),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down in current stack "),
    #  Key([mod, "shift"], "h", lazy.layout.swap_left(), desc="Move window left in current stack "),
    #  Key([mod, "shift"], "l", lazy.layout.swap_right(), desc="Move window right in current stack "),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window left in current stack "),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window right in current stack "),

    #  Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up in current stack "),
    #  Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down in current stack "),
    #  Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window left in current stack "),
    #  Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window right in current stack "),
    # FLIP LAYOUT FOR MONADTALL/WIDE
    Key([mod, "shift"], "space", lazy.layout.flip(), desc="Flip main (left) panel with others"),

# <SUPER> + FUNCTION KEYS
    # TOGGLE FULLSCREEN
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    # SWITCH BETWEEN GROUPS (DESKTOPS)
    Key([mod], "Right", lazy.screen.next_group(), desc="Switch to the right group"),
    Key([mod], "Left", lazy.screen.prev_group(), desc="Switch to the left group"),
    # SWITCH BETWEEN LAYOUTS
    Key([mod], "Tab", lazy.next_layout(), desc="Switch to the next layout"),
    Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="Switch to the previous layout"),
    # CHANGE FOCUS
    Key([mod], "k", lazy.layout.up(), desc="Move focus up in stack pane"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down in stack pane"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus left in stack pane"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus right in stack pane"),
    #  Key([mod], "Up", lazy.layout.up(), desc="Move focus up in stack pane"),
    #  Key([mod], "Down", lazy.layout.down(), desc="Move focus down in stack pane"),
    #  Key([mod], "Left", lazy.layout.left(), desc="Move focus left in stack pane"),
    #  Key([mod], "Right", lazy.layout.right(), desc="Move focus right in stack pane"),
    Key([mod], "space", lazy.layout.next(), desc="Switch window focus to other pane(s) of stack"),
    # NORMALIZE, MINIMIZE, MAXIMIZE
    Key([alt], "n", lazy.window.toggle_minimize(), desc="Toggle window between minimumize and normal sizes"),
    Key([mod], "n", lazy.layout.normalize(), desc="Normalize window size ratios"),
    Key([mod], "m", lazy.layout.maximize(), desc="Toggle window between minimum and maximum sizes (for MonadTall/MonadWide)"),
    Key([mod], "r", lazy.layout.reset()),
    Key([mod], "Escape", lazy.group.toscreen(toggle=True)),
# <SUPER> + <CTRL> + KEYS
    Key([mod, "control"], "Return", lazy.spawn("xfce4-terminal"), desc="Launch xfce4-terminal"),
    Key([mod, "shift"], "Return", lazy.spawn("terminator"), desc="Launch terminator"),
    # RESIZE UP, DOWN, LEFT, RIGHT
    Key([mod, "control"], "i",
        lazy.layout.shrink_main(),
    ),
    Key([mod, "control"], "u",
        lazy.layout.grow_main(),
    ),
    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete()
    ),
    #  Key([mod, "control"], "Right",
        #  lazy.layout.grow_right(),
        #  lazy.layout.grow(),
        #  lazy.layout.increase_ratio(),
        #  lazy.layout.delete()
    #  ),
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
),
    #  Key([mod, "control"], "Left",
        #  lazy.layout.grow_left(),
        #  lazy.layout.shrink(),
        #  lazy.layout.decrease_ratio(),
        #  lazy.layout.add(),
    #  ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
    ),
    #  Key([mod, "control"], "Up",
        #  lazy.layout.grow_up(),
        #  lazy.layout.grow(),
        #  lazy.layout.decrease_nmaster(),
    #  ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
    ),
    #  Key([mod, "control"], "Down",
        #  lazy.layout.grow_down(),
        #  lazy.layout.shrink(),
        #  lazy.layout.increase_nmaster(),
    #  ),
    Key([mod, "control"], "w", lazy.spawn(f"{HOME}/Programs/Tor/Browser/start-tor-browser --detach"), desc="Launch Tor"),

# <SUPER> + <SHIFT> + <CTRL> + KEYS

# <ALT> + KEYS
    # KeyChords
    # Dmenu
    KeyChord([alt], "m", [
        Key([], "c", lazy.spawn(f"{HOME}/.myScripts/dmscripts/dm-edit-configs.sh"), desc="Run dmenu script for editing config files"),
        Key([], "l", lazy.spawn(f"{HOME}/.myScripts/system_exit/lock.sh"), desc="Lock screen"),
        Key([], "r", lazy.spawn(f"{HOME}/.myScripts/dmscripts/dm-run-programs.sh"), desc="Run choice of most used utils"),
        Key([], "s", lazy.spawn(f"{HOME}/.myScripts/dmscripts/dm-run-scripts.sh"), desc="Run chosen search engine"),
        Key([], "x", lazy.spawn(f"{HOME}/.myScripts/dmscripts/dm-system-exit.sh"), desc="System exit menu")],
        mode=False,
        name="Dmenu"
    ),
    Key([alt], "w", lazy.spawn("rofi run -show window -show-icons"), desc="Switch between opened windows"),
    Key([alt], "F4", lazy.spawn(f"{HOME}/Programs/ByeBye/ByeBye"), desc="Launch logout app 'ByeBye'"),
    Key([alt], "Tab", lazy.group.next_window(), desc="Switch to the next window"),
# <ALT> + <SHIFT> + KEYS
    Key([alt, "shift"], "Tab", lazy.group.prev_window(), desc="Switch to the previous window"),

# <CONTROL> + <ALT> + KEYS
    Key(["control", alt], "c", lazy.spawn(f"{HOME}/.myScripts/dmscripts/dm-edit-configs.sh"), desc="Run dmenu script for editing config files"),
    Key(["control", alt], "l", lazy.spawn(f"{HOME}/.myScripts/system_exit/lock.sh"), desc="Lock screen"),
    Key(["control", alt], "r", lazy.spawn(f"{HOME}/.myScripts/dmscripts/dm-run-programs.sh"), desc="Run choice of most used utils"),
    Key(["control", alt], "s", lazy.spawn(f"{HOME}/.myScripts/dmscripts/dm-run-scripts.sh"), desc="Run chosen search engine"),
    Key(["control", alt], "x", lazy.spawn(f"{HOME}/.myScripts/dmscripts/dm-system-exit.sh"), desc="System exit menu"),
    # TREETAB CONTROLS
    Key(["control", alt], "j", lazy.layout.section_down(), desc="Move up a section in TreeTab"),
    Key(["control", alt], "k", lazy.layout.section_up(), desc="Move down a section in TreeTab"),

# <CONTROL> + <SHIFT> + KEYS
    Key(["control", "shift"], "Escape", lazy.spawn(f"{my_term} -e htop"), desc="Run htop"),

# MULTIMEDIA KEYS
# <Fn> + <F1-F12>
    Key([], "XF86Display", lazy.spawn("lxrandr"), desc="Run lxrandr (choose monitor)"),
    Key([], "XF86ScreenSaver", lazy.spawn(f"{HOME}/.myScripts/system_exit/lock.sh"), desc="Lock screen"),
    Key([], "XF86Battery", lazy.spawn("xfce4-power-manager-settings"), desc="Power manager settings"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Toggle audio mute"),
    Key([mod], "F7", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Toggle audio mute"),

# <SUPER> + <F1-F12>
    # Brightness & Volume (extra step 5)
    Key([mod], "F2", lazy.spawn(f"{HOME}/.myScripts/brightness_down.sh"), desc="Brightness Down (5-)"),
                   # lazy.spawn("brightnessctl set 5-"),
    Key([mod], "F3", lazy.spawn(f"{HOME}/.myScripts/brightness_up.sh"), desc="Brightness Up (+5)"),
                   # lazy.spawn("brightnessctl set +5"),
    Key([mod], "F8", lazy.spawn(f"{HOME}/.myScripts/volume_down.sh"), desc="Volume Down"),
    Key([mod], "F9", lazy.spawn(f"{HOME}/.myScripts/volume_up.sh"), desc="Volume Up more than 100%"),
]
# MOVE/RESIZE FLOATING WINDOW
for key, x, y in [
        ("Left", -10, 0),
        ("Right", 10, 0),
        ("Up", 0, -10),
        ("Down", 0, 10)]:
    keys.append(Key([mod, "control"], key, lazy.window.move_floating(x, y)))
    keys.append(Key([mod, "shift"], key, lazy.window.resize_floating(x, y)))

##### GROUPS #####
#       v                   
#        🌐♬ 🌡 🖬  ⟳ ₿   ⮋⮉🡇 🡅 ⇓⇑        
group_names = [
    (" ", {"layout": "columns"}),  # WWW
    (" ", {"layout": "columns"}),  # DEV
    #  (" ", {"layout": "monadtall"}),  # DEV
    (" ", {"layout": "max"}),      # FM
    (" ", {"layout": "columns"}),  # SYS
    (" ", {"layout": "columns"}),  # VIRT
    (" ", {"layout": "max"}),      # CHAT
    (" ", {"layout": "columns"}),  # GFX
    (" ", {"layout": "max"}),      # VID
    (" ", {"layout": "columns"})   # MULT
]

#  groups = [Group(name, **kwargs, label="{}{}".format(name, i)) for i, (name, kwargs) in enumerate(group_names, 1)]
groups = [Group(name, **kwargs, label=f"{i} {name}") for i, (name, kwargs) in enumerate(group_names, 1)]
#  groups = [Group(name, **kwargs, label=f"{name}{i}") for i, (name, kwargs) in enumerate(group_names, 1)]

for i, group_name in enumerate(group_names, 1):
    keys.extend([
        Key([mod], str(i),
            lazy.group[group_name[0]].toscreen(toggle=True),
            desc="Switch to another group"),  # (toggle=True) to toggle groups since Qtile 0.19.0
        Key([mod, "shift"], str(i),
            lazy.window.togroup(group_name[0], switch_group=True),
            #  lazy.group[group_name[0]].toscreen(toggle=True),  # follow the
            #  window when it moves to another group DOESN'T NEED ANY MORE
            #  BECAUSE OF switch_group=True
            desc="Send current window to another group")
    ])

# A dict: {1: " ", 2: " ", ... } for simple access and if group_names will be
# renamed.
group_names_indexes = {i: group_names[0][0] for (i, group_names[0]) in enumerate(group_names, start=1)}

##### LAYOUTS #####
layout_theme = {
    "border_width": 3,
    "margin": 4,
    "border_focus": colors.get("border_focus", "#535d6c"),
    "border_normal": colors.get("border_normal", "#000000"),
}

layouts = [
    #  layout.Columns(**layout_theme, border_on_single=False, margin_on_single=False),
    layout.Columns(**layout_theme, border_on_single=True),
    layout.TreeTab(
         #  font=my_font,
         font=my_nerd_font,
         fontsize=14,
         bg_color=colors.get("bg_panel", "#222222"),
         active_bg=colors.get("bg_current_tab", "#535d6c"),
         active_fg=colors.get("fg_active_group", "#ffffff"),
         inactive_bg=colors.get("bg_systray", "#222222"),
         inactive_fg=colors.get("fg_group_names", "#aaaaaa"),
         border_width=2,
         padding_y=5,
         sections=["FIRST", "SECOND"],
         section_fontsize=12,
         section_fg=colors.get("fg_group_names", "#aaaaaa"),
         section_top=10,
         panel_width=320
    ),
    #  layout.Max(**layout_theme),
    layout.Max(
      margin=0,
      border_width=0,
      border_focus=colors.get("border_focus", "#535d6c"),
      border_normal=colors.get("border_normal", "#000000")
    ),
    #  layout.MonadTall(**layout_theme, single_border_width=False, single_margin=False),
    #  layout.MonadWide(**layout_theme, single_border_width=False, single_margin=False),
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    #  layout.Bsp(**layout_theme),
    #  layout.Tile(shift_windows=True, **layout_theme),
    #  layout.Stack(stacks=2, **layout_theme),
    #  layout.Stack(num_stacks=2),
    #  layout.RatioTile(**layout_theme),
    #  layout.VerticalTile(**layout_theme),
    #  layout.Matrix(**layout_theme),
    #  layout.Zoomy(**layout_theme),
    #  layout.Floating(**layout_theme)
]

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = {
    #  "font": my_font,
    "font": my_nerd_font,
    "fontsize": 14,
    "padding": 2,
    "background": colors.get("bg_panel", "#222222"),
    "foreground": colors.get("fg_group_names", "#ffffff")
}


def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
        widget.GroupBox(
            font=my_nerd_font,
            fontsize=16,
            margin_y=3,
            margin_x=0,
            padding_y=7,
            padding_x=3,
            borderwidth=3,
            active=colors.get("fg_active_group", "#ffffff"),
            inactive=colors.get("fg_group_names", "#aaaaaa"),
            rounded=False,
            highlight_color=colors.get("bg_panel", "#222222"),
            highlight_method="block",
            urgent_alert_method="block",
            this_current_screen_border=colors.get("bg_current_tab", "#535d6c"),
            this_screen_border=colors.get("bg_other_tabs_and_odd_widgets", "#6182b8"),
            other_current_screen_border=colors.get("bg_panel", "#222222"),
            other_screen_border=colors.get("bg_panel", "#222222"),
        ),
        widget.Chord(
            fontsize=14,
            padding = 10,
            background=colors.get("bg_chord_dmenu", "#ffcb6b"),
            foreground=colors.get("fg_chord_dmenu", "#000000")
        ),
        #  widget.WindowName(
            #  #  #  font=my_mono_bold_font,
            #  fontsize=14,
            #  foreground=colors["fg_windowname"],
            #  padding=0,
            #  #  parse_text=parse_windowname
        #  ),
        widget.TaskList(
            fontsize=17,
            font=my_nerd_font_extra,
            #  foreground=colors["fg_windowname"],
            foreground=colors.get("fg_tasklist", "#ffffff"),
            border=colors.get("bg_current_tab", "#222222"),
            borderwidth=0,
            highlight_method="block",
            #  txt_floating=" ",
            txt_maximized="🗖 ",
            txt_minimized="🗕 ",
            txt_floating="🗗 ",
            icon_size=20,
            padding_y=4,
        ),
        widget.CheckUpdates(
            foreground=colors.get("fg_updates", "#ffffff"),
            colour_have_updates=colors.get("fg_updates", "#ffffff"),
            #  no_update_string="No updates",
            font=my_nerd_font,
            fontsize=14,
            #  distro="Arch_checkupdates",
            #  custom_command="checkupdates-with-aur",
            custom_command="xbps-install -nuMS",
            display_format="  {updates}",  # ⟳ 
            mouse_callbacks={
                "Button1": lambda: qtile.spawn(f"{HOME}/.config/qtile/scripts/show_updates.sh"),
                "Button2": lambda: qtile.spawn(f"{my_term} --hold -e sudo xbps-install -Su"),
                #  "Button2": lambda: qtile.spawn(f"{my_term} --hold -e yay -Syu"),
                #  "Button3": lambda: show_updates.show_updates_arch()
            },
            update_interval=10800  # 3 hours (60*60*3)
        ),
        widget.Sep(
            linewidth=1,
            padding=10
        ),
        #  widget.TextBox(
            #  #  text="⇆ ",
            #  text="🗘",
            #  font=my_nerd_font,
            #  fontsize=16,
            #  foreground=colors["fg_textbox"],
            #  padding=0
        #  ),
        #  syncthing.Syncthing(
            #  path_to_script=f"{HOME}/.config/qtile/scripts/get_syncthing_status.sh",
            #  font=my_nerd_font,
            #  label="Syncthing\n ",
            #  update_interval=60,
            #  active_color=colors["fg_syncthing_active"],
            #  inactive_color=colors["fg_syncthing_inactive"],
            #  padding=0
        #  ),
        #  widget.Sep(
            #  linewidth=1,
            #  padding=10
        #  ),
        widget.OpenWeather(
            foreground=colors.get("fg_weather", "#ffffff"),
            coordinates={"longitude": "30.9754", "latitude": "52.4345"},
            fontsize=20,
            format="{icon}",
            update_interval=1800,
            mouse_callbacks={
                "Button3": lambda: qtile.spawn("xdg-open https://openweathermap.org/city/627907"),
            }
        ),
        #  widget.TextBox(
            #  #  text="⛅",
            #  text="🌡",
            #  fontsize=16,
            #  foreground=colors["fg_weather"],
            #  padding=0
        #  ),
        widget.OpenWeather(
            foreground=colors.get("fg_weather", "#ffffff"),
            coordinates={"longitude": "30.9754", "latitude": "52.4345"},
            format="{location_city}: {temp}°{units_temperature}\n{weather_details}",
            update_interval=1800,
            mouse_callbacks={
                "Button3": lambda: qtile.spawn("xdg-open https://openweathermap.org/city/627907"),
            }
        ),
        widget.Sep(
            linewidth=1,
            padding=10
        ),
        widget.TextBox(
            text="",
            #  text=" ",
            font=my_nerd_font,
            fontsize=16,
            foreground=colors.get("fg_cpu", "#ffffff"),
            padding=0,
            mouse_callbacks={
                "Button1": lambda: qtile.spawn(f"{HOME}/.config/qtile/scripts/top5_cpu_usage.sh"),
                #  "Button3": lambda: qtile.spawn(f"{my_term} -e htop")
                "Button3": lambda: qtile.spawn(f"{my_term} -e {SHELL} -c htop")
            }
        ),
        widget.CPU(
            foreground=colors.get("fg_cpu", "#ffffff"),
            padding=0,
            format="{freq_current}GHz\n{load_percent: .0f}%",
            mouse_callbacks={
                "Button1": lambda: qtile.spawn(f"{HOME}/.config/qtile/scripts/top5_cpu_usage.sh"),
                "Button3": lambda: qtile.spawn(f"{my_term} -e {SHELL} -c htop")
            }
        ),
        widget.Sep(
            linewidth=1,
            padding=10
        ),
        widget.TextBox(
            text="",
            font=my_nerd_font,
            fontsize=16,
            foreground=colors.get("fg_memory", "#ffffff"),
            padding=0,
            mouse_callbacks={
                "Button1": lambda: qtile.spawn(f"{HOME}/.config/qtile/scripts/top5_mem_usage.sh"),
                "Button3": lambda: qtile.spawn(f"{my_term} -e {SHELL} -c htop")
            }
        ),
        memory.Memory(
            foreground=colors.get("fg_memory", "#ffffff"),
            padding=0,
            format="{MemUsed: .1f}{mm}\n{MemPercent: .0f}%",
            measure_mem="G",
            mouse_callbacks={
                "Button1": lambda: qtile.spawn(f"{HOME}/.config/qtile/scripts/top5_mem_usage.sh"),
                "Button3": lambda: qtile.spawn(f"{my_term} -e {SHELL} -c htop")
            }
        ),
        widget.Sep(
            linewidth=1,
            padding=10
        ),
        #  widget.Net(
            #  interface=upped_netiface,
            #  #  format=upped_netiface + ":{down} ↓↑{up}",
            #  #  format="{down} ⇓⇑{up}",
            #  #  format="{down} ⤋⤊{up}",
            #  #  format="{down} ⬇⬆{up}",
            #  #  format="{down} 🡇🡅{up}",
            #  #  format="{down}  {up}",
            #  font=my_nerd_font,
            #  format="{up} \n{down} ",
            #  foreground=colors["fg_netspeed"],
            #  padding=0
        #  ),
        #  widget.Sep(
            #  linewidth=1,
            #  padding=10
        #  ),
        widget.KeyboardKbdd(
            configured_keyboards=["🇺🇸 ", "🇷🇺 "],
            #  configured_keyboards=["US", "RU"],
            #  display_map={"us": "🇺🇸", "ru": "🇷🇺"},
            #  option="grp:alt_shift_toggle",
            #  option="grp:caps_toggle",
            foreground=colors.get("fg_keyboard", "#ffffff"),
            fontsize=16,
            padding=0,
        ),
        widget.Systray(
            padding=1,
            icon_size=24,
        ),
        widget.TextBox(
            text=" ",
            padding=1,
        ),
        widget.CurrentLayoutIcon(
            #  custom_icon_paths=[f"{HOME}/.config/qtile/icons/layouts"],
            foreground=colors.get("fg_layout", "#ffffff"),
            padding=0,
            scale=0.6,
            mouse_callbacks={
                "Button1": qtile.next_layout,
                "Button3": qtile.prev_layout,
            }
        ),
        widget.WindowCount(
            text_format=" {num} /",
            fontsize=14,
            padding=0,
            foreground=colors.get("fg_layout", "#ffffff"),
        ),
        all_windows_count.WindowCount(
            text_format=" {num}",
            fontsize=14,
            padding=0,
            foreground=colors.get("fg_layout", "#ffffff"),
        ),
        widget.Sep(
            linewidth=1,
            padding=10
        ),
        widget.TextBox(
            text="",
            font=my_nerd_font,
            fontsize=16,
            foreground=colors.get("fg_date", "#ffffff"),
            padding=0,
            mouse_callbacks={"Button1": lambda: qtile.spawn("gsimplecal")}
        ),
        widget.Clock(
            foreground=colors.get("fg_date", "#ffffff"),
            padding=3,
            #  mouse_callbacks={"Button1": lambda qtile: qtile.spawn("gsimplecal")},
            mouse_callbacks={"Button1": lambda: qtile.spawn("gsimplecal")},
            format="%a, %d %b\n%H:%M:%S"
        )
    ]
    return widgets_list


def init_widgets_screen1():
    """Returns widgets_list for Monitor 1."""
    widgets_screen1 = init_widgets_list()
    return widgets_screen1  # Slicing removes unwanted widgets on Monitors 1,3


def init_widgets_screen2():
    """Returns widgets_list for Monitor 2."""
    widgets_screen2 = init_widgets_list()
    return widgets_screen2  # Monitor 2 will display all widgets in widgets_list


def init_screens():
    return [
      Screen(
        #  wallpaper=f"{HOME}/Picturies/Wallpapers/NewWallpapers/0314_1280x1024.jpg",
        #  wallpaper_mode="fill",
        top=bar.Bar(
          widgets=init_widgets_screen1(),
          opacity=1.0,
          size=32)),
      #  Screen(
        #  top=bar.Bar(
          #  widgets=init_widgets_screen2(),
          #  opacity=1.0,
          #  size=32)),
      #  Screen(
        #  top=bar.Bar(
          #  widgets=init_widgets_screen1(),
          #  opacity=1.0,
          #  size=32))
    ]

    #  return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=32))]
    # For several Monitors.
    #  return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=30)),
            #  Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=30)),
            #  Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=30))]


# lazy functions can be bound to keybindings.
@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


@lazy.function
def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)


@lazy.function
def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)


@lazy.function
def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)


##### DRAG AND RESIZE FLOATING LAYOUTS BY MOUSE #####
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    #  Click([mod], "Button2", lazy.window.bring_to_front())
]

##### MY FLOATING APPS #####
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # from libqtile.layout.floating class Floating
    # add (unpack *) default_float_rules
    *layout.Floating.default_float_rules,
    Match(wm_class="BreakTimer"),
    Match(title="Tor Browser", wm_class="Tor Browser"),
    Match(title="О Tor Browser", wm_class="Tor Browser"),
    Match(title="About Mozilla Firefox", wm_class="Browser"),
    Match(title="Execute File", wm_class="pcmanfm"),
    Match(title="Close Button Action", wm_class="tixati"),  # Tixati
    Match(title="Confirm File Replacing", wm_class="pcmanfm"),
    Match(title="Terminator Preferences", wm_class="terminator"),
    Match(title="Терминатор Параметры", wm_class="terminator"),
    Match(title="File Operation Progress", wm_class="Thunar"),
    Match(title="Действия над файлами", wm_class="Thunar"),
    Match(title="Create Snapshot", wm_class="Timeshift-gtk"),
    Match(title="Delete Snapshots", wm_class="Timeshift-gtk"),
    Match(title="Создать снимок", wm_class="Timeshift-gtk"),
    Match(title="Удалить снимки", wm_class="Timeshift-gtk"),
    #  Match(title="win0", wm_class="jetbrains-webstorm"),  # WebStorm
    #  Match(title="Import WebStorm Settings", wm_class="jetbrains-webstorm"),
    Match(title="splash"),  # PyCharm
    Match(title="Update"),  # PyCharm
    Match(title="Compress"),  # Engrampa create archive dialog
    #  Match(title="win0", wm_class="jetbrains-pycharm-ce"),  # PyCharm
    #  Match(title="Welcome to PyCharm", wm_class="jetbrains-pycharm-ce"),
    #  Match(title="License Activation", wm_class="jetbrains-pycharm-ce"),  # PyCharm
    #  Match(title="Settings", wm_class="jetbrains-pycharm-ce"),  # PyCharm
    #  Match(title="Python Interpreters", wm_class="jetbrains-pycharm-ce"),  # PyCharm
    #  Match(title="Open Project", wm_class="jetbrains-pycharm-ce"),  # PyCharm
    #  Match(title="Update", wm_class="com-intellij-updater-Runner"),  # PyCharm's updates
    Match(wm_class="nm-connection-editor"),
    Match(wm_class="megasync"),
    Match(wm_class="minitube"),
    Match(wm_class="CheckEmail"),
    #  Match(wm_class="GParted"),
    #  Match(wm_class="keepass2"),
    Match(wm_class="pinentry-gtk-2"),
    Match(title="Pinentry"),  # GPG key password entry
    #  Match(wm_class="vlc"),
    #  Match(wm_class="smplayer"),
    Match(wm_class="deadbeef"),
    Match(wm_class="galculator"),
    #  {"wmclass": "VirtualBox Manager"},
    Match(title="branchdialog"),  # gitk
    Match(title="Open File"),
    Match(wm_class="gnome-font-viewer"),
    Match(wm_class="fluxgui"),
    Match(wm_class="xfce4-power-manager-settings"),
    Match(wm_class="pavucontrol"),
    Match(wm_class="gdebi-gtk"),
    Match(wm_class="volumeicon"),
    Match(wm_class="gcolor3"),
    Match(wm_class="gcolor2"),
    #  Match(wm_class="gvim"),
    Match(wm_class="qt5ct"),
    Match(wm_class="lxappearance"),
    Match(wm_class="confirmreset"),  # gitk
    Match(wm_class="makebranch"),  # gitk
    Match(wm_class="maketag"),  # gitk
    Match(wm_class="ssh-askpass")  # ssh-askpass
], border_focus=colors.get("border_focus", "#535d6c"),
   border_normal=colors.get("border_normal", "#000000"),
   border_width=1,)

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
cursor_warp = False
bring_front_click = False
#  bring_front_click = "floating_only"
auto_fullscreen = True
focus_on_window_activation = "focus"
#  focus_on_window_activation = "urgent"
#  focus_on_window_activation = "smart"
#  focus_on_window_activation = "never"

@hook.subscribe.client_new
def move_new_window_to_certain_group(c):
    """Moves a new window to certain grop and switchs (if you want) to that group."""
    if (c.name == f"{USER} - Thunar" or
        c.name == "thunar" or
        c.name == f"{USER} - Dolphin" or
        c.name == "dolphin"):

        c.togroup(group_names_indexes[3])
        qtile.groups_map[group_names_indexes[3]].cmd_toscreen()
    if (c.name == "Oracle VM VirtualBox Менеджер" or
        c.name == "Oracle VM VirtualBox Manager"):

        c.togroup(group_names_indexes[5])
        qtile.groups_map[group_names_indexes[5]].cmd_toscreen()
    if c.name == "Telegram":
        c.togroup(group_names_indexes[6])
        qtile.groups_map[group_names_indexes[6]].cmd_toscreen()
    if c.name == "Rakuten Viber":
        c.togroup(group_names_indexes[6])
        qtile.groups_map[group_names_indexes[6]].cmd_toscreen()
    if c.name == "GNU Image Manipulation Program":
        c.togroup(group_names_indexes[7])
        qtile.groups_map[group_names_indexes[7]].cmd_toscreen()
    if c.name == "Mozilla Thunderbird":
        #  c.togroup(" ")
        c.togroup(group_names_indexes[9])

##### AUTOSTART #####
@hook.subscribe.startup_once
def start_once():
    subprocess.call([f"{HOME}/.config/qtile/scripts/autostart.sh"])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


if __name__ in ("config", "__main__"):
    screens = init_screens()
    widgets_list = init_widgets_list()
    #  widgets_screen1 = init_widgets_screen1()
    #  widgets_screen2 = init_widgets_screen2()



##### SOME WHAT I DID BEFORE BUT DON'T NEED ANY MORE. BUT SAVED FOR SOME REASONS #####
#  #  @hook.subscribe.float_change
#  #  @hook.subscribe.client_new
#  @hook.subscribe.client_focus
#  def set_hint(window):
    #  window.window.set_property("IS_FLOATING", str(window.floating), type="STRING", format=8)
    #  #  subprocess.check_output(["notify-send", "-i", "dialog-information", "{} {}".format(window.name, window.floating)])
    #  #  window.window.set_property("IS_FLOATING", int(window.floating))


#  #  # Does what I wanted perfectly!!!
#  #  #  @hook.subscribe.client_mouse_enter
#  @hook.subscribe.client_focus
#  @hook.subscribe.client_new
#  def focus_new_floating_window(window):
    #  """ Bring a new floating window to the front. """
    #  #  subprocess.check_output(["notify-send", "-i", "dialog-information", "{}".format(window.name)])
    #  if window.floating:
        #  window.bring_to_front()


# TODO: show amount of opened windows (DONE!!!)
#  @hook.subscribe.client_new
#  def increase_opened_windows_counter(window):
    #  """ Increase counter of opened windows. """
    #  global opened_windows_counter
    #  opened_windows_counter += 1
    #  subprocess.check_output(["notify-send", "-i", "dialog-information", "{}\nOpened windows: {}".format(window.name, opened_windows_counter)])
#
#
#  @hook.subscribe.client_killed
#  def decrease_opened_windows_counter(window):
    #  """ Decrease counter of opened windows. """
    #  global opened_windows_counter
    #  opened_windows_counter -= 1
    #  subprocess.check_output(["notify-send", "-i", "dialog-information", "{}\nOpened windows: {}".format(window.name, opened_windows_counter)])


# TODO: delete later if these below two functions don't need any more!!!
#  @lazy.function
#  def float_to_front(qtile):
    #  """
    #  Bring all floating windows of the group to front
    #  """
    #  global floating_windows
    #  floating_windows = []
    #  for window in qtile.currentGroup.windows:
        #  if window.floating:
            #  window.bring_to_front()
            #  floating_windows.append(window)
    #  floating_windows[-1].focus()


#  @hook.subscribe.client_new
#  def floating_dialogs(window):
    #  dialog = window.window.get_wm_type() == "dialog"
    #  transient = window.window.get_wm_transient_for()
    #  if dialog or transient:
        #  window.floating = True


###############################################################################
# New EXAMPLE from qtile 0.17.0 for float_rules[]!!!
#
# rules specified in `layout.Floating`'s `float_rules` are now evaluated with
# AND-semantics instead of OR-semantics, i.e. if you specify 2 different
# property rules, both have to match
#
#  from libqtile.config import Match
#      Match(title=WM_NAME, wm_class=WM_CLASS, role=WM_WINDOW_ROLE)
#
#
#  Match(wm_type="utility"),
#  Match(wm_type="notification"),
#  Match(wm_type="toolbar"),
#  Match(wm_type="splash"),
#  Match(wm_type="dialog"),
#  Match(wm_class="file_progress"),
#  Match(wm_class="confirm"),
#  Match(wm_class="dialog"),
#  Match(wm_class="download"),
#  Match(wm_class="error"),
#  Match(wm_class="notification"),
#  Match(wm_class="splash"),
#  Match(wm_class="toolbar"),
#  Match(func=lambda c: c.has_fixed_size()),
###############################################################################


# float_rules for qtile version < 0.17.0
#  floating_layout = layout.Floating(float_rules=[
    #  # Run the utility of `xprop` to see the wm class and name of an X client.
    #  {"wname": "synaptic"},  # Synaptic (Preinstall dialog)
    #  {"wname": "Summary"},  # Synaptic (Summary dialog)
    #  {"wmclass": "Polkit-gnome-authentication-agent-1"},  # Polkit-gnome-authentication-agent-1
    #  {"wname": "Properties for *"},  # Dolphin (properties dialog)
    #  {"wname": "Delete Permanently"},  # Dolphin (delete dialog)
    #  {"wname": "Preference"},  # Haroopad (md editor)
    #  {"wname": "Terminator Preferences"},
    #  {"wname": "Close Button Action"},  # Tixati
    #  {"wmclass": "com-intellij-updater-Runner"},
    #  {"wmclass": "minitube"},
    #  {"wmclass": "CheckEmail"},
    #  {"wmclass": "GParted"},
    #  {"wmclass": "keepass2"},
    #  {"wmclass": "vlc"},
    #  {"wmclass": "smplayer"},
    #  {"wmclass": "deadbeef"},
    #  {"wmclass": "galculator"},
    #  #  {"wmclass": "VirtualBox Manager"},
    #  {"wname": "win0"},  # PyCharm
    #  {"wmclass": "gnome-font-viewer"},
    #  {"wmclass": "fluxgui"},
    #  {"wmclass": "xfce4-power-manager-settings"},
    #  {"wmclass": "pavucontrol"},
    #  {"wmclass": "gdebi-gtk"},
    #  {"wmclass": "volumeicon"},
    #  {"wmclass": "gcolor3"},
    #  {"wmclass": "gvim"},
    #  {"wmclass": "qt5ct"},
    #  {"wmclass": "lxappearance"},
    #  {"wmclass": "confirm"},
    #  {"wmclass": "dialog"},
    #  {"wmclass": "download"},
    #  {"wmclass": "error"},
    #  {"wmclass": "file_progress"},
    #  {"wmclass": "notification"},
    #  {"wmclass": "splash"},
    #  {"wmclass": "toolbar"},
    #  {"wmclass": "confirmreset"},  # gitk
    #  {"wmclass": "makebranch"},  # gitk
    #  {"wmclass": "maketag"},  # gitk
    #  {"wname": "branchdialog"},  # gitk
    #  {'wname': 'Open File'},
    #  {"wname": "pinentry"},  # GPG key password entry
    #  {"wmclass": "ssh-askpass"},  # ssh-askpass
#  ])


