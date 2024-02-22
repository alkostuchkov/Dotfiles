local awful = require("awful")
-- local watch = require("awful.widget.watch")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local HOME = os.getenv("HOME")
local TERMINAL = os.getenv("TERMINAL") or "alacritty"
local SHELL = os.getenv("SHELL") or "/usr/bin/fish"

local sep_widget = {}

local function worker(user_args)
    local args = user_args or {}

    local sep_widget = wibox.widget {
            {
                id = "txt_icon",
                -- text = "",
                text = "|",
                font = "Sarasa Mono SC Nerd 17",
                -- font = args.font,
                widget = wibox.widget.textbox,
            },
            valign = "center",
            layout = wibox.layout.align.horizontal,
    }

    -- -- Set fg and bg colors for sep_widget
    -- local sep_widget_clr = wibox.widget.background()
    -- sep_widget_clr:set_widget(sep_widget)
    -- sep_widget_clr:set_fg("#89ddff")
--
    -- return sep_widget_clr
    return sep_widget
end

return setmetatable(sep_widget, { __call = function(_, ...) return worker(...) end })
