vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>=", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("n", "<leader>tf", ":tabfirst <CR>", { desc = "Go to first tab" }) -- go to first tab
keymap.set("n", "<leader>tl", ":tablast <CR>", { desc = "Go to last tab" }) -- go to last tab
for _, i in ipairs({1, 2, 3, 4, 5, 6, 7, 8, 9}) do
  keymap.set("n", "<leader>t" .. i, i .. "gt", { desc = "Go to tab " .. i }) -- go to 1, 2, 3, 4, 5, 6, 7, 8, 9 tab
end

-- like in a terminal
-- go to BOL and EOL
keymap.set("i", "<C-a>", "<Esc>I", { desc = "Go to BOL (Insert mode)" })
keymap.set("i", "<C-e>", "<Esc>A", { desc = "Go to EOL (Insert mode)" })
-- keymap.set("n", "<C-a>", "0", { desc = "Go to BOL (Normal mode)" })
-- keymap.set("n", "<C-e>", "$", { desc = "Go to EOL (Normal mode)" })

-- delete to EOL
keymap.set("n", "<C-k>", "D", { desc = "Delete to EOL (Normal mode)" })
keymap.set("i", "<C-k>", "<Esc> d$a", { desc = "Delete to EOL (Insert mode)" })

-- delete to BOL
keymap.set("n", "<C-u>", "d0", { desc = "Delete to BOL (Normal mode)" })
keymap.set("i", "<C-u>", "<Esc> d0i", { desc = "Delete to BOL (Insert mode)" })

-- movements
-- by a char
keymap.set("i", "<C-f>", "<Esc> la", { desc = "Go forward by a char (Insert mode)" })
keymap.set("i", "<C-b>", "<Esc> hi", { desc = "Go backward by a char (Insert mode)" })
-- by a word
keymap.set("i", "<M-f>", "<Esc> wa", { desc = "Go forward by a word (Insert mode)" })
keymap.set("i", "<M-b>", "<Esc> bi", { desc = "Go backward by a word (Insert mode)" })

-- deleting
-- by a char
keymap.set("i", "<C-d>", "<Esc> xi", { desc = "Delete backward by a char (Insert mode)" })
-- by a word
keymap.set("i", "<C-w>", "<Esc> dbi", { desc = "Delete backward by a word from end to begin (Insert mode)" })
keymap.set("i", "<M-d>", "<Esc> dea", { desc = "Delete backward by a word from begin to end (Insert mode)" })

-- insert a new line above/below
keymap.set("n", "<M-a>", "O<Esc>", { desc = "Insert a new line above (Normal mode)" })
keymap.set("n", "<M-Enter>", "o<Esc>", { desc = "Insert a new line below (Normal mode)" })
keymap.set("i", "<M-a>", "<Esc>O", { desc = "Insert a new line above (Insert mode)" })
keymap.set("i", "<M-Enter>", "<Esc>o", { desc = "Insert a new line below (Insert mode)" })

-- navigation
keymap.set('n', '<C-M-k>', ':wincmd k<CR>')
keymap.set('n', '<C-M-j>', ':wincmd j<CR>')
keymap.set('n', '<C-M-h>', ':wincmd h<CR>')
keymap.set('n', '<C-M-l>', ':wincmd l<CR>')
keymap.set('n', '<leader>/', ':CommentToggle<CR>')

-- resize windows
keymap.set('n', '<leader>s<Up>', ':resize +2<CR>')
keymap.set('n', '<leader>s<Down>', ':resize -2<CR>')
keymap.set('n', '<leader>s<Left>', ':vertical resize -2<CR>')
keymap.set('n', '<leader>s<Right>', ':vertical resize +2<CR>')

-- keymap.set('i', '<Up>', '<Esc>:resize +2<CR>a')
-- keymap.set('i', '<Down>', '<Esc>:resize -2<CR>a')
-- keymap.set('i', '<Left>', '<Esc>:vertical resize -2<CR>a')
-- keymap.set('i', '<Right>', '<Esc>:vertical resize +2<CR>a')

-- Easier moving of code blocks (doesn't lose selection)
  keymap.set('v', '<', '<gv')
  keymap.set('v', '>', '>gv')

-- Edit & Apply changes in config files
-- vim.keymap.set('n', '<leader>ev', ':tabnew ~/.config/nvim/init.lua<CR>')
-- -- vim.keymap.set('n', '<leader>sv', ':source ~/.config/nvim/init.lua<CR>')
-- vim.keymap.set('n', '<leader>sv', ':source %<CR>')

-- close buffer without saving
keymap.set('n', '<ESC><ESC>', ':q!<CR>')
-- quit all windows without saving
keymap.set('n', '<leader>q', ':qa!<CR>')
-- save
keymap.set('n', '<C-s>', ':w<CR>')
keymap.set('i', '<C-s>', '<Esc>:w<CR>a')

