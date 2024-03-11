-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears") --Utilities such as color parsing and objects
local awful = require("awful") --Everything related to window managment
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
naughty.config.defaults["icon_size"] = 100
naughty.config.defaults["timeout"] = 5
naughty.config.defaults["font"] = "Sarasa Mono SC Nerd 13"
naughty.config.defaults["border_width"] = 1

local menubar = require("menubar")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")

-- {{{ Wibar
-- My widgets
local pacman_widget = require("awesome-wm-widgets/pacman-widget/pacman")
local weather_widget = require("awesome-wm-widgets/weather-widget/weather-widget")
local cpu_widget = require("awesome-wm-widgets/cpu-widget/cpu-widget")
local ram_widget = require("awesome-wm-widgets/ram-widget/ram-widget")
local calendar_widget = require("awesome-wm-widgets/calendar-widget/calendar-widget")
local sep_widget = require("awesome-wm-widgets/sep-widget/sep-widget")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
local TERMINAL = "alacritty"
local EXTRA_TERMINAL = "terminator"
local EDITOR = os.getenv("EDITOR") or "vim"
local EDITOR_CMD = TERMINAL.." -e "..EDITOR
local SHELL = os.getenv("SHELL")
local HOME = os.getenv("HOME")
local AWESOME_CONFIG_DIR = HOME.."/.config/awesome"
-- Themes define colours, icons, font and wallpapers.
local themes = {
    "default",     -- 1
    "gtk",         -- 2
    "mymaterial",  -- 3
    "sky",         -- 4
    "xresources",  -- 5
    "zenburn",     -- 6
    "gruvbox",     -- 7
    "steamburn",   -- 8
    "mira",        -- 9
}
local theme_path = AWESOME_CONFIG_DIR.."/themes/"..themes[3].."/theme.lua"
beautiful.init(theme_path)

-- Default modkey and other keys.
local super = "Mod4"
local alt = "Mod1"
local ctrl = "Control"
local shft = "Shift"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.magnifier,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
local myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", TERMINAL.." -e man awesome" },
   { "edit config", EDITOR_CMD.." "..awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

local mymainmenu = awful.menu(
    { items = {
                  { "awesome", myawesomemenu, beautiful.awesome_icon },
                  { "open terminal", TERMINAL },
              }
    })

-- On the bar
local mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu})

-- Menubar configuration
menubar.utils.terminal = TERMINAL -- Set the terminal for applications that require it
-- }}}

-- Check if I am on my Laptop.
local f = io.open(HOME.."/.mylaptop", "r")
if f ~= nil then
	io.close(f)
	mylaptop = true
end

-- Check if I am on my home computer.
local f = io.open(HOME.."/.mydesktop", "r")
if f ~= nil then
	io.close(f)
	mydesktop = true
end

-- TODO Delete: I don't need battery-status!!!
-- Add battery status if I am using my laptop.
if mylaptop then
  battery_status = awful.widget.watch("battery-status", 60)
end

-- {{{ User functions
-- There is no reason to navigate next or previous in my tag list and have to pass by empty tags in route to the next tag with a client. The following two functions bypass the empty tags when navigating to next or previous.
function view_next_tag_with_client()
    local initial_tag_index = awful.screen.focused().selected_tag.index
    while (true) do
        awful.tag.viewnext()
        local current_tag = awful.screen.focused().selected_tag
        local current_tag_index = current_tag.index
        if #current_tag:clients() > 0 or current_tag_index == initial_tag_index then
            return
        end
    end
end

function view_prev_tag_with_client()
    local initial_tag_index = awful.screen.focused().selected_tag.index
    while (true) do
        awful.tag.viewprev()
        local current_tag = awful.screen.focused().selected_tag
        local current_tag_index = current_tag.index
        if #current_tag:clients() > 0 or current_tag_index == initial_tag_index then
            return
        end
    end
end
-- User functions }}}


-- Create a wibox for each screen and add it
-- Actions for when I click on my taglist buttons
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ super }, 1, function(t)
                              if client.focus then
                                  client.focus:move_to_tag(t)
                                  t:view_only() -- Follow to the client to the chosen tag
                              end
                          end),
    awful.button({ }, 3, awful.tag.viewtoggle)  -- (Un)Fold all clients (Show Desktop)
)

