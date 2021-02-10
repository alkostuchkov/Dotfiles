# -*- coding: utf-8 -*-

import os
import re
import socket
import subprocess
from typing import List  # noqa: F401
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Screen, KeyChord
from libqtile.lazy import lazy


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
    else:
        return None


mod = "mod4"
alt = "mod1"
my_term = "terminator"
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

keys = [
# <SUPER> + FUNCTION KEYS
    Key([mod], "Return", lazy.spawn(my_term), desc="Launch terminal"),
    Key([mod], "Print", lazy.spawn("flameshot gui"), desc="Run flameshot (take screenshot)"),
    Key([mod], "w", lazy.spawn("firefox"), desc="Launch Browser"),
    Key([mod], "e", lazy.spawn("dolphin"), desc="Launch File Manager"),
    Key([mod], "i", lazy.spawn("synaptic-pkexec"), desc="Launch Synaptic"),
    Key([mod], "g", lazy.spawn(home + "/.myScripts/runGimpDiscreteGr.sh"), desc="Run GIMP DiscreteGraphics"),
    Key([mod], "b", lazy.spawn(home + "/Programs/SublimeText/sublime_text"), desc="Run Sublime Text"),
    Key([mod], "p", lazy.spawn(home + "/Programs/PyCharm-Community/bin/pycharm.sh"), desc="Run PyCharm"),
    Key([mod], "t", lazy.spawn(home + "/Programs/Telegram/Telegram -workdir /home/alexander/.local/share/TelegramDesktop/ -- %u"), desc="Run Telegram"),
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
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up in stack pane"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down in stack pane"),
    Key([mod], "Left", lazy.layout.left(), desc="Move focus left in stack pane"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus right in stack pane"),
    Key([mod], "space", lazy.layout.next(), desc="Switch window focus to other pane(s) of stack"),
    # QTILE LAYOUT KEYS
    Key([mod], "n", lazy.layout.normalize(), desc="Normalize window size ratios"),
    Key([mod], "m", lazy.layout.maximize(), desc="Toggle window between minimum and maximum sizes"),
    Key([mod], "d", lazy.window.toggle_minimize(), desc="Toggle window between minimumize and normal sizes"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),

# <SUPER> + <SHIFT> + KEYS  (-nf #fea63c)
    Key([mod, "shift"], "d", lazy.spawn("dmenu_run -nb #222B2E -nf #09DBC9 -p 'Run: ' -fn 'Ubuntu-R 12'"), desc="Run dmenu"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "x", lazy.spawn("xkill"), desc="Kill not answered window"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    # TOGGLE FLOATING LAYOUT
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    # MOVE WINDOWS UP OR DOWN IN CURRENT STACK
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up in current stack "),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down in current stack "),
    Key([mod, "shift"], "h", lazy.layout.swap_left(), desc="Move window left in current stack "),
    Key([mod, "shift"], "l", lazy.layout.swap_right(), desc="Move window right in current stack "),

    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up in current stack "),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down in current stack "),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window left in current stack "),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window right in current stack "),
    # FLIP LAYOUT FOR MONADTALL/WIDE
    Key([mod, "shift"], "space", lazy.layout.flip(), desc="Flip main (left) panel with others"),

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
    Key([alt], "r", lazy.spawn("rofi run -show drun -show-icons"), desc="Run App Lancher"),
    Key([alt], "w", lazy.spawn("rofi run -show window -show-icons"), desc="Switch between opened windows"),
    Key([alt], "c", lazy.spawn(home + "/.myScripts/dmenu/dmenu-edit-configs.sh"), desc="Run dmenu script for editing config files"),
    Key([alt], "s", lazy.spawn(home + "/.myScripts/dmenu/dmenu-system-exit.sh"), desc="System exit menu"),
    Key([alt], "l", lazy.spawn(home + "/.myScripts/system_exit/lock.sh"), desc="Lock screen"),

# <CONTROL> + <ALT> + KEYS
# <CONTROL> + <SHIFT> + KEYS
# <ALT> + <SHIFT> + KEYS

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

