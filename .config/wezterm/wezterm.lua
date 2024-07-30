-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- my Everforest colorscheme
config.colors = {
  foreground = "#d3c6aa",
  background = "#2d353b",
  cursor_bg = "#d3c6aa",
  cursor_border = "#d3c6aa",
  cursor_fg = "#475258",
  selection_bg = "#475258",
  selection_fg = "#a7c080",
  ansi = { "#475258", "#e67e80", "#a7c080", "#dbbc7f", "#7fbbb3", "#d699b6", "#83c092", "#d3c6aa" },
  brights = { "#475258", "#e67e80", "#a7c080", "#dbbc7f", "#7fbbb3", "#d699b6", "#83c092", "#d3c6aa" },
}

-- config.font = wezterm.font("JetbrainsMono Nerd Font Mono")
-- config.font = wezterm.font("DejaVuSansMono Nerd Font Mono")
-- config.font = wezterm.font("DejaVu Sans Mono")
config.font = wezterm.font("MesloLGS Nerd Font Mono")
-- config.font = wezterm.font("Hack Nerd Font Mono")
-- config.font = wezterm.font("Consolas NF")
-- config.font = wezterm.font("Menlo")
-- config.font = wezterm.font("Source Code Pro")
config.font_size = 19

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 1.0
-- config.window_background_image = '/home/alexander/Pictures/Wallpapers/NewWallpapers/0313.jpg'
-- config.text_background_opacity = 0.3
config.default_cursor_style = 'SteadyBlock'

-- Keybindings
local act = wezterm.action
config.keys = {
  -- Toggle full screen
  {
    key = 'Enter',
    mods = 'ALT',
    action = 'DisableDefaultAssignment',
  },
  -- Scrolling
  { key = 'UpArrow', mods = 'CTRL|SHIFT', action = act.ScrollByLine(-1) },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = act.ScrollByLine(1) },
  { key = 'PageUp', mods = 'CTRL|SHIFT', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'CTRL|SHIFT', action = act.ScrollByPage(1) },
  { key = 'Home', mods = 'CTRL|SHIFT', action = act.ScrollToTop },
  { key = 'End', mods = 'CTRL|SHIFT', action = act.ScrollToBottom },
  -- Split
  { -- horizontal
    key = 'z',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  { -- vertical
    key = 'x',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  { -- Create new tab
    key = 't',
    mods = 'CTRL|SHIFT',
    action = act.SpawnTab 'CurrentPaneDomain',
    -- action = act.SpawnTab 'DefaultDomain',
    -- action = act.SpawnTab { DomainName = 'unix' },
  },
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.EmitEvent 'switch-to-left',
  },
  {
    key = 'l',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.EmitEvent 'switch-to-right',
  },
  -- Show TabNavigator
  { key = 'F9', mods = 'ALT', action = wezterm.action.ShowTabNavigator },
  { key = ']', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
  { key = '[', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(-1) },
  -- { key = ']', mods = 'CTRL', action = wezterm.action.ActivateTabRelativeNoWrap(1) },
  -- { key = '[', mods = 'CTRL', action = wezterm.action.ActivateTabRelativeNoWrap(-1) },
  { -- Rename current tab
    key = 't',
    mods = 'ALT|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}

-- Activate tab by ctrl+number
for i = 1, 8 do
  -- CTRL + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL',
    action = act.ActivateTab(i - 1),
  })
  -- -- F1 through F8 to activate that tab
  -- table.insert(config.keys, {
    -- key = 'F' .. tostring(i),
    -- action = act.ActivateTab(i - 1),
  -- })
end
-- -- timeout_milliseconds defaults to 1000 and can be omitted
-- config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
-- config.keys = {
  -- {
    -- key = '|',
    -- mods = 'LEADER|SHIFT',
    -- action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  -- },
  -- -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  -- {
    -- key = 'a',
    -- mods = 'LEADER|CTRL',
    -- action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
  -- },
-- }

-- FUNCTIONS
-- switch between splitted panes
wezterm.on('switch-to-left', function(window, pane)
    local tab = window:mux_window():active_tab()

    if tab:get_pane_direction 'Left' ~= nil then
        window:perform_action(wezterm.action.ActivatePaneDirection 'Left', pane)
    else
        window:perform_action(wezterm.action.ActivateTabRelative(-1), pane)
    end
end)

wezterm.on('switch-to-right', function(window, pane)
    local tab = window:mux_window():active_tab()

    if tab:get_pane_direction 'Right' ~= nil then
        window:perform_action(
            wezterm.action.ActivatePaneDirection 'Right',
            pane
        )
    else
        window:perform_action(wezterm.action.ActivateTabRelative(1), pane)
    end
end)

-- and finally, return the configuration to wezterm
return config
