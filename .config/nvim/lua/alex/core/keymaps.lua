vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>=", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })        -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- keymap.set("n", "<leader>tf", ":tabfirst <CR>", { desc = "Go to first tab" })      -- go to first tab
keymap.set("n", "<leader>tl", ":tablast <CR>", { desc = "Go to last tab" })        -- go to last tab
keymap.set("n", "<Tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" })             --  go to next tab
keymap.set("n", "<S-Tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" })       --  go to previous tab
-- keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

for _, i in ipairs({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }) do
  keymap.set("n", "<leader>t" .. i, i .. "gt", { desc = "Go to tab " .. i }) -- go to 1, 2, 3, 4, 5, 6, 7, 8, 9 tab
end

-- buffers
-- keymap.set("n", "<leader>bx", "<cmd>BufferLinePickClose<cr>", { desc = "Close current buffer" })
keymap.set("n", "<leader>bx", "<cmd>bdelete<CR>", { desc = "Close current buffer" }) -- close current buffer

-- insert a new line above/below
keymap.set("n", "<M-S-Enter>", "O<Esc>", { desc = "Insert a new line above (Normal mode)" })
keymap.set("n", "<M-Enter>", "o<Esc>", { desc = "Insert a new line below (Normal mode)" })
keymap.set("i", "<M-S-Enter>", "<Esc>O", { desc = "Insert a new line above (Insert mode)" })
keymap.set("i", "<M-Enter>", "<Esc>o", { desc = "Insert a new line below (Insert mode)" })

-- easier moving of code blocks (doesn't lose selection)
keymap.set("v", "<", "<gv", { desc = "Move block >" })
keymap.set("v", ">", ">gv", { desc = "Move block <" })

-- close buffer without saving
keymap.set("n", "<Esc><Esc>", ":q!<CR>", { desc = "Close buffer without saving" })
keymap.set("n", "<leader>q<Esc>", ":q!<CR>", { desc = "Close without saving" })
keymap.set("n", "<leader>qw", ":wq!<CR>", { desc = "Close with saving" })
keymap.set("n", "<leader>qa", ":qa<CR>", { desc = "Close all" })
-- save
keymap.set("n", "<C-s>", ":w<CR>")
keymap.set("i", "<C-s>", "<Esc>:w<CR>a")

-- resize windows
keymap.set("n", "<leader>s<Up>", ":resize +2<CR>")
keymap.set("n", "<leader>s<Down>", ":resize -2<CR>")
keymap.set("n", "<leader>s<Left>", ":vertical resize -2<CR>")
keymap.set("n", "<leader>s<Right>", ":vertical resize +2<CR>")

-- like in a terminal
-- movements
-- go to BOL and EOL
keymap.set("i", "<C-a>", "<Esc>I", { desc = "Go to BOL (Insert mode)" })
keymap.set("i", "<C-e>", "<Esc>A", { desc = "Go to EOL (Insert mode)" })

-- move forward/backward by a char
keymap.set("i", "<C-f>", "<Right>", { desc = "Go forward by a char (Insert mode)" })
keymap.set("i", "<C-b>", "<Left>", { desc = "Go backward by a char (Insert mode)" })
-- move forward/backward by a word
keymap.set("i", "<M-f>", "<Esc> wi", { desc = "Go forward by a word (Insert mode)" })
keymap.set("i", "<M-b>", "<Esc> bi", { desc = "Go backward by a word (Insert mode)" })

-- delete to EOL
keymap.set("i", "<C-k>", "<Esc> d$a", { desc = "Delete to EOL (Insert mode)" })

-- delete backward by a char (<C-h> = backspace by default)
keymap.set("i", "<C-d>", "<Del>", { desc = "Delete backward by a char (Insert mode)" })
-- delete backward by a word
keymap.set("i", "<C-w>", "<Esc> dbi", { desc = "Delete backward by a word from end to begin (Insert mode)" })
keymap.set("i", "<M-d>", "<Esc> dea", { desc = "Delete backward by a word from begin to end (Insert mode)" })

-- navigation
keymap.set("n", "<C-k>", ":wincmd k<CR>")
keymap.set("n", "<C-j>", ":wincmd j<CR>")
keymap.set("n", "<C-h>", ":wincmd h<CR>")
keymap.set("n", "<C-l>", ":wincmd l<CR>")

-- move lines up/down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- usefull replacement example
keymap.set("v", "<C-r>", "\"hy:%s/<C-r>h//gc<left><left><left>", { desc = "Replace selected" })
