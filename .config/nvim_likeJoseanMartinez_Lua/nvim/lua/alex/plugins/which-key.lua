return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  -- dependences = {
  --   { 'echasnovski/mini.icons', version = false },
  -- },
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
  },
}