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

-- config.color_scheme = 'Everforest Dark (Gogh)'

-- config.font = wezterm.font("FiraCode Nerd Font")
config.font = wezterm.font("MesloLGS Nerd Font Mono")
-- config.font = wezterm.font("Source Code Pro")
config.font_size = 18

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 1.0
-- config.macos_window_background_blur = 10

-- and finally, return the configuration to wezterm
return config
