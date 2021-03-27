'''i3pystatus config

'''
from i3pystatus import Status
from i3pystatus.updates import aptget
from i3pystatus.weather import weathercom
from i3pystatus import get_module
import os

# Colors:
# Materia Manjaro
colors = {
    "background": "#263238",
    "foreground": "#dbdcd5",
    "alert": "#cc241d",
    "current_screen_tab": "#585E72",
    "group_names": "#dbdcd5",
    "line_color_curr_tab": "#009185",
    "line_color_other_tab": "#8d62a9",
    "even_widgets": "#6182b8",
    "window_name": "#24d2af",
    "cpu": "#e2a0a5",
    "memory": "#ffb62c",
    "net_speed_up": "#24d2af",
    "net_speed_down": "#91b859",
    "layout_widget": "#ffffff",
    "keyboard": "#6182b8",
    "date_time": "#39adb5",
    "date_time2": "#f2b06a",
    "sys_tray": "#404555",
    "updates": "#ffcb6b",
    "updates2": "#e2e0a5",
    "weather": "#eb7bef",
    "weather2": "#ec30f3",
    "weather3": "#e2e0a5",
    "chord": "#d79921"
}

my_term = "alacritty"
my_term_extra = "terminator"
home = os.path.expanduser("~")


status = Status(
    standalone=True, 
    logfile="$HOME/.config/i3pystatus/i3pystatus.log"
)  # pylint: disable=invalid-name

status.register(
    "my_xkblayout",
    #  color=colors["keyboard"],
    #  color=colors["updates2"],
    #  "🇺🇸", "🇷🇺"],
    layouts=["us", "ru"],
    #  format="    {symbol}",
    format="{flag}",
)

status.register(
    "clock",
    #  color="#888888",
    color=colors["date_time"],
    #  format=('%a, %d %b <span color="#0099ff">%H:%M:%S</span> Gomel', 'Europe/Minsk'),
    format=("  %a,%d %b %H:%M:%S", "Europe/Minsk"),
    on_leftclick="gsimplecal",
    hints={"markup": "pango"})

#  # Note: the network module requires PyPI package netifaces
status.register(
    "network",
    dynamic_color=False,
    color_up=colors["net_speed_down"],
    interface="wlo1",
    format_up=" {bytes_recv}KB/s  {bytes_sent}KB/s",
    hints={"markup": "pango"}
)

#  # Note: requires both netifaces and basiciw (for essid and quality)
#  status.register(
    #  "network",
    #  interface="wlo1",
    #  format_up=" {essid} ▪ {quality:.1f}% ▪ {v4}",
    #  format_down="")

status.register(
    "my_mem",
    color=colors["memory"],
    divisor=1024**3,
    format="  {used_mem}GiB ({percent_used_mem}%)",
    interval=1,
    on_rightclick=my_term + " -e htop",
    on_leftclick=home + "/.myScripts/top5_mem_usage.sh"
)

status.register(
    "cpu_usage",
    color=colors["cpu"],
    format=" {usage:02}%",
    interval=1,
    on_rightclick=my_term + " -e htop",
    on_leftclick=home + "/.myScripts/top5_cpu_usage.sh"
)

#  status.register(
    #  "weather",
    #  format="{condition} {current_temp}{temp_unit}[ {icon}][ Hi: {high_temp}][ Lo: {low_temp}][ {update_error}]",
    #  #  format="{city}",
    #  interval=900,
    #  colorize=True,
    #  hints={"markup": "pango"},
    #  backend=weathercom.Weathercom(
        #  location_code="8493ac1c3a23de4a15e24bd8fee7a078ae89435c6079fb9b81c1d004f5a9263a",
        #  units="imperial",
        #  #  units="metric",
        #  update_error="<span color='#ff0000'>!</span>",
    #  )
#  )

status.register(
    "updates",
    color=colors["updates"],
    format="   {count}",
    #  format_working="🔃",
    format_working="⟳ ",
    backends=[aptget.AptGet()],
    interval=900,
    on_middleclick=my_term_extra + " -e 'sudo apt update && sudo apt upgrade && $SHELL'"
)

status.register(
    "window_title",
    color=colors["window_name"],
    format="{class_name} - {title}",
    hints={"markup": "pango", "separator": True},
    max_width=40
)

#  status.register(
    #  "keyboard_locks",
    #  caps_on='<span bgcolor="yellow" color="black">CAPS</span>',
    #  caps_off='',
    #  num_on='<span bgcolor="green" color="black">NUM</span>',
    #  num_off='',
    #  scroll_on='<span bgcolor="blue" color="black">SCR</span>',
    #  scroll_off='',
    #  color="#888888",
    #  hints={"markup": "pango"})

#  status.register(
    #  "pulseaudio",
    #  format=" {volume}% ({db} dB)",
    #  format_muted=" MUTE")

status.run()
 