-- Actions for when I click on my tasklist buttons (started apps on the bar)
local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function(c)
                            if c == client.focus then
                                c.minimized = true
                            else
                                c:emit_signal(
                                    "request::activate",
                                    "tasklist",
                                    {raise = true}
                                )
                            end
                         end),
    awful.button({ }, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end))

local function set_wallpaper(s)
    if beautiful.wallpaper then
        -- local wallpaper = beautiful.wallpaper
        local wallpaper = HOME.."/Pictures/Wallpapers/NewWallpapers/0314_1280x1024.jpg"
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        if mylaptop then
          gears.wallpaper.maximized(wallpaper)
        else
          gears.wallpaper.set(gears.surface(wallpaper))
        end
    end
end

-- -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- -- Wallpaper
    -- set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag(
      { "1  ", "2  ", "3  ", "4  ", "5  ", "6  ", "7  ", "8  ", "9  " },
      s,
      { -- for every tag its own layout: { awful.layout.layouts[i], }
        awful.layout.layouts[1], -- tile -> 1
        awful.layout.layouts[1], -- tile -> 2
        awful.layout.layouts[2], -- max  -> 3
        awful.layout.layouts[1], -- tile -> 4
        awful.layout.layouts[1], -- tile -> 5
        awful.layout.layouts[2], -- max  -> 6
        awful.layout.layouts[1], -- tile -> 7
        awful.layout.layouts[2], -- max  -> 8
        awful.layout.layouts[1], -- tile -> 9
      })

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s) -- To switch between layouts 
    s.mylayoutbox:buttons(gears.table.join(   -- by clicking on the layout's icon
        awful.button({ }, 1, function() awful.layout.inc( 1) end),
        awful.button({ }, 3, function() awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox (Bar)
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 32 })

    s.systray = wibox.widget.systray()
    s.systray.set_base_size(25)

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 12,
            -- spacing = 8,
            pacman_widget({
              font_name = "Ubuntu Nerd Font 11",
              icon = "",
              icon_size = 12,
              fg_color = "#e2e0a5",
            }),
            -- sep_widget({
              -- font_name = "Sarasa Mono SC Nerd 17",
              -- icon = "|",
              -- icon_size = 17,
            -- }),
            weather_widget({
              api_key="7834197c2338888258f8cb94ae14ef49",
              coordinates = {52.4345, 30.9754},
              time_format_12h = false,
              units = "metric",
              both_units_widget = false,
              font_name = "Ubuntu Nerd Font",
              icons = "VitalyGorbachev",
              icons_extension = ".svg",
              show_hourly_forecast = true,
              show_daily_forecast = true,
              timeout = 1800,
            }),
            -- sep_widget({
              -- font_name = "Sarasa Mono SC Nerd 17",
              -- icon = "|",
              -- icon_size = 17,
            -- }),
            cpu_widget({
              font_name = "Ubuntu Nerd Font 10",
              icon = "",
              icon_size = 12,
              fg_color = "#89ddff",
            }),
            -- sep_widget({
              -- font_name = "Sarasa Mono SC Nerd 17",
              -- icon = "|",
              -- icon_size = 17,
            -- }),
            ram_widget({
              font_name = "Ubuntu Nerd Font 10",
              icon = " ",
              icon_size = 12,
              fg_color = "#ffcb6b",
            }),
            -- sep_widget({
              -- font_name = "Sarasa Mono SC Nerd 17",
              -- icon = "|",
              -- icon_size = 17,
            -- }),
            wibox.container.margin(s.systray, 0, 0, 3, 0), -- systray in the container
            s.mylayoutbox,
            -- sep_widget({
              -- font_name = "Sarasa Mono SC Nerd 17",
              -- icon = "|",
              -- icon_size = 17,
            -- }),
            calendar_widget({
              font_name = "Ubuntu Nerd Font 10",
              icon = " ",
              icon_size = 12,
              format = "%a, %d %b\n   %H:%M:%S",
              refresh = 1,
              fg_color = "#83eed9",
              popup_bg_color = "#ff0000",
            }),
        },
    }
end)
-- }}}

-- TODO
-- Without this setting, it defaults to 16px icons which stretch to my wibar height of 24px.
-- awesome.set_preferred_icon_size(32)

-- {{{ Mouse bindings
root.buttons(gears.table.join( -- Clicks on the Desktop
    awful.button({ }, 3, function() mymainmenu:toggle() end)
))
-- }}}

-- {{{ Keybindings
globalkeys = gears.table.join(
    -- {{{ Personal keybindings
    -- My dmenu scripts <CTRL + ALT> + KEY
    awful.key({ ctrl, alt }, "c", function() awful.util.spawn(HOME.."/.myScripts/dmscripts/dm-edit-configs.sh") end,
        {description = "edit config files" , group = "dmenu scripts" }),
    awful.key({ ctrl, alt }, "p", function() awful.util.spawn(HOME.."/.myScripts/dmscripts/dm-run-programs.sh") end,
        {description = "run programs" , group = "dmenu scripts" }),
    awful.key({ ctrl, alt }, "s", function() awful.util.spawn(HOME.."/.myScripts/dmscripts/dm-run-scripts.sh") end,
        {description = "run scripts" , group = "dmenu scripts" }),
    awful.key({ ctrl, alt }, "x", function() awful.util.spawn(HOME.."/.myScripts/dmscripts/dm-system-exit.sh") end,
        {description = "system exit" , group = "dmenu scripts" }),

    -- My applications <SUPER + ALT> + KEY
    awful.key({ super, alt }, "r", function() awful.util.spawn("rofi run -show drun -show-icons") end,
        {description = "Rofi", group = "launcher" }),
    awful.key({ super, alt }, "d", function() awful.util.spawn("dmenu_run -i -l 10 -nb '#263238' -nf '#24d2af' -sb '#009185' -p 'Run: ' -fn 'Iosevka-17:normal'") end,
        {description = "Dmenu", group = "launcher" }),
    awful.key({ super, alt }, "Print", function() awful.util.spawn("flameshot gui") end,
        {description = "FlameshotGui", group = "applications" }),
    awful.key({ super, alt }, "w", function() awful.util.spawn("/usr/bin/firefox") end,
        {description = "Firefox", group = "applications" }),
    awful.key({ super, alt }, "u", function() awful.util.spawn("qutebrowser") end,
        {description = "Qutebrowser", group = "applications" }),
    awful.key({ super, alt }, "e", function() awful.util.spawn("dolphin") end,
        {description = "Dolphin", group = "applications" }),
    awful.key({ super, alt }, "n", function() awful.util.spawn("thunar") end,
        {description = "Thunar", group = "applications" }),
    awful.key({ super, alt }, "a", function() awful.util.spawn(TERMINAL.." -e "..SHELL.." -c ranger") end,
        {description = "Ranger", group = "applications" }),
    awful.key({ super, alt }, "v", function() awful.util.spawn(TERMINAL.." -e "..HOME.."/.config/vifm/scripts/vifmrun") end,
        {description = "Vifm", group = "applications" }),
    awful.key({ super, alt }, "t", function() awful.util.spawn(HOME.."/Programs/Telegram/Telegram -workdir "..HOME.."/.local/share/TelegramDesktop/ -- %u") end,
        {description = "Telegram", group = "applications" }),
    awful.key({ super, alt }, "p", function() awful.util.spawn(HOME.."/Programs/PyCharm-Community/bin/pycharm.sh") end,
        {description = "PyCharm", group = "applications" }),
    awful.key({ super, alt }, "c", function() awful.util.spawn("code") end,
        {description = "VSCode", group = "applications" }),
    awful.key({ super, alt }, "g", function() awful.util.spawn("goldendict") end,
        {description = "Goldendict", group = "applications" }),
    awful.key({ super, alt }, "m", function() awful.util.spawn("gvim") end,
        {description = "GVim", group = "applications" }),
    awful.key({ super, alt }, "s", function() awful.util.spawn(HOME.."/Programs/SublimeText/sublime_text") end,
        {description = "Sublime Text", group = "applications" }),
    awful.key({ super, alt }, "b", function() awful.util.spawn("brave") end,
        {description = "Brave", group = "applications" }),
    awful.key({ super, alt }, "Return", function() awful.util.spawn(EXTRA_TERMINAL) end,
        {description = "Extra Terminal", group = "applications" }),
    awful.key({ super, ctrl }, "Return", function() awful.util.spawn("xfce4-terminal") end,
        {description = "xfce4-terminal", group = "applications" }),
    awful.key({ ctrl, shft }, "Escape", function() awful.util.spawn(TERMINAL.." -e "..SHELL.." -c htop") end,
        {description = "htop", group = "applications" }),

    -- My applications as Root <SUPER + SHIFT + ALT> + KEY
    awful.key({ super, shft, alt }, "v", function() awful.util.spawn(HOME.."/.myScripts/runVifmAsRoot.sh") end,
        {description = "Vifm as Root", group = "applications" }),
    awful.key({ super, shft, alt }, "a", function() awful.util.spawn(HOME.."/.myScripts/runRangerAsRoot.sh") end,
        {description = "Ranger as Root", group = "applications" }),
    awful.key({ super, shft, alt }, "n", function() awful.util.spawn(HOME.."/.myScripts/runThunarAsRoot.sh") end,
        {description = "Thunar as Root", group = "applications" }),
    -- Personal keybindings }}}

    -- Hotkeys Awesome
    awful.key({ super }, "s", hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    -- Show MainMenu
    awful.key({ super }, "w", function() mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Show/Hide Wibox
    awful.key({ super }, "b", function()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome"}),

    -- Tag browsing with <SUPER>
    awful.key({ super }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ super }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ super }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- Non-empty tag browsing
    awful.key({ super, alt }, "Right", function() view_next_tag_with_client()end,
              {description = "view  previous nonempty", group = "tag"}),
    awful.key({ super, alt }, "Left", function() view_prev_tag_with_client() end,
              {description = "view  previous nonempty", group = "tag"}),

    -- Default client focus
    awful.key({ alt }, "j", function() awful.client.focus.byidx( 1) end,
              {description = "focus next by index", group = "client"}),
    awful.key({ alt }, "k", function() awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}),

    -- By direction client focus
    awful.key({ super }, "j", function() awful.client.focus.global_bydirection("down")
                                if client.focus then client.focus:raise() end
                              end,
              {description = "focus down", group = "client"}),
    awful.key({ super }, "k", function() awful.client.focus.global_bydirection("up")
                                if client.focus then client.focus:raise() end
                              end,
              {description = "focus up", group = "client"}),
    awful.key({ super }, "h", function() awful.client.focus.global_bydirection("left")
                                if client.focus then client.focus:raise() end
                              end,
              {description = "focus left", group = "client"}),
    awful.key({ super }, "l", function() awful.client.focus.global_bydirection("right")
                                if client.focus then client.focus:raise() end
                              end,
              {description = "focus right", group = "client"}),

    -- Layout manipulation
    awful.key({ super, shft }, "j", function() awful.client.swap.byidx(  1) end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ super, shft }, "k", function() awful.client.swap.byidx( -1) end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ super       }, ".", function() awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ super       }, ",", function() awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ super       }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ alt         }, "Tab", function() awful.client.focus.history.previous()
                                        if client.focus then client.focus:raise() end
                                      end,
              {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ super       }, "Return", function() awful.spawn(TERMINAL) end,
              {description = "open a terminal", group = "applications"}),
    awful.key({ super, shft }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ super, shft }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    -- Increase/Decrease master
    awful.key({ super, ctrl   }, "k", function() awful.client.incwfact( 0.05) end,
              {description = "increase master height factor", group = "layout"}),
    awful.key({ super, ctrl   }, "j", function() awful.client.incwfact(-0.05) end,
              {description = "decrease master height factor", group = "layout"}),
    awful.key({ super, ctrl   }, "l", function() awful.tag.incmwfact( 0.05) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ super, ctrl   }, "h", function() awful.tag.incmwfact(-0.05) end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ alt, shft }, "h", function() awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ alt, shft }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ ctrl, alt }, "h", function() awful.tag.incncol( 1, nil, true) end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ ctrl, alt }, "l", function() awful.tag.incncol(-1, nil, true) end,
              {description = "decrease the number of columns", group = "layout"}),

    -- Swap clients
    awful.key({ super, shft }, "h", function() awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ super, shft }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    -- Switch between layouts
    awful.key({ super       }, "Tab", function() awful.layout.inc( 1) end,
              {description = "select next", group = "layout"}),
    awful.key({ super, shft }, "Tab", function() awful.layout.inc(-1) end,
              {description = "select previous", group = "layout"}),

    awful.key({ super, ctrl }, "n",
              function()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- <SUPER> + <F1-F12>
    -- Brightness
    awful.key({ }, "XF86MonBrightnessUp", function() os.execute("xbacklight -inc 10") end,
              {description = "+10%", group = "hotkeys"}),
    awful.key({ }, "XF86MonBrightnessDown", function() os.execute("xbacklight -dec 10") end,
              {description = "-10%", group = "hotkeys"}),

    -- ALSA volume control
    awful.key({ super }, "F9", function() awful.spawn(HOME.."/.myScripts/volume_up.sh") end,
              {description = "Volume Up", group = "hotkeys"}),
    awful.key({ super }, "F8", function() awful.spawn(HOME.."/.myScripts/volume_down.sh") end,
              {description = "Volume Down", group = "hotkeys"}),
    awful.key({ super }, "F7", function() awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle") end,
              {description = "Volume Mute", group = "hotkeys"}),
    -- XF86AudioRaiseVolume
    -- XF86AudioLowerVolume
    -- XF86AudioMute

    -- <ALT> + <F1-F12>
    awful.key({ alt }, "F4", function() awful.spawn(HOME.."/Programs/ByeBye/ByeBye") end,
              {description = "System Exit Menu", group = "applications"}),

    -- Default
    -- Menubar
    awful.key({ super }, "p", function() menubar.show() end,
    {description = "show the menubar", group = "awesome"}),

    -- Prompt
    -- awful.key({ super }, "r", function() awful.screen.focused().mypromptbox:run() end,
              -- {description = "Run prompt", group = "launcher"}),

    awful.key({ super }, "x",
              function()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir().."/history_eval"
                  }
              end,
              {description = "Lua execute prompt", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ super,      }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ super,      }, "t",
        function(c)
            for _, c in ipairs(client.get()) do
              awful.titlebar.toggle(c)
            end
        end,
           {description = "Show/Hide Titlebars for All clients", group="client"}),
    awful.key({ super, shft }, "t", function (c) awful.titlebar.toggle(c) end,
              {description = "Show/Hide Titlebars for the current client", group="client"}),
    awful.key({ super, shft }, "x", function(c) awful.spawn("xkill") end,
              {description = "kill", group = "client"}),
    awful.key({ super, shft }, "c", function(c) c:kill() end,
              {description = "close", group = "client"}),
    awful.key({ super, shft }, "f",  awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),
    awful.key({ super, ctrl }, "Return", function(c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    -- awful.key({ super,           }, "o",      function(c) c:move_to_screen()               end,
              -- {description = "move to screen", group = "client"}),
    awful.key({ alt         }, "t", function(c) c.ontop = not c.ontop end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ alt         }, "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {description = "minimize", group = "client"}),
    awful.key({ super      }, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}),
    -- (Un)Maximize vertical and horizontal
    awful.key({ super, shft }, "m",
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ super, ctrl }, "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        {description = "(un)maximize horizontally", group = "client"}),
    -- Move floating client
    awful.key({ ctrl, super }, "Up",
        function (c)
            if c.floating then
              c:relative_move(0, -10, 0, 0)
            end
        end,
        {description = "move floating client up", group = "client"}),
    awful.key({ ctrl, super }, "Down",
        function (c)
            if c.floating then
              c:relative_move(0, 10, 0, 0)
            end
        end,
        {description = "move floating client down", group = "client"}),
    awful.key({ ctrl, super }, "Left",
        function (c)
            if c.floating then
              c:relative_move(-10, 0, 0, 0)
            end
        end,
        {description = "move floating client left", group = "client"}),
    awful.key({ ctrl, super }, "Right",
        function (c)
            if c.floating then
              c:relative_move(10, 0, 0, 0)
            end
        end,
        {description = "move floating client right", group = "client"}),
    -- Resize floating client
    awful.key({ shft, super }, "Up",
        function (c)
            if c.floating then
              c:relative_move(0, 0, 0, -10)
            end
        end,
        {description = "resize floating client up", group = "client"}),
    awful.key({ shft, super }, "Down",
        function (c)
            if c.floating then
              c:relative_move(0, 0, 0, 10)
            end
        end,
        {description = "resize floating client down", group = "client"}),
    awful.key({ shft, super }, "Left",
        function (c)
            if c.floating then
              c:relative_move(0, 0, -10, 0)
            end
        end,
        {description = "resize floating client left", group = "client"}),
    awful.key({ shft, super }, "Right",
        function (c)
            if c.floating then
              c:relative_move(0, 0, 10, 0)
            end
        end,
        {description = "resize floating client right", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ super }, "#"..i + 9,
                  function()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display (Show Desktop).
        awful.key({ super, ctrl }, "#"..i + 9,
                  function()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #"..i, group = "tag"}),
        -- Move client to tag.
        awful.key({ super, shft }, "#"..i + 9,
                  function()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                              tag:view_only() -- Follow to the client to the chosen tag
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"})
                  -- TODO: delete this toggle???
        -- -- Toggle tag on focused client.
--      ,   awful.key({ super, ctrl, shft }, "#"..i + 9,
                  -- function()
                      -- if client.focus then
                          -- local tag = client.focus.screen.tags[i]
                          -- if tag then
                              -- client.focus:toggle_tag(tag)
                          -- end
                      -- end
                  -- end,
                  -- {description = "toggle focused client on tag #"..i, group = "tag"})
    )
end

clientbuttons = gears.table.join(-- Button clicks on client
    awful.button({ }, 1, function(c) -- Activate client
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ super }, 1, function(c) -- Move client
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ super }, 3, function(c) -- Resize client
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = clientkeys,
        buttons = clientbuttons,
        titlebars_enabled = false,
        screen = awful.screen.preferred,
        size_hints_honor = false,
        --  placement = awful.placement.no_overlap+awful.placement.no_offscreen,
        placement = awful.placement.centered+awful.placement.no_offscreen,
      }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "BreakTimer",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Deadbeef",
          "Galculator",
          "kcalc",
          "gnome-font-viewer",
          "xfce4-power-manager-settings",
          "Pavucontrol",
          "gdebi-gtk",
          "Gcolor3",
          "qt6ct",
          "Volumeicon",
          "Lxappearance"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
          "About Mozilla Firefox",
          "О Mozilla Firefox",
          "Terminator Preferences",
          "Терминатор Параметры",
          "Сетевые соединения",
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
          "Preferences",
          "setup",
        },
        type = { "dialog" },
      }, properties = { floating = true, border_width = 1 } },

    -- Set applications to always map on the sertain tag
    { rule_any = { class = {"dolphin", "Thunar"} },
      properties = { screen = 1, tag = root.tags()[3] } },

    { rule = { class = "VirtualBox Manager" },
      properties = { screen = 1, tag = root.tags()[5] } },

    { rule_any = { class = {"TelegramDesktop", "ViberPC"} },
      properties = { screen = 1, tag = root.tags()[6] } },

    { rule = { class = "Gimp" },
      properties = { screen = 1, tag = root.tags()[7] } },

    { rule = { class = "thunderbird" },
      except = { name = "Password Required - Mozilla Thunderbird" },
      properties = { screen = 1, tag = root.tags()[9], switch_to_tags = false } },

    -- -- Titlebars
    -- -- Add titlebars to normal clients and dialogs
    -- { rule_any = {type = { "normal", "dialog" }
    --   }, properties = { titlebars_enabled = false }
    -- },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Focus urgent clients automatically
