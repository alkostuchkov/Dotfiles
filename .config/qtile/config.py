# -*- coding: utf-8 -*-

import os
import re
import socket
import subprocess
from typing import List  # noqa: F401
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Screen, KeyChord, Match
from libqtile.lazy import lazy
from libqtile import qtile

from modules import memory
from modules import arcobattery
from modules import all_windows_count


def get_all_netifaces(path_to_state="/sys/class/net/"):
    """
    Get all netifaces in the /sys/class/net/ and
    add all to the list except 'lo'.
    """
    netifaces_list = []
    for dir in os.listdir(path_to_state):
        if os.path.isdir("{}{}".format(path_to_state, dir)):
            if dir != "lo":
                netifaces_list.append(dir)
    return netifaces_list


def which_netiface_upped(netifaces=[]):
    """
    Check which interface is upped for widget.Net.
    Returns the first upped netiface.
    """
    if netifaces:
        for netiface in netifaces:
            state = subprocess.check_output(["cat", "{}{}{}".format(path_to_state, netiface, "/operstate")]).decode("utf-8").rstrip()
            if state == "up":
                return netiface
    return None


mod = "mod4"
alt = "mod1"
my_term = "alacritty"
my_term_extra = "terminator"
#  my_term = "konsole"
my_font = "Ubuntu"
my_nerd_font = "Ubuntu Nerd Font"
my_mono_font = "Ubuntu Mono"
my_mono_bold_font = "Ubuntu Mono Bold"
home = os.path.expanduser("~")
my_config = home + "/.config/qtile/config.py"

# Check which network iface is upped.
path_to_state = "/sys/class/net/"  # enp2s0/operstate"
#  default_upped_netiface = "wlo1"
netifaces = get_all_netifaces(path_to_state)
upped_netiface = which_netiface_upped(netifaces)
# Counter of opened windows
#  opened_windows_counter = 0

keys = [
# <SUPER> + FUNCTION KEYS
    Key([mod], "Return", lazy.spawn(my_term), desc="Launch terminal"),
    Key([mod, "shift"], "Return", lazy.spawn("terminator"), desc="Launch terminator"),
    Key([mod], "r", lazy.spawn("rofi run -show drun -show-icons"), desc="Run App Lancher"),
    Key([mod], "d", lazy.spawn("dmenu_run -nb #222B2E -nf #09DBC9 -sb #009185 -p 'Run: ' -fn 'Ubuntu-18:normal'"), desc="Run dmenu"),  # Materia Manjaro
#  Key([mod], "d", lazy.spawn("dmenu_run -nb #282828 -nf #d79921 -sb #fea63c -p 'Run: ' -fn 'Ubuntu-18:normal'"), desc="Run dmenu"),  # Gruvbox
    Key([mod], "Print", lazy.spawn("flameshot gui"), desc="Run flameshot (take screenshot)"),
    Key([mod], "w", lazy.spawn("firefox"), desc="Launch Firefox"),
    Key([mod], "u", lazy.spawn("qutebrowser"), desc="Launch qutebrowser"),
    Key([mod], "e", lazy.spawn("dolphin"), desc="Launch File Manager"),
    Key([mod], "i", lazy.spawn("synaptic-pkexec"), desc="Launch Synaptic"),
    Key([mod], "g", lazy.spawn(home + "/.myScripts/runGimpDiscreteGr.sh"), desc="Run GIMP DiscreteGraphics"),
    Key([mod], "b", lazy.spawn(home + "/Programs/SublimeText/sublime_text"), desc="Run Sublime Text"),
    #  Key([mod], "p", lazy.spawn(home + "/Programs/PyCharm-Community/bin/pycharm.sh"), desc="Run PyCharm"),
    Key([mod], "t", lazy.spawn(home + "/Programs/Telegram/Telegram -workdir /home/alexander/.local/share/TelegramDesktop/ -- %u"), desc="Run Telegram"),
    Key([mod], "x", lazy.spawn("xterm"), desc="Run XTerm"),
    Key([mod], "v", lazy.spawn(my_term + " -e " + home + "/.config/vifm/scripts/vifmrun"), desc="Run vifm"),
    # TOGGLE FULLSCREEN
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    # SWITCH BETWEEN GROUPS
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

# <SUPER> + <SHIFT> + KEYS  (-nf #fea63c)
    Key([mod, "shift"], "y", lazy.spawn(home + "/.myScripts/start-stop_syncthing.sh"), desc="Start-Stop Syncthing (for Dropbox sync)"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "x", lazy.spawn("xkill"), desc="Kill not answered window"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    # TOGGLE FLOATING LAYOUT
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    # MOVE WINDOWS UP OR DOWN IN CURRENT STACK
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up in current stack "),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down in current stack "),
    #  Key([mod, "shift"], "h", lazy.layout.swap_left(), desc="Move window left in current stack "),
    #  Key([mod, "shift"], "l", lazy.layout.swap_right(), desc="Move window right in current stack "),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window left in current stack "),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window right in current stack "),

    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up in current stack "),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down in current stack "),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window left in current stack "),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window right in current stack "),
    # FLIP LAYOUT FOR MONADTALL/WIDE
    Key([mod, "shift"], "space", lazy.layout.flip(), desc="Flip main (left) panel with others"),
    # NORMALIZE, MINIMIZE, MAXIMIZE
    Key([mod, "shift"], "n", lazy.layout.normalize(), desc="Normalize window size ratios"),
    Key([mod, "shift"], "m", lazy.layout.maximize(), desc="Toggle window between minimum and maximum sizes"),
    Key([mod, "shift"], "d", lazy.window.toggle_minimize(), desc="Toggle window between minimumize and normal sizes"),

