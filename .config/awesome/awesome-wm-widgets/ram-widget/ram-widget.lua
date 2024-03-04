local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local watch = require("awful.widget.watch")
local wibox = require("wibox")


local ram_widget = {}
local CMD = [[bash -c "ps axch -o cmd:17,%mem --sort=-%mem | head -5"]]

local function worker(user_args)
    local args = user_args or {}

    local TERMINAL = os.getenv("TERMINAL") or "xterm"
    local SHELL = os.getenv("SHELL") or "/usr/bin/sh"
    local timeout = args.timeout or 1
    local fg_color = args.fg_color or beautiful.fg_normal
    local bg_color = args.bg_color or beautiful.bg_color or "#00000000"
    local popup_bg_color = args.popup_bg_color or beautiful.popup_bg_color or "#222222"
    local popup_border_width = args.popup_border_width or beautiful.popup_border_width or 1
    local popup_border_color = args.popup_border_color or beautiful.popup_border_color or "#7e7e7e"
    local popup_height = args.popup_height or beautiful.popup_height or 6
    local popup_width = args.popup_width or beautiful.popup_width or 300
    local font_name = args.font_name or beautiful.font
    local icon = args.icon or " "
    local icon_size = args.icon_size or 11
    local font_name_no_size = font_name:gsub("%s%d+$", " ")
    local font_size_icon = font_name_no_size .. icon_size or font_name_no_size .. icon_size

    ram_widget = wibox.widget {
        { -- the first inner widget in ram_widget
            id = "txt_icon",
            text = icon,
            font = font_size_icon,
            widget = wibox.widget.textbox,
        },
        valign = "center",
        layout = wibox.layout.align.horizontal,
        -- layout = wibox.container.place,
        { -- the second (contains two widgets) inner widget in ram_widget
            {
                id = "txt_ram_usedg",
                font = font_name,
                widget = wibox.widget.textbox
            },
            {
                id = "txt_ram_usedp",
                font = font_name,
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
              if ptr < #rows.children and ((#rows.children - ptr) > popup_height) then
                  ptr = ptr + 1
                  rows.children[ptr].visible = false
              end
          end
       end)

    local popup = awful.popup {
        border_width = popup_border_width,
        border_color = popup_border_color,
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
                awful.spawn(TERMINAL.." -e "..SHELL.." -c htop")
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

            local height = popup_header_height + math.min(#top_tbl, popup_height) * (popup_row_height + 1) -- +1 corrects popup output!!!
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
                    bg = popup_bg_color,
                    -- bg = beautiful.bg_focus,
                    layout = wibox.container.background
                },
                -- forced_width = 300,
                forced_width = popup_width,
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

    watch('bash -c "LANGUAGE=en_US.UTF-8 free | grep -z Mem.*Swap.*"', timeout,
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
    ram_widget_clr:set_fg(fg_color)

    return ram_widget_clr
end

return setmetatable(ram_widget, { __call = function(_, ...) return worker(...) end })
