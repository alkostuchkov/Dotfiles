require("nvim-treesitter").setup({
  ensure_installed = { "c", "cpp", "lua", "python" },

  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
})