# <SUPER> + <ALT> + KEYS
    Key([mod, alt], "space", lazy.spawn(home + "/.myScripts/touchpadONOFF.sh"), desc="Touchpad On/Off"),
    # FLIP LAYOUT FOR BSP LAYOUT
    Key([mod, alt], "k", lazy.layout.flip_up(), desc=""),
    Key([mod, alt], "j", lazy.layout.flip_down(), desc=""),
    Key([mod, alt], "h", lazy.layout.flip_left(), desc=""),
    Key([mod, alt], "l", lazy.layout.flip_right(), desc=""),

# <SUPER> + <CTRL> + KEYS
    # RESIZE UP, DOWN, LEFT, RIGHT
    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete()
    ),
    Key([mod, "control"], "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete()
    ),
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add()
    ),
    Key([mod, "control"], "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add()
    ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster()
    ),
    Key([mod, "control"], "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster()
    ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster()
    ),
    Key([mod, "control"], "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster()
    ),
    Key([mod, "control"], "r", lazy.layout.reset()),

# <ALT> + KEYS
    KeyChord([alt], "m", [
        Key([], "c", lazy.spawn(home + "/.myScripts/dmenu/dmenu-edit-configs.sh"), desc="Run dmenu script for editing config files"),
        Key([], "p", lazy.spawn(home + "/.myScripts/dmenu/dmenu-passmenu.sh"), desc="Run dmenu script for editing config files"),
        Key([], "l", lazy.spawn(home + "/.myScripts/system_exit/lock.sh"), desc="Lock screen"),
        Key([], "k", lazy.spawn(home + "/.myScripts/dmenu/dmenu-kill.sh"), desc="Kill chosen process"),
        Key([], "s", lazy.spawn(home + "/.myScripts/dmenu/dmenu-search.sh"), desc="Run chosen search engine"),
        Key([], "e", lazy.spawn(home + "/.myScripts/dmenu/dmenu-unicode.sh"), desc="Choose an emoji"),
        Key([], "x", lazy.spawn(home + "/.myScripts/dmenu/dmenu-system-exit.sh"), desc="System exit menu")],
        mode="Dmenu"
    ),
    #  Key([alt], "c", lazy.spawn(home + "/.myScripts/dmenu/dmenu-edit-configs.sh"), desc="Run dmenu script for editing config files"),
    #  Key([alt], "p", lazy.spawn(home + "/.myScripts/dmenu/dmenu-passmenu.sh"), desc="Run dmenu script for editing config files"),
    #  Key([alt], "s", lazy.spawn(home + "/.myScripts/dmenu/dmenu-system-exit.sh"), desc="System exit menu"),
    #  Key([alt], "l", lazy.spawn(home + "/.myScripts/system_exit/lock.sh"), desc="Lock screen"),
    #  Key([alt], "t", lazy.spawn(home + "/.myScripts/dmenu/dmenu-kill.sh"), desc="Kill chosen process"),
    #  Key([alt], "e", lazy.spawn(home + "/.myScripts/dmenu/dmenu-search.sh"), desc="Run chosen search engine"),
    #  Key([alt], "k", lazy.spawn(home + "/.myScripts/on-off_conky.sh"), desc="On-Off conky"),
    Key([alt], "w", lazy.spawn("rofi run -show window -show-icons"), desc="Switch between opened windows"),
    Key([alt], "Tab", lazy.group.next_window(), desc="Switch to the next window"),

