local naughty = require("naughty")
local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local HOME = os.getenv("HOME")
local DIR = HOME .. "/.config/awesome/awesome-wm-widgets/pacman-widget/"

local pacman_widget = {}
local timer = {}

-- config.interval = 10800
-- config.popup_bg_color = "#222222"
-- config.popup_border_width = 1
-- config.popup_border_color = "#7e7e7e"
-- config.popup_height = 25
-- config.popup_width = 500
-- -- config.polkit_agent_path = "/usr/bin/lxpolkit"
--
-- local function worker(user_args)
    -- local args, _config = user_args or {}, {}
    -- for prop, value in pairs(config) do
        -- _config[prop] = args[prop] or beautiful[prop] or value
    -- end

local function worker(user_args)
    local args = user_args or {}

    local interval = args.interval or 10800
    local fg_color = args.fg_color or beautiful.fg_normal
    local bg_color = args.bg_color or beautiful.bg_color or "#00000000"
    local popup_bg_color = args.popup_bg_color or beautiful.popup_bg_color or "#222222"
    local popup_border_width = args.popup_border_width or beautiful.popup_border_width or 1
    local popup_border_color = args.popup_border_color or beautiful.popup_border_color or "#7e7e7e"
    local popup_height = args.popup_height or beautiful.popup_height or 25
    local popup_width = args.popup_width or beautiful.popup_width or 500
    local font_name = args.font_name or beautiful.font
    local icon = args.icon or ""
    local icon_size = args.icon_size or 11
    local font_name_no_size = font_name:gsub("%s%d+$", " ")
    local font_size_icon = font_name_no_size .. icon_size or font_name_no_size .. icon_size
    -- local polkit_agent_path = "/usr/bin/lxpolkit"

    -- awful.spawn.once(polkit_agent_path)

    pacman_widget = wibox.widget {
            {
                id = "txt_icon",
                text = icon,
                font = font_size_icon,
                widget = wibox.widget.textbox,
            },
            valign = "center",
            layout = wibox.layout.fixed.horizontal,
            -- layout = wibox.container.place,
            {
                id = "txt_updates",
                font = font_name,
                widget = wibox.widget.textbox
            },
            spacing = 3,
            -- spacing = 5,
            layout = wibox.layout.fixed.horizontal,
    }
    function pacman_widget.set(new_value)
        pacman_widget:get_children_by_id("txt_updates")[1]:set_text(new_value)
        -- pacman_widget:get_children_by_id("txt_icon")[1]:set_text(" ")
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

    pacman_widget:buttons(
        awful.util.table.join(
            awful.button({}, 1, function()
                if popup.visible then
                    popup.visible = false
                else
                    popup.visible = true
                    popup:move_next_to(_G.mouse.current_widget_geometry)
                end
            end),
            awful.button({}, 3, function()
                awful.spawn(HOME.."/.config/awesome/scripts/show_updates.sh")
            end)
        )
    )

    local upgr_opacity = 0.6
    local upgr_btn = wibox.widget {
        {
            -- image = ICON_DIR .. "upgrade.svg",
            -- resize = false,
            -- layout = wibox.widget.imagebox
            text = "  ",
            layout = wibox.widget.textbox
        },
        opacity = upgr_opacity,
        layout = wibox.container.background
    }

    local old_cursor, old_wibox
    local busy, upgrading = false, false
    upgr_btn:connect_signal("mouse::enter", function(c)
        if not busy then
            c:set_opacity(1)
            c:emit_signal("widget::redraw_needed")
            local wb = _G.mouse.current_wibox
            old_cursor, old_wibox = wb.cursor, wb
            wb.cursor = "hand2"
        end
    end)
    upgr_btn:connect_signal("mouse::leave", function(c)
        if not busy then
            c:set_opacity(upgr_opacity)
            c:emit_signal("widget::redraw_needed")
            if old_wibox then
                old_wibox.cursor = old_cursor
                old_wibox = nil
            end
        end
    end)
    upgr_btn:connect_signal("button::release", function(c)
        c:set_opacity(1)
        c:emit_signal("widget::redraw_needed")
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
        if not busy then
            busy = true
            local one_shot = true
            awful.spawn.with_line_callback("bash -c " .. DIR .. "upgrade", {
                stdout = function()
                    if one_shot then
                        upgrading, one_shot = true, false
                        timer:emit_signal("timeout")
                    end
                end,
                stderr = function(line)
                    if (line ~= nil and line ~= "") then
                        if string.find(line, "warning") then
                            naughty.notify({
                                title = "Warning!",
                                text = line,
                                timeout = 0
                                })
                        else
                            naughty.notify({
                                preset = naughty.config.presets.critical,
                                title = "Error!",
                                text = line,
                            })
                        end
                    end
                end,
                exit = function()
                    upgrading, busy = false, false
                    c:set_opacity(upgr_opacity)
                    c:emit_signal("widget::redraw_needed")
                    timer:emit_signal("timeout")
                end,
            })
        end
        popup.visible = false
    end)

    -- Check updates in interval
    timer = select(2, awful.widget.watch([[bash -c "checkupdates-with-aur 2>/dev/null"]],
        interval,
        function(widget, stdout)
            local upgrades_tbl = {}
            for value in stdout:gmatch("([^\n]+)") do
                upgrades_tbl[#upgrades_tbl+1] = value
            end
            widget.set(#upgrades_tbl)

            -- Hide widget if no updates
            widget.visible = (#upgrades_tbl > 0) or false
            -- widget.visible = (#upgrades_tbl == 0) or true
            -- if (#upgrades_tbl == 0) then widget.visible = false else widget.visible = true end

            local popup_header_height, popup_row_height = 30, 20
            local header = wibox.widget {
                {
                    nil,
                    {
                        markup = "<b>" .. (upgrading and "Upgrading " .. #upgrades_tbl .. " Packages" or
                            (#upgrades_tbl == 0 and "No" or #upgrades_tbl) .. " Available Upgrades") .. "</b>",
                        layout = wibox.widget.textbox,
                    },
                    #upgrades_tbl > 0 and {
                        upgr_btn,
                        valign = "center",
                        layout = wibox.container.place,
                    },
                    expand = "none",
                    layout = wibox.layout.align.horizontal,
                },
                forced_height = popup_header_height,
                left = 20,
                right = 20,
                layout = wibox.container.margin
            }

            for k, v in ipairs(upgrades_tbl) do
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

            -- local height = popup_header_height + math.min(#upgrades_tbl, popup_height) * popup_row_height
            local height = popup_header_height + math.min(#upgrades_tbl, popup_height) * (popup_row_height + 1) -- +1 corrects popup output!!!
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
                    layout = wibox.container.background
                },
                forced_width = popup_width,
                layout = wibox.layout.fixed.horizontal
            }
       end,
       pacman_widget
    ))

    -- Set fg and bg colors for pacman_widget
    local pacman_widget_clr = wibox.widget.background()
    pacman_widget_clr:set_widget(pacman_widget)
    pacman_widget_clr:set_fg(fg_color)
    -- pacman_widget_clr:set_bg("#ff0000")
    -- return wibox.container.background(pacman_widget, "#ff0000")

    return pacman_widget_clr
    -- return pacman_widget
end

return setmetatable(pacman_widget, { __call = function(_, ...) return worker(...) end })

