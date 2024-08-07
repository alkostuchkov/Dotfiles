-- import nvim-treesitter plugin
local treesitter = require("nvim-treesitter.configs")

-- configure treesitter
treesitter.setup({ -- enable syntax highlighting
  highlight = {
    enable = true,
  },
  -- enable indentation
  indent = { enable = true },
  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = {
    enable = true,
  },
  -- ensure these language parsers are installed
  ensure_installed = {
    "bash",
"fish",
    "c",
    "cpp",
    "python",
    "lua",
    "json",
    "yaml",
    "toml",
    "html",
    "css",
    "markdown",
    "markdown_inline",
    "vim",
    "vimdoc",
    "gitignore",
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
})
