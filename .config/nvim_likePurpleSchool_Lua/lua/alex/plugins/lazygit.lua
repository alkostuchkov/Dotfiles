  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
-- set keymaps
local keymap = vim.keymap -- for conciseness
  keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "Open lazy git" })