# <CONTROL> + <ALT> + KEYS
# <CONTROL> + <SHIFT> + KEYS
# <ALT> + <SHIFT> + KEYS
    Key([alt, "shift"], "Tab", lazy.group.prev_window(), desc="Switch to the previous window"),

# MULTIMEDIA KEYS
# <Fn> + <F1-F12>
    Key([], "XF86Display", lazy.spawn("lxrandr"), desc="Run lxrandr (choose monitor)"),
    Key([], "XF86ScreenSaver", lazy.spawn(home + "/.myScripts/system_exit/lock.sh"), desc="Lock screen"),
    Key([], "XF86Battery", lazy.spawn("xfce4-power-manager-settings"), desc="Power manager settings"),

# <SUPER> + <F1-F12>
    # Brightness & Volume (extra step 5)
    Key([mod], "F2", lazy.spawn(home + "/.myScripts/brightness_down.sh"), desc="Brightness Down (5-)"),
                   # lazy.spawn("brightnessctl set 5-"),
    Key([mod], "F3", lazy.spawn(home + "/.myScripts/brightness_up.sh"), desc="Brightness Up (+5)"),
                   # lazy.spawn("brightnessctl set +5"),
    Key([mod], "F8", lazy.spawn(home + "/.myScripts/volume_down.sh"), desc="Volume Down"),
    Key([mod], "F9", lazy.spawn(home + "/.myScripts/volume_up.sh"), desc="Volume Up more than 100%"),
]
# MOVE/RESIZE FLOATING WINDOW
for key, x, y in [
        ("Left", -10, 0),
        ("Right", 10, 0),
        ("Up", 0, -10),
        ("Down", 0, 10)]:
    keys.append(Key([mod, "shift"], key, lazy.window.move_floating(x, y)))
    keys.append(Key([mod, "control"], key, lazy.window.resize_floating(x, y)))

#       v                   
#        🌐♬ 🌡 🖬  ⟳ ₿   ⮋⮉🡇 🡅 ⇓⇑        
group_names = [(" ", {"layout": "columns"}),  # WWW
               (" ", {"layout": "columns"}),  # DEV
               #  (" ", {"layout": "monadtall"}),  # DEV
               (" ", {"layout": "max"}),      # FM
               (" ", {"layout": "columns"}),  # SYS
               (" ", {"layout": "columns"}),  # VIRT
               (" ", {"layout": "columns"}),  # CHAT
               (" ", {"layout": "columns"}),  # GFX
               (" ", {"layout": "max"}),      # VID
               (" ", {"layout": "columns"})]  # MULT

groups = [Group(name, **kwargs, label="{}{}".format(name, i)) for i, (name, kwargs) in enumerate(group_names, 1)]

for i, group_name in enumerate(group_names, 1):
    keys.extend([
        Key([mod], str(i),
            lazy.group[group_name[0]].toscreen(),
            desc="Switch to another group"),
        Key([mod, "shift"], str(i),
            lazy.window.togroup(group_name[0]),
            desc="Send current window to another group")
    ])

layout_theme = {"border_width": 3,
                "margin": 5,
                "border_focus": "2eb398",  # Materia Manjaro
                "border_normal": "1d2330"
                #  "border_focus": "d79922",  # Gruvbox yellow
                #  "border_focus": "fea63c",  # Gruvbox yellow (lighter)
}

layouts = [
    #  layout.Bsp(**layout_theme),
    layout.Columns(**layout_theme, border_on_single=True),
    layout.Max(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    #  layout.Tile(shift_windows=True, **layout_theme),
    #  layout.Stack(stacks=2, **layout_theme),
    #  layout.Stack(num_stacks=2),
    #  layout.RatioTile(**layout_theme),
    #  layout.VerticalTile(**layout_theme),
    #  layout.Matrix(**layout_theme),
    #  layout.Zoomy(**layout_theme),
    #  layout.TreeTab(
         #  font = my_font,
         #  fontsize=12,
         #  sections=["FIRST", "SECOND"],
         #  section_fontsize=12,
         #  bg_color="141414",
         #  active_bg="90C435",
         #  active_fg="000000",
         #  inactive_bg="384323",
         #  inactive_fg="a0a0a0",
         #  padding_y=5,
         #  section_top=10,
         #  panel_width=320
         #  ),
    #  layout.Floating(**layout_theme)
]

# DT's colors
#  colors = [["#282c34", "#282c34"], # panel background
          #  ["#434758", "#434758"], # background for current screen tab
          #  ["#ffffff", "#ffffff"], # font color for group names
          #  ["#ff5555", "#ff5555"], # border line color for current tab
          #  ["#8d62a9", "#8d62a9"], # border line color for other tab and odd widgets
          #  ["#668bd7", "#668bd7"], # color for the even widgets
          #  ["#e1acff", "#e1acff"]] # window name

# My colors
#  colors = [["#222B2E", "#222B2E"], # 0 panel background
          #  ["#585E72", "#585E72"], # 1 background for current screen tab
          #  ["#DBDCD5", "#DBDCD5"], # 2 font color for group names
          #  ["#009185", "#009185"], # 3 border line color for current tab
          #  ["#8d62a9", "#8d62a9"], # 4 border line color for other tab and odd widgets
          #  ["#668bd7", "#668bd7"], # 5 color for the even widgets
          #  ["#24D2AF", "#24D2AF"], # 6 window name
          #  ["#E2A0A5", "#E2A0A5"], # 7 CPU widget
          #  ["#F2B06A", "#F2B06A"], # 8 Memory widget
          #  ["#03DB25", "#03DB25"], # 9 NetSpeed widget
          #  ["#ffffff", "#ffffff"], # 10 Layout widget
          #  ["#55EBEA", "#55EBEA"], # 11 KeyboardLayout widget
          #  ["#F3F008", "#F3F008"], # 12 Date widget
          #  ["#404555", "#404555"], # 13 system tray
          #  ["#F6F806", "#F6F806"]] # 14 updates

# Materia Manjaro
colors = [["#263238", "#263238"],  # 0 panel background
          ["#585E72", "#585E72"],  # 1 background for current screen tab
          ["#dbdcd5", "#dbdcd5"],  # 2 font color for group names
          ["#009185", "#009185"],  # 3 border line color for current tab
          ["#8d62a9", "#8d62a9"],  # 4 border line color for other tab and odd widgets
          ["#6182b8", "#6182b8"],  # 5 color for the even widgets
          ["#24d2af", "#24d2af"],  # 6 window name
          ["#e2a0a5", "#e2a0a5"],  # 7 CPU widget
          ["#ffb62c", "#ffb62c"],  # 8 Memory widget
          ["#91b859", "#91b859"],  # 9 NetSpeed widget
          ["#ffffff", "#ffffff"],  # 10 Layout widget
          ["#39adb5", "#39adb5"],  # 11 KeyboardLayout widget
          ["#39adb5", "#39adb5"],  # 12 Date widget
          #  ["#f2b06a", "#f2b06a"],  # 12 Date widget
          ["#404555", "#404555"],  # 13 system tray
          ["#e2e0a5", "#e2e0a5"],  # 14 updates
          #  ["#ffcb6b", "#ffcb6b"],  # 14 updates
          ["#eb7bef", "#eb7bef"],  # 15 weather
          ["#d79921", "#d79921"],  # 16 Chord
          ["#ffbb00", "#ffbb00"],  # 17 Dmenu background
          ["#070800", "#070800"]]  # 18 Dmenu foreground
          #  ["#ec30f3", "#ec30f3"]]  # 15 weather
          #  ["#e2e0a5", "#e2e0a5"]]  # 15 weather

# Gruvbox colors
#  colors = [["#282828", "#282828"], # 0 panel background
          #  ["#505050", "#505050"], # 1 background for current screen tab
          #  ["#ebdbb2", "#ebdbb2"], # 2 font color for group names
          #  ["#d79921", "#d79921"], # 3 border line color for current tab
          #  ["#b16286", "#b16286"], # 4 border line color for other tab and odd widgets
          #  ["#458588", "#458588"], # 5 color for the even widgets
          #  ["#fea63c", "#fea63c"], # 6 window name
          #  ["#b16286", "#b16286"], # 7 CPU widget
          #  #  ["#cc241d", "#cc241d"], # 7 CPU widget
          #  ["#98971a", "#98971a"], # 8 Memory widget
          #  ["#689d6a", "#689d6a"], # 9 NetSpeed widget
          #  ["#ffffff", "#ffffff"], # 10 Layout widget
          #  ["#458588", "#458588"], # 11 KeyboardLayout widget
          #  ["#a89984", "#a89984"], # 12 Date widget
          #  ["#282828", "#282828"], # 13 system tray
          #  ["#d79921", "#d79921"]] # 14 updates

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font=my_font,
    fontsize=12,
    padding=2,
    background=colors[2]
)
extension_defaults = widget_defaults.copy()


