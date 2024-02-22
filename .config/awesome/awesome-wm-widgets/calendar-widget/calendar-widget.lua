local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")
local beautiful = require("beautiful")

local calendar_widget = {}
local yr = os.date("%Y")

-- Popup calendar, source adapted from: https://pavelmakhov.com/2017/03/calendar-widget-for-awesome
local function cal_notify(cal_pref, pref_screen)
  if cal_notification == nil then
    awful.spawn.easy_async([[bash -c "]]..cal_pref..[[ | sed 's/_.\(.\)/+\1-/g;s/$//g;/]]..yr..[[$/d'"]],
    function(stdout, stderr, reason, exit_code)
      cal_notification = naughty.notify {
        text = string.gsub(string.gsub(stdout, "+", "<span background='#85492e'>"), "-", "</span>"),
        timeout = 0,
        margin = 20,
        screen = pref_screen,
        width = auto,
        destroy = function() cal_notification = nil end
      }
    end)
  else
    naughty.destroy(cal_notification)
    -- naughty.destroy_all_notifications()
  end
end

local function worker(user_args)
    local args = user_args or {}

    local calendar_widget = wibox.widget {
      {
        id = "txt_icon",
        text = " " ,
        font = "Ubuntu Nerd Font 12",
        widget = wibox.widget.textbox
      },
      {
        format = "%a, %d %b\n  %H:%M:%S",
        refresh = 1,
        font = "Ubuntu Nerd Font 10",
        widget = wibox.widget.textclock
      },
      valign = "center",
      layout = wibox.layout.align.horizontal,
    }

    calendar_widget:buttons(
            awful.util.table.join(
                    awful.button({}, 1, function() cal_notify("cal "..yr) end)
            )
    )

    local calendar_widget_clr = wibox.widget.background()
    calendar_widget_clr:set_widget(calendar_widget)
    calendar_widget_clr:set_fg("#83eed9")

    return calendar_widget_clr
end

return setmetatable(calendar_widget, { __call = function(_, ...) return worker(...) end })
