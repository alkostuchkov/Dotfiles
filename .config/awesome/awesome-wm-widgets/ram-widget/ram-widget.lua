local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local watch = require("awful.widget.watch")
local wibox = require("wibox")


local ram_widget = {}
local config = {}
local CMD = [[bash -c "ps axch -o cmd:17,%mem --sort=-%mem | head -5"]]

config.timeout = 1
config.popup_bg_color = "#222222"
config.popup_border_width = 1
config.popup_border_color = "#7e7e7e"
config.popup_height = 6
config.popup_width = 300
config.font_ubuntu = "Ubuntu Nerd Font 10"
config.terminal = os.getenv("TERMINAL") or "alacritty"
config.shell = os.getenv("SHELL") or "/usr/bin/fish"

local function worker(user_args)
    local args, _config = user_args or {}, {}
    for prop, value in pairs(config) do
        _config[prop] = args[prop] or beautiful[prop] or value
    end

    ram_widget = wibox.widget {
        { -- the first inner widget in ram_widget
            id = "txt_icon",
            text = "  ",
            font = args.font,
            widget = wibox.widget.textbox,
        },
        valign = "center",
        layout = wibox.layout.align.horizontal,
        -- layout = wibox.container.place,
        { -- the second (contains two widgets) inner widget in ram_widget
            {
                id = "txt_ram_usedg",
                font = _config.font_ubuntu,
                widget = wibox.widget.textbox
            },
            {
                id = "txt_ram_usedp",
                font = _config.font_ubuntu,
                widget = wibox.widget.textbox
            },
            -- spacing = 5,
            layout = wibox.layout.fixed.vertical,
        }
    }

    function ram_widget.set(usedg, usedp)
        ram_widget:get_children_by_id("txt_ram_usedg")[1]:set_text(usedg)
        ram_widget:get_children_by_id("txt_ram_usedp")[1]:set_text(usedp)
    end

    -- Popup scrolling
    local rows, ptr = wibox.layout.fixed.vertical(), 0
    rows:connect_signal("button::press", function(_,_,_,button)
          if button == 4 then
              if ptr > 0 then
                  rows.children[ptr].visible = true
                  ptr = ptr - 1
              end
          elseif button == 5 then
              if ptr < #rows.children and ((#rows.children - ptr) > _config.popup_height) then
                  ptr = ptr + 1
                  rows.children[ptr].visible = false
              end
          end
       end)

    local popup = awful.popup {
        border_width = _config.popup_border_width,
        border_color = _config.popup_border_color,
        shape = gears.shape.rounded_rect,
        visible = false,
        ontop = true,
        offset = { y = 5 },
        widget = {}
    }

    popup:buttons(
        awful.util.table.join(
            awful.button({}, 3, function()
                popup.visible = not popup.visible
            end)
        )
    )

    ram_widget:buttons(
        awful.util.table.join(
            awful.button({}, 1, function()
                if popup.visible then
                    popup.visible = false
                else
                    popup.visible = true
                    popup:move_next_to(mouse.current_widget_geometry)
                    -- popup:move_next_to(_G.mouse.current_widget_geometry)
                end
            end),
            awful.button({}, 3, function()
                awful.spawn(_config.terminal.." -e ".._config.shell.." -c htop")
            end)
        )
    )

    -- Show top 5 processes
    -- awful.spawn.easy_async_with_shell([[bash -c "ps axch -o cmd:17,%mem --sort=-%mem | head -5"]],
    awful.spawn.easy_async_with_shell(CMD,
        function(stdout)
            local top_tbl = {}
            for value in stdout:gmatch("([^\n]+)") do
                top_tbl[#top_tbl+1] = value.." %"
            end

            local popup_header_height, popup_row_height = 30, 20
            local header = wibox.widget {
                {
                    nil,
                    {
                        markup = "<b>  Top of MEMORY usage:</b>",
                        layout = wibox.widget.textbox,
                    },
                    -- {
                        -- upgr_btn,
                        -- valign = "center",
                        -- layout = wibox.container.place,
                    -- },
                    expand = "none",
                    layout = wibox.layout.align.horizontal,
                },
                forced_height = popup_header_height,
                left = 20,
                right = 20,
                layout = wibox.container.margin
            }

            for k, v in ipairs(top_tbl) do
                for i = 1, #rows.children do
                    if v == rows.children[i].get_txt() then goto continue end
                end
                local row = wibox.widget{
                    {
                        id = "idx",
                        text = tostring(k),
                        widget = wibox.widget.textbox
                    },
                    {
                        id = "txt",
                        text = v,
                        forced_height = popup_row_height,
                        paddings = 1,
                        widget = wibox.widget.textbox
                    },
                    layout = wibox.layout.ratio.horizontal,
                }
                function row.get_txt() return row:get_children_by_id("txt")[1].text end
                function row.set_idx(idx) row:get_children_by_id("idx")[1]:set_text(idx) end
                row:ajust_ratio(2, 0.1, 0.9, 0)
                rows:insert(k, row)
                ::continue::
            end

            local height = popup_header_height + math.min(#top_tbl, _config.popup_height) * (popup_row_height + 1) -- +1 corrects popup output!!!
            popup:setup {
                {
                    {
                        {
                            {
                                header,
                                rows,
                                forced_height = height,
                                layout = wibox.layout.fixed.vertical
                            },
                            content_fill_horizontal = true,
                            layout = wibox.container.place
                        },
                        margins = 10,
                        layout = wibox.container.margin
                    },
                    bg = _config.popup_bg_color,
                    -- bg = beautiful.bg_focus,
                    layout = wibox.container.background
                },
                -- forced_width = 300,
                forced_width = _config.popup_width,
                layout = wibox.layout.fixed.horizontal
            }
        end
    )

    --luacheck:ignore 231
    local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap

    local function getPercentage(value)
        return " "..math.floor(value / (total) * 100 + 0.5).."%"
    end

    local function getGiB(value)
        return string.format("%.1fG", value / 1024 / 1024)
    end

    watch('bash -c "LANGUAGE=en_US.UTF-8 free | grep -z Mem.*Swap.*"', _config.timeout,
        function(widget, stdout)
            total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
                stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)')
                widget.set(getGiB(used), getPercentage(used))
        end,
        ram_widget
    )

    -- Set fg and bg colors for ram_widget_icon
    local ram_widget_clr = wibox.widget.background()
    ram_widget_clr:set_widget(ram_widget)
    ram_widget_clr:set_fg("#ffcb6b")

    return ram_widget_clr
end

return setmetatable(ram_widget, { __call = function(_, ...) return worker(...) end })