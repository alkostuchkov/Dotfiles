local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local HOME = os.getenv("HOME")
local TERMINAL = os.getenv("TERMINAL") or "xterm"
local SHELL = os.getenv("SHELL") or "/usr/bin/sh"

local sep_widget = {}

local function worker(user_args)
    local args = user_args or {}

    local fg_color = args.fg_color or beautiful.fg_normal
    local bg_color = args.bg_color or beautiful.bg_color or "#00000000"
    local font_name = args.font_name or beautiful.font
    local icon = args.icon or "|"
    local icon_size = args.icon_size or 11
    local font_name_no_size = font_name:gsub("%s%d+$", " ")
    local font_size_icon = font_name_no_size .. icon_size or font_name_no_size .. icon_size

    local sep_widget = wibox.widget {
            {
                id = "txt_icon",
                text = icon,
                font = font_size_icon,
                widget = wibox.widget.textbox,
            },
            valign = "center",
            layout = wibox.layout.align.horizontal,
    }

    -- Set fg and bg colors for sep_widget
    local sep_widget_clr = wibox.widget.background()
    sep_widget_clr:set_widget(sep_widget)
    sep_widget_clr:set_fg(fg_color)

    return sep_widget_clr
end

return setmetatable(sep_widget, { __call = function(_, ...) return worker(...) end })
