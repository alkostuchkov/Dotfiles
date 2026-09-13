return {
    -- Example with lazy.nvim
      "tanvirtin/monokai.nvim",
      config = function()
        require("monokai").setup {
          palette = require("monokai").pro, -- or .soda, .ristretto
          -- palette = require("monokai").ristretto, -- or .soda, .ristretto
          -- palette = require("monokai").soda, -- or .soda, .ristretto
        }
        vim.cmd.colorscheme("monokai")
      end
}
