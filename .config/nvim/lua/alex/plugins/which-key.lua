return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependences = {
    { 'echasnovski/mini.icons', version = false },
  },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    icons = {
      mappings = false,
    },
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  preset = "classic", -- "classic", "modern", "helix"
  layout = {
      width = { min = 30 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
    },
  win = {
      border = "rounded", -- Options: "rounded", "single", "double", "solid", "none"
    },
  },
}
