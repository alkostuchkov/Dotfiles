-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

local sessions = wezterm.plugin.require("https://github.com/abidibo/wezterm-sessions")
sessions.apply_to_config(config) -- optional, this adds default keybindings

local my_colors = require("colors/Cobalt2")
config.colors = my_colors

-- -- my Cobalt2 colorscheme
-- config.colors = {
--   foreground = "#e0e0e0",
--   background = "#213049",
--   cursor_bg = "#ecf0f1",
--   cursor_border = "#ecf0f1",
--   cursor_fg = "#213049",
--   selection_bg = "#e0e0e0",
--   selection_fg = "#213049",
--   brights = {
--     "#95a5a6",
--     "#ff628c",
--     "#2ecc71",
--     "#ffc600",
--     "#3498db",
--     "#9b59b6",
--     "#80ffbb",
--     "#ecf0f1",
--   },
--   ansi = {
--     "#213049",
--     "#ff628c",
--     "#2ecc71",
--     "#ffc600",
--     "#3498db",
--     "#9b59b6",
--     "#80ffbb",
--     "#e0e0e0",
--   },
-- }

-- config.font = wezterm.font(
--   "JetBrainsMono NF",
--   { weight = "Regular", italic = false }
-- )
-- config.font = wezterm.font("Monoid Nerd Font")
-- config.font = wezterm.font("JetBrainsMono Nerd Font")
-- config.font = wezterm.font("JetBrainsMono NF Light")
-- config.font = wezterm.font("IosevkaTerm_JBMono")
-- config.font = wezterm.font("IosevkaTerm_IlovePlus")
-- config.font = wezterm.font("IosevkaTerm_IloveModern")
-- config.font = wezterm.font("mplus Nerd Font")
-- config.font = wezterm.font("DejaVuSansMono Nerd Font Mono")
-- config.font = wezterm.font("DejaVuSansM Nerd Font")
-- config.font = wezterm.font("DejaVu Sans Mono")
-- config.font = wezterm.font("MesloLGS Nerd Font")
-- config.font = wezterm.font("Hack Nerd Font")
-- config.font = wezterm.font("Mononoki Nerd Font")
-- config.font = wezterm.font("Iosevka")
-- config.font = wezterm.font("FiraCode Nerd Font Ret")
-- config.font = wezterm.font("FiraCode Nerd Font Light")
-- config.font = wezterm.font("Consolas NF")
-- config.font = wezterm.font("Menlo")
-- config.font = wezterm.font("Source Code Pro")

-- -- -- config.font = wezterm.font { family = "FiraMono Nerd Font" }
-- -- -- config.font = wezterm.font { family = "FiraCode Nerd Font" }
-- config.font = wezterm.font { family = "Fira Mono" }
-- config.font_rules = {
--   {
--     intensity = "Bold",
--     italic = true,
--     font = wezterm.font {
--       family = "Fira Mono",
--       weight = "Bold",
--       style = "Italic",
--     },
--   },
--   {
--     intensity = "Normal",
--     italic = true,
--     font = wezterm.font {
--       family = "Fira Mono",
--       style = "Italic",
--     },
--   },
-- }

config.font = wezterm.font { family = "mplus Nerd Font" }
config.font_rules = {
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font {
      family = "UbuntuMono Nerd Font",
      weight = "Bold",
      style = "Italic",
    },
  },
  {
    intensity = "Normal",
    italic = true,
    font = wezterm.font {
      family = "UbuntuMono Nerd Font",
      style = "Italic",
    },
  },
}

config.font_size = 18.0
-- config.line_height = 1.10 -- for Hack Nerd Font
-- config.line_height = 1.15 -- for Consolas NF
-- config.line_height = 1.05 -- for Mononoki Nerd Font
config.line_height = 0.8 -- for Iosevka, mplus Nerd Font
-- config.cell_width = 1

config.bold_brightens_ansi_colors = true
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

config.window_padding = {
  left = 0,
  -- left = 3,
  right = 0,
  top = 0,
  bottom = 0,
}

-- config.window_decorations = "RESIZE"
config.window_background_opacity = 1.0
-- config.window_background_image = '/home/alexander/Pictures/Wallpapers/NewWallpapers/0313.jpg'
-- config.text_background_opacity = 0.3
config.default_cursor_style = "SteadyBar"
-- config.default_cursor_style = "SteadyBlock"