def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
            #  widget.Sep(
                    #  linewidth=0,
                    #  padding=3,
                    #  foreground=colors[2],
                    #  background=colors[0]
                    #  ),
            #  widget.Image(
                    #  filename="~/.config/qtile/icons/logos/debian_logo_green_brighter+.png",
                    #  mouse_callbacks={"Button1": lambda qtile: qtile.cmd_spawn("rofi run -show drun -show-icons")}
                    #  ),
            #  widget.Sep(
                    #  linewidth=0,
                    #  padding=3,
                    #  foreground=colors[2],
                    #  background=colors[0]
                    #  ),
            widget.GroupBox(
                    font=my_nerd_font,
                    fontsize=14,
                    margin_y=3,
                    margin_x=0,
                    #  padding_y=5,
                    #  padding_x=3,
                    padding_y=7,
                    padding_x=3,
                    borderwidth=3,
                    active=colors[2],
                    inactive=colors[2],
                    rounded=False,
                    highlight_color=colors[1],
                    #  highlight_method="line",
                    highlight_method="block",
                    this_current_screen_border=colors[3],
                    this_screen_border=colors [4],
                    other_current_screen_border=colors[0],
                    other_screen_border=colors[0],
                    foreground=colors[2],
                    background=colors[0]
                    ),
            widget.Chord(
                    padding = 10,
                    background=colors[17],
                    foreground=colors[18],
                    fontsize=14
                    ),
            widget.WindowName(
                    #  font=my_mono_bold_font,
                    font=my_font,
                    fontsize=14,
                    #  show_state="{name}", #  show_state=False,
                    show_state="{state}{name}", #  show_state=True,
                    foreground=colors[6],
                    background=colors[0],
                    padding=0
                    ),
            #  widget.Spacer(
                    #  length=bar.STRETCH,
                    #  background=colors[0]
                    #  ),
            widget.CheckUpdates(
                    foreground=colors[14],
                    background=colors[0],
                    colour_have_updates=colors[14],
                    #  colour_no_updates="ffffff",
                    fontsize=14,
                    custom_command="apt-show-versions --upgradeable",
                    #  custom_command="apt-show-versions | grep upgradeable | wc -l",
                    display_format=" {updates}",  # ⟳ 
                    distro="Debian",
                    #  no_update_string="No updates",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(my_term_extra + " -e 'sudo apt update && sudo apt upgrade && $SHELL'"),
                        "Button3": lambda: qtile.cmd_spawn(home + "/.myScripts/show_updates_apt.sh")
                    },
                    #  execute=my_term_extra + " -e 'sudo apt update && sudo apt upgrade && $SHELL'",
                    #  execute=my_term + " -e sudo apt update && sudo apt upgrade && $SHELL",  # for alacritty
                    #  execute=my_term + ' -e "sudo aptitude update && sudo aptitude safe-upgrade && $SHELL"',  # for terminator
                    update_interval=900  # 15min after cron's apt-update task
                    ),
            widget.Sep(
                    linewidth = 1,
                    padding = 10,
                    foreground = colors[2],
                    background = colors[0]
                    ),
            widget.TextBox(
                    #  text="⛅",
                    text="🌡",
                    fontsize=16,
                    foreground=colors[15],
                    background=colors[0],
                    padding=0
                    ),
            widget.OpenWeather(
                    foreground=colors[15],
                    background=colors[0],
                    coordinates={"longitude": "30.9754", "latitude": "52.4345"},
                    format="{location_city}: {temp}°{units_temperature}\n{weather_details}",
                    #  format="{main_temp} °{units_temperature}\n{weather_details}",
                    update_interval=1800,
                    ),
            widget.Sep(
                    linewidth = 1,
                    padding = 10,
                    foreground = colors[2],
                    background = colors[0]
                    ),
            widget.TextBox(
                    text="",
                    #  text=" ",
                    fontsize=16,
                    foreground=colors[7],
                    background=colors[0],
                    padding=0,
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(home + "/.myScripts/top5_cpu_usage.sh"),
                        "Button3": lambda: qtile.cmd_spawn(my_term + " -e htop")
                    }
                    ),
            widget.CPU(
                    foreground=colors[7],
                    background=colors[0],
                    padding=0,
                    format="{freq_current}GHz\n{load_percent}%",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(home + "/.myScripts/top5_cpu_usage.sh"),
                        "Button3": lambda: qtile.cmd_spawn(my_term + " -e htop")
                    }
                    ),
            widget.Sep(
                    linewidth = 1,
                    padding = 10,
                    foreground = colors[2],
                    background = colors[0]
                    ),
            widget.TextBox(
                    text=" ",
                    fontsize=16,
                    foreground=colors[8],
                    background=colors[0],
                    padding=0,
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(home + "/.myScripts/top5_mem_usage.sh"),
                        "Button3": lambda: qtile.cmd_spawn(my_term + " -e htop")
                    }
                    ),
            memory.Memory(
                    foreground=colors[8],
                    background=colors[0],
                    padding=0,
                    format="{MemUsed}M\n{MemPercent}%",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(home + "/.myScripts/top5_mem_usage.sh"),
                        "Button3": lambda: qtile.cmd_spawn(my_term + " -e htop")
                    }
                    ),
            widget.Sep(
                    linewidth = 1,
                    padding = 10,
                    foreground = colors[2],
                    background = colors[0]
                    ),
            widget.Net(
                    interface=upped_netiface,
                    #  format=upped_netiface + ":{down} ↓↑{up}",
                    #  format="{down} ⇓⇑{up}",
                    #  format="{down} ⤋⤊{up}",
                    #  format="{down} ⬇⬆{up}",
                    #  format="{down} 🡇🡅{up}",
                    #  format="{down}  {up}",
                    format="{up}\n{down}",
                    foreground=colors[9],
                    background=colors[0],
                    padding=0
                    ),
            widget.Sep(
                    linewidth = 1,
                    padding = 10,
                    foreground = colors[2],
                    background = colors[0]
                    ),
            widget.KeyboardKbdd(
                    configured_keyboards=["🇺🇸", "🇷🇺"],
                    #  configured_keyboards=["US", "RU"],
                    foreground=colors[11],
                    background=colors[0],
                    fontsize=16,
                    padding=1
                    ),
            widget.Systray(
                    background=colors[0],
                    padding=5
                    ),

            #  widget.BatteryIcon(
                    #  theme_path=home + "/.config/qtile/icons/battery_icons_vert",
                    #  background = colors[0],
                    #  ),
            #  widget.BatteryIcon(
                    #  background=colors[0],
                    #  ),
            #  widget.Battery(
                    #  energy_now_file="charge_now",
                    #  energy_full_file="charge_full",
                    #  power_now_file="current_now",
                    #  format="{char} {percent:2.0%}\n{hour:d}:{min:02d} {watt:.2f}W",
                    #  foreground=colors[5],
                    #  background=colors[0],
                    #  update_interval = 5
                    #  ),

            #  widget.Sep(
                    #  linewidth=0,
                    #  padding=3,
                    #  foreground=colors[0],
                    #  background=colors[0]
                    #  ),
            widget.CurrentLayoutIcon(
                    #  custom_icon_paths=[home + "/.config/qtile/icons/layouts"],
                    foreground=colors[10],
                    background=colors[0],
                    padding=0,
                    scale=0.6,
                    mouse_callbacks={
                        "Button1": qtile.cmd_next_layout,
                        "Button3": qtile.cmd_prev_layout,
                    }
                    ),
            widget.WindowCount(
                    text_format="{num}/",
                    fontsize=14,
                    padding=0,
                    foreground = colors[10],
                    background = colors[0]
                    ),
            all_windows_count.WindowCount(
                    text_format="{num}",
                    fontsize=14,
                    padding=0,
                    foreground = colors[10],
                    background = colors[0]
                    ),
            widget.Sep(
                    linewidth = 1,
                    padding = 10,
                    foreground = colors[2],
                    background = colors[0]
                    ),
            widget.TextBox(
                    text=" ",
                    fontsize=16,
                    foreground=colors[12],
                    background=colors[0],
                    #  fontsize=14,
                    padding=0,
                    mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("gsimplecal")}
                    ),
            widget.Clock(
                    foreground=colors[12],
                    background=colors[0],
                    padding=3,
                    #  mouse_callbacks={"Button1": lambda qtile: qtile.cmd_spawn("gsimplecal")},
                    mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("gsimplecal")},
                    format="%a, %d %b\n%H:%M:%S"
                    ),
            #  widget.Sep(
                    #  linewidth=0,
                    #  padding=3,
                    #  foreground=colors[2],
                    #  background=colors[0]
                    #  )
]
    return widgets_list


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1                       # Slicing removes unwanted widgets on Monitors 1,3


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2                       # Monitor 2 will display all widgets in widgets_list