#       v                   
#        🌐♬ 🌡 🖬  ⟳ ₿   ⮋⮉🡇 🡅 ⇓⇑        
group_names = [(" ", {"layout": "monadtall"}),  # WWW
               (" ", {"layout": "monadtall"}),  # DEV
               (" ", {"layout": "max"}),        # FM
               (" ", {"layout": "monadtall"}),  # SYS
               (" ", {"layout": "monadtall"}),  # VIRT
               (" ", {"layout": "monadtall"}),  # CHAT
               (" ", {"layout": "monadtall"}),  # GFX
               (" ", {"layout": "max"}),        # VID
               (" ", {"layout": "monadwide"})]  # MULT

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
                #  "border_focus": "e1acff",
                "border_focus": "2eb398",
                "border_normal": "1d2330"
                }

layouts = [
    # layout.Bsp(**layout_theme),
    #layout.Columns(**layout_theme),
    #layout.RatioTile(**layout_theme),
    #layout.VerticalTile(**layout_theme),
    #layout.Matrix(**layout_theme),
    #layout.Zoomy(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Max(**layout_theme),
    # layout.Tile(shift_windows=True, **layout_theme),
    # layout.Stack(num_stacks=2),
    layout.Stack(stacks=2, **layout_theme),
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
    layout.Floating(**layout_theme)
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
colors = [["#222B2E", "#222B2E"], # 0 panel background
          ["#585E72", "#585E72"], # 1 background for current screen tab
          ["#DBDCD5", "#DBDCD5"], # 2 font color for group names
          ["#009185", "#009185"], # 3 border line color for current tab
          ["#8d62a9", "#8d62a9"], # 4 border line color for other tab and odd widgets
          ["#668bd7", "#668bd7"], # 5 color for the even widgets
          ["#24D2AF", "#24D2AF"], # 6 window name
          ["#E2A0A5", "#E2A0A5"], # 7 CPU widget
          ["#F2B06A", "#F2B06A"], # 8 Memory widget
          ["#03DB25", "#03DB25"], # 9 NetSpeed widget
          ["#ffffff", "#ffffff"], # 10 Layout widget
          ["#55EBEA", "#55EBEA"], # 11 KeyboardLayout widget
          ["#F3F008", "#F3F008"], # 12 Date widget
          ["#404555", "#404555"], # 13 system tray
          ["#F6F806", "#F6F806"]] # 14 updates

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font=my_font,
    fontsize=14,
    padding=2,
    background=colors[2]
)
extension_defaults = widget_defaults.copy()


