vim.cmd("set termguicolors")

require("colorizer").setup()

-- set keymaps
local keymap = vim.keymap -- for conciseness

-- keymap.set("n", "<F12>", "<cmd>ColorizerToggle<CR>", { desc = "Toggle Colorizer" }) -- toggle Colorizer
keymap.set("n", "<F12>", ":ColorizerToggle<CR>", { desc = "Toggle Colorizer" }) -- toggle Colorizer
