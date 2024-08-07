local lualine = require("lualine")
local lazy_status = require("lazy.status") -- to configure lazy pending updates count

local colors = {
  blue = "#7fbbb3",
  green = "#a7c080",
  violet = "#d699b6",
  yellow = "#dbbc7f",
  red = "#e67e80",
  fg = "#c3ccdc",
  bg = "#475258",
  inactive_bg = "#2d353b",
}

local my_lualine_theme = {
  normal = {
    a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  insert = {
    a = { bg = colors.green, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  visual = {
    a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  command = {
    a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  replace = {
    a = { bg = colors.red, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  inactive = {
    a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
    b = { bg = colors.inactive_bg, fg = colors.semilightgray },
    c = { bg = colors.inactive_bg, fg = colors.semilightgray },
  },
}

-- configure lualine with modified theme
lualine.setup({
  options = {
    theme = my_lualine_theme,
    component_separators = '|',
    section_separators = { left = '', right = '' }
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' } } --, right_padding = 10 }
    },
    lualine_c = {
      {
        "filename",
        file_status = true,
        path = 1,
      }
    },
    lualine_x = {
      {
        lazy_status.updates,
        cond = lazy_status.has_updates,
        color = { fg = "#ff9e64" },
      },
      -- { "%02.2B" },
      { "encoding" },
      { "fileformat" },
      { "filetype" },
    },
    lualine_z = {
      { "location", separator = { right = "" } } --, left_padding = 10 }
    },
  },
})