def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
            widget.Sep(
                    linewidth=0,
                    padding=3,
                    foreground=colors[2],
                    background=colors[0]
                    ),
            widget.Image(
                    filename="~/.config/qtile/icons/debian_logo_green_brighter+.png",
                    mouse_callbacks={"Button1": lambda qtile: qtile.cmd_spawn("rofi run -show drun -show-icons")}
                    ),
            widget.Sep(
                    linewidth=0,
                    padding=3,
                    foreground=colors[2],
                    background=colors[0]
                    ),
            widget.GroupBox(
                    font=my_nerd_font,
                    #  fontsize=14,
                    margin_y=3,
                    margin_x=0,
                    padding_y=5,
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
            #  widget.Sep(
                    #  linewidth=1,
                    #  padding=0,
                    #  #  padding=40,
                    #  foreground=colors[2],
                    #  background=colors[0]
                    #  ),
            widget.WindowName(
                    #  font=my_mono_bold_font,
                    #  fontsize=16,
                    font=my_font,
                    #  fontsize=14,
                    show_state=False,
                    #  show_state=True,
                    foreground=colors[6],
                    background=colors[0],
                    padding=0
                    ),
            widget.CheckUpdates(
                    foreground=colors[14],
                    background=colors[0],
                    colour_have_updates=colors[14],
                    colour_no_updates="ffffff",
                    custom_command="apt-show-versions --upgradeable",
                    #  custom_command="apt-show-versions | grep upgradeable | wc -l",
                    display_format=" {updates} ",  # ⟳ 
                    no_update_string="No updates",
                    execute=my_term + " -e 'sudo aptitude update && sudo aptitude safe-upgrade'",
                    update_interval=900  # 15min after cron's apt-update task
                    ),
            widget.TextBox(
                    text=" ",
                    #  text=" ",
                    foreground=colors[7],
                    background=colors[0],
                    padding=0
                    ),
            widget.CPU(
                    foreground=colors[7],
                    background=colors[0],
                    format="{freq_current}GHz {load_percent}%",
                    mouse_callbacks={"Button1": lambda qtile: qtile.cmd_spawn(my_term + " -e htop")},
                    padding=0
                    ),
            widget.TextBox(
                    text="   ",
                    foreground=colors[8],
                    background=colors[0],
                    padding=0
                    ),
            widget.Memory(
                    foreground=colors[8],
                    background=colors[0],
                    format="{MemUsed}M",
                    mouse_callbacks={"Button1": lambda qtile: qtile.cmd_spawn(my_term + " -e htop")},
                    padding=0
                    ),
            widget.Net(
                    interface=upped_netiface,
                    #  format="{down} ⇓⇑{up}",
                    #  format="{down} ⤋⤊{up}",
                    #  format="{down} ⬇⬆{up}",
                    format="{down}  {up}",
                    #  format="{down} 🡇🡅{up}",
                    #  format=upped_netiface + ":{down} ↓↑{up}",
                    foreground=colors[9],
                    background=colors[0],
                    padding=3
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
            widget.BatteryIcon(
                    background=colors[0],
                    ),
            widget.Sep(
                    linewidth=0,
                    padding=3,
                    foreground=colors[0],
                    background=colors[0]
                    ),
            widget.CurrentLayoutIcon(
                    custom_icon_paths=[home + "/.config/qtile/icons"],
                    foreground=colors[10],
                    background=colors[0],
                    padding=0,
                    scale=0.7
                    ),
            #  widget.CurrentLayout(
                    #  foreground=colors[10],
                    #  background=colors[0],
                    #  padding=5
                    #  ),
            widget.TextBox(
                    text=" ",
                    foreground=colors[12],
                    background=colors[0],
                    #  fontsize=14,
                    padding=0
                    ),
            widget.Clock(
                    foreground=colors[12],
                    background=colors[0],
                    padding=3,
                    mouse_callbacks={"Button1": lambda qtile: qtile.cmd_spawn("gsimplecal")},
                    format="%a, %d %b %H:%M:%S"
                    )
]
    return widgets_list


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1                       # Slicing removes unwanted widgets on Monitors 1,3


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2                       # Monitor 2 will display all widgets in widgets_list


def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=23)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=23)),
            Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=23))]


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


def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)


def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)


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
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
#  bring_front_click = "floating_only"
#  cursor_warp = True
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {"wname": "Close Button Action"},  # Tixati
    {"wmclass": "com-intellij-updater-Runner"},
    {"wmclass": "minitube"},
    {"wmclass": "CheckEmail"},
    {"wmclass": "GParted"},
    {"wmclass": "keepass2"},
    {"wmclass": "vlc"},
    {"wmclass": "smplayer"},
    {"wmclass": "deadbeef"},
    {"wmclass": "galculator"},
    #  {"wmclass": "VirtualBox Manager"},
    {"wname": "win0"},  # PyCharm
    {"wmclass": "gnome-font-viewer"},
    {"wmclass": "fluxgui"},
    {"wmclass": "xfce4-power-manager-settings"},
    {"wmclass": "pavucontrol"},
    {"wmclass": "gdebi-gtk"},
    {"wmclass": "volumeicon"},
    {"wmclass": "gcolor3"},
    {"wmclass": "gvim"},
    {"wmclass": "qt5ct"},
    {"wmclass": "lxappearance"},
    {"wmclass": "confirm"},
    {"wmclass": "dialog"},
    {"wmclass": "download"},
    {"wmclass": "error"},
    {"wmclass": "file_progress"},
    {"wmclass": "notification"},
    {"wmclass": "splash"},
    {"wmclass": "toolbar"},
    {"wmclass": "confirmreset"},  # gitk
    {"wmclass": "makebranch"},  # gitk
    {"wmclass": "maketag"},  # gitk
    {"wname": "branchdialog"},  # gitk
    {"wname": "pinentry"},  # GPG key password entry
    {"wmclass": "ssh-askpass"},  # ssh-askpass
])
auto_fullscreen = True
#  focus_on_window_activation = "focus"
#  focus_on_window_activation = "urgent"
focus_on_window_activation = "smart"


# Autostart!!!
@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + "/.config/qtile/autostart.sh"])


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

