-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

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

-- config.font = wezterm.font("DejaVuSansMono Nerd Font Mono")
-- config.font = wezterm.font("DejaVu Sans Mono")
-- config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font = wezterm.font("Hack Nerd Font Mono")
-- config.font = wezterm.font("Consolas")
-- config.font = wezterm.font("Menlo")
-- config.font = wezterm.font("Source Code Pro")
config.font_size = 18

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 1.0
-- config.window_background_image = '/home/alexander/Pictures/Wallpapers/NewWallpapers/0313.jpg'
-- config.text_background_opacity = 0.3

-- Keybindings
local act = wezterm.action
config.keys = {
  { key = 'UpArrow', mods = 'CTRL|SHIFT', action = act.ScrollByLine(-1) },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = act.ScrollByLine(1) },
  { key = 'PageUp', mods = 'CTRL|SHIFT', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'CTRL|SHIFT', action = act.ScrollByPage(1) },
  { key = 'Home', mods = 'CTRL|SHIFT', action = act.ScrollToTop },
  { key = 'End', mods = 'CTRL|SHIFT', action = act.ScrollToBottom },
  {
    key = 'z',
    mods = 'CTRL|SHIFT|',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'x',
    mods = 'CTRL|SHIFT|',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
}
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

-- and finally, return the configuration to wezterm
return config