-- When I launch a client at a particular place, I want to go to that client.
client.connect_signal("property::urgent", function(c)
	c.minimized = false
	c:jump_to()
end)

-- Makes all floating clients border_width = 1
client.connect_signal("property::floating", function(c)
    -- if c.floating then
    --     c.border_width = 1
    -- else
    --     c.border_width = beautiful.border_width
    -- end

    -- The same as above but a little bit shorter!
    c.border_width = c.floating and 1 or beautiful.border_width
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Autostart
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
      os.execute(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s &)", cmd, cmd))
        -- awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s &)", cmd, cmd))
    end
end

run_once({
    "xxkb",
    "setxkbmap -layout us,ru -option grp:caps_toggle",
    "/usr/lib/xfce4/notifyd/xfce4-notifyd",
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
    "xrdb "..HOME.."/.Xresources",
    "nitrogen --restore",
    "volumeicon",
    "nm-applet",
    "xfce4-power-manager",
    "clipit",
    -- "diodon",
    -- "xfce4-clipman",
    "picom --config "..HOME.."/.config/picom/picom.conf",
    "conky -c "..HOME.."/.myScripts/conky/conkyrc",
    "/usr/bin/python /usr/bin/udiskie",
    "xiccd",
    "python /usr/bin/redshift-gtk",
    -- "/usr/bin/python /usr/bin/fluxgui",
    HOME.."/Programs/CheckInternetConnection/CheckInternetConnection",
    HOME.."/Programs/AppImageApplications/BreakTimer.AppImage",
    -- HOME.."/Programs/CheckEmail/CheckEmail",
    "birdtray",
    "xmodmap -e \"keycode 135 = Super_R\"",
}) -- entries must be comma-separated