def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=30)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=30)),
            Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=30))]
# size=23 (was)

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


# TODO lazy.function
@lazy.function
def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)


# TODO lazy.function
@lazy.function
def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)


# TODO lazy.function
@lazy.function
def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)


# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    #  Click([mod], "Button2", lazy.window.bring_to_front())
]

###############################################################################
# New EXAMPLE from qtile 0.17.0 for float_rules[]!!!
#
# rules specified in `layout.Floating`'s `float_rules` are now evaluated with
# AND-semantics instead of OR-semantics, i.e. if you specify 2 different
# property rules, both have to match
#
#  from libqtile.config import Match
#      Match(title=WM_NAME, wm_class=WM_CLASS, role=WM_WINDOW_ROLE)
###############################################################################

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # from libqtile.layout.floating class Floating
    # add (unpack *) default_float_rules
    *layout.Floating.default_float_rules,
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
    ####### My float rules #######
    #  Match(title="Summary", wm_class="synaptic"),
    #  Match(title="Applying Changes", wm_class="synaptic"),
    #  Match(wm_class="Polkit-gnome-authentication-agent-1"),
    #  Match(title="Properties for *", wm_class="dolphin"),
    #  Match(title="Delete Permanently", wm_class="dolphin"),  # Dolphin (delete dialog)
    #  Match(title="Preference"),  # Haroopad (md editor)
    #  Match(title="Close Button Action", wm_class="tixati"),  # Tixati
    Match(title="Terminator Preferences", wm_class="terminator"),
    #  Match(wm_class="com-intellij-updater-Runner"),
    Match(title="win0", wm_class="jetbrains-pycharm-ce"),  # PyCharm
    Match(wm_class="minitube"),
    Match(wm_class="CheckEmail"),
    Match(wm_class="GParted"),
    Match(wm_class="keepass2"),
    Match(wm_class="vlc"),
    Match(wm_class="smplayer"),
    Match(wm_class="deadbeef"),
    Match(wm_class="galculator"),
    #  {"wmclass": "VirtualBox Manager"},
    Match(title="branchdialog"),  # gitk
    Match(title="Open File"),
    Match(title="pinentry"),  # GPG key password entry
    Match(wm_class="gnome-font-viewer"),
    Match(wm_class="fluxgui"),
    Match(wm_class="xfce4-power-manager-settings"),
    Match(wm_class="pavucontrol"),
    Match(wm_class="gdebi-gtk"),
    Match(wm_class="volumeicon"),
    Match(wm_class="gcolor3"),
    Match(wm_class="gvim"),
    Match(wm_class="qt5ct"),
    Match(wm_class="lxappearance"),
    Match(wm_class="confirmreset"),  # gitk
    Match(wm_class="makebranch"),  # gitk
    Match(wm_class="maketag"),  # gitk
    Match(wm_class="ssh-askpass")  # ssh-askpass
], border_focus="#009185")  # #689d6a #98971a #d79921 #fea63c #009185

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


# Autostart!!!
@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + "/.config/qtile/scripts/autostart.sh"])


# Does what I wanted perfectly!!!
#  @hook.subscribe.client_mouse_enter
@hook.subscribe.client_focus
@hook.subscribe.client_new
def focus_new_floating_window(window):
    """ Bring a new floating window to the front. """
    #  subprocess.check_output(["notify-send", "-i", "dialog-information", "{}".format(window.name)])
    if window.floating:
        window.cmd_bring_to_front()


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
            #  window.cmd_bring_to_front()
            #  floating_windows.append(window)
    #  floating_windows[-1].cmd_focus()


#  @hook.subscribe.client_new
#  def floating_dialogs(window):
    #  dialog = window.window.get_wm_type() == "dialog"
    #  transient = window.window.get_wm_transient_for()
    #  if dialog or transient:
        #  window.floating = True


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

