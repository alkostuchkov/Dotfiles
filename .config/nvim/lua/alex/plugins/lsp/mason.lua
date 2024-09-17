return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "bashls",
        "html",
        "cssls",
        "clangd",
        "lua_ls",
        "pyright",
        "gopls",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        -- "stylua", -- lua formatter
        -- "autopep8", -- python formatter
        -- "black", -- python formatter
        -- "isort", -- python formatter
        "pylint", -- python linter
        "flake8", -- python linter
        -- "mypy",   -- python linter
      },
    })
  end,
}