-- Keybindings
local act = wezterm.action
-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = "q", mods = "ALT", timeout_milliseconds = 2000 }
config.keys = {
  -- Sessions
  {
      key = "s",
      mods = "ALT",
      action = act { EmitEvent = "save_session" },
  },
  {
      key = "l",
      mods = "ALT",
      action = act { EmitEvent = "load_session" },
  },
  {
      key = "r",
      mods = "ALT",
      action = act { EmitEvent = "restore_session" },
  },
  {
      key = "d",
      mods = "CTRL|SHIFT",
      action = act { EmitEvent = "delete_session" },
  },
  {
      key = "e",
      mods = "CTRL|SHIFT",
      action = act { EmitEvent = "edit_session" },
  },
  -- Rename current workspace
  {
      key = "$",
      mods = "CTRL|SHIFT",
      action = act.PromptInputLine {
          description = "Enter new workspace name",
          action = wezterm.action_callback(
              function(window, pane, line)
                  if line then
                      wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
                  end
              end
          ),
      },
  },
  -- Prompt for a name to use for a new workspace and switch to it.
  {
      key = "w",
      mods = "CTRL|SHIFT",
      action = act.PromptInputLine {
          description = wezterm.format {
              { Attribute = { Intensity = "Bold" } },
              { Foreground = { AnsiColor = "Fuchsia" } },
              { Text = "Enter name for new workspace" },
          },
          action = wezterm.action_callback(function(window, pane, line)
              -- line will be `nil` if they hit escape without entering anything
              -- An empty string if they just hit enter
              -- Or the actual line of text they wrote
              if line then
                  window:perform_action(
                      act.SwitchToWorkspace {
                          name = line,
                      },
                      pane
                  )
              end
          end),
      },
  },

  -- Scrolling
  { key = "UpArrow",   mods = "CTRL|SHIFT", action = act.ScrollByLine(-1) },
  { key = "DownArrow", mods = "CTRL|SHIFT", action = act.ScrollByLine(1) },
  { key = "PageUp",    mods = "CTRL|SHIFT", action = act.ScrollByPage(-1) },
  { key = "PageDown",  mods = "CTRL|SHIFT", action = act.ScrollByPage(1) },
  { key = "Home",      mods = "CTRL|SHIFT", action = act.ScrollToTop },
  { key = "End",       mods = "CTRL|SHIFT", action = act.ScrollToBottom },

  -- Split
  { -- horizontal
    -- key = "x",
    -- mods = "CTRL|SHIFT",
    key = "\\", -- |
    mods = "LEADER",
    action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  { -- vertical
    -- key = "z",
    -- mods = "CTRL|SHIFT",
    key = "-",
    mods = "LEADER",
    action = act.SplitVertical { domain = "CurrentPaneDomain" },
  },

  -- Tabs
  { -- Create new tab
    key = "t",
    mods = "CTRL|SHIFT",
    action = act.SpawnTab "CurrentPaneDomain",
    -- action = act.SpawnTab 'DefaultDomain',
    -- action = act.SpawnTab { DomainName = 'unix' },
  },
  { -- Close current tab
    key = "x",
    mods = "CTRL|SHIFT",
    action = act.CloseCurrentPane { confirm = true },
  },

  -- Moving between splitted (when no splitted - between tabs)
  {
    key = "j",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection "Down",
  },
  {
    key = "k",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection "Up",
  },
  {
    key = "h",
    mods = "CTRL|SHIFT",
    action = act.EmitEvent "switch-to-left",
  },
  {
    key = "l",
    mods = "CTRL|SHIFT",
    action = act.EmitEvent "switch-to-right",
  },

  -- Moving between tabs
  { key = "]",  mods = "CTRL", action = act.ActivateTabRelative(1) },
  { key = "[",  mods = "CTRL", action = act.ActivateTabRelative(-1) },

  -- Show TabNavigator
  { key = "F9", mods = "CTRL",  action = act.ShowTabNavigator },

  { -- Rename current tab
    key = "t",
    mods = "ALT|SHIFT",
    action = act.PromptInputLine({
      description = "Enter new name for tab",
      -- action = wezterm.action_callback(function(window, pane, line)
      action = wezterm.action_callback(function(window, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },

  -- Disable defaults keys:
  { -- Switch between tabs 
    key = "Tab",
    mods = "CTRL",
    action = act.DisableDefaultAssignment,
  },
  {
    key = "Tab",
    mods = "CTRL|SHIFT",
    action = act.DisableDefaultAssignment,
  },
  { -- Toggle full screen
    key = "Enter",
    mods = "ALT",
    action = act.DisableDefaultAssignment,
  },
}

-- Activate tab by ctrl+number
for i = 1, 8 do
  -- CTRL + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = "CTRL",
    action = act.ActivateTab(i - 1),
  })
  -- -- F1 through F8 to activate that tab
  -- table.insert(config.keys, {
  -- key = "F" .. tostring(i),
  -- action = act.ActivateTab(i - 1),
  -- })
end

-- FUNCTIONS
-- switch between splitted panes
wezterm.on("switch-to-left", function(window, pane)
  local tab = window:mux_window():active_tab()

  if tab:get_pane_direction("Left") ~= nil then
    window:perform_action(act.ActivatePaneDirection("Left"), pane)
  else
    window:perform_action(act.ActivateTabRelative(-1), pane)
  end
end)

wezterm.on("switch-to-right", function(window, pane)
  local tab = window:mux_window():active_tab()

  if tab:get_pane_direction("Right") ~= nil then
    window:perform_action(act.ActivatePaneDirection("Right"), pane)
  else
    window:perform_action(act.ActivateTabRelative(1), pane)
  end
end)

-- and finally, return the configuration to wezterm
return config
