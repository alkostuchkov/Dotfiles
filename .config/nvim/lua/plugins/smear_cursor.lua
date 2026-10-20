return {
  "sphamba/smear-cursor.nvim",
  opts = {},

  config = function()
    require("smear_cursor").setup()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ct", ":SmearCursorToggle<CR>", { desc = "SmearCursorToggle" }) -- toggle animated cursor

    -- keymap.set("n", "<C-F12>", ":SmearCursorToggle<CR>", { desc = "SmearCursorToggle" }) -- toggle animated cursor
    -- keymap.set("n", "<C-c>", ":SmearCursorToggle<CR>", { desc = "SmearCursorToggle" }) -- toggle animated cursor
  end,
}
