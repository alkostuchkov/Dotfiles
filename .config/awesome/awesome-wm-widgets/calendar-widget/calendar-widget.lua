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

    local fg_color = args.fg_color or beautiful.fg_normal
    local bg_color = args.bg_color or beautiful.bg_color or "#00000000"
    local popup_bg_color = args.popup_bg_color or beautiful.popup_bg_color or "#222222"
    local popup_border_width = args.popup_border_width or beautiful.popup_border_width or 1
    local popup_border_color = args.popup_border_color or beautiful.popup_border_color or "#7e7e7e"
    local format = args.format or "%a, %d %b\n   %H:%M:%S"
    local refresh = args.refresh or 1
    local font_name = args.font_name or beautiful.font
    local icon = args.icon or " "
    local icon_size = args.icon_size or 11
    local font_name_no_size = font_name:gsub("%s%d+$", " ")
    local font_size_icon = font_name_no_size .. icon_size or font_name_no_size .. icon_size

    local calendar_widget = wibox.widget {
      {
        id = "txt_icon",
        text = icon,
        font = font_size_icon,
        widget = wibox.widget.textbox
      },
      {
        format = format,
        refresh = refresh,
        font = font_name,
        widget = wibox.widget.textclock
      },
      valign = "center",
      layout = wibox.layout.align.horizontal,
    }

    calendar_widget:buttons(
            awful.util.table.join(
                    awful.button({}, 1, function() cal_notify("cal -m "..yr) end)
            )
    )

    local calendar_widget_clr = wibox.widget.background()
    calendar_widget_clr:set_widget(calendar_widget)
    calendar_widget_clr:set_fg(fg_color)

    return calendar_widget_clr
end

return setmetatable(calendar_widget, { __call = function(_, ...) return worker(...) end })
