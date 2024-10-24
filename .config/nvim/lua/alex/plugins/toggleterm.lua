return {
  "akinsho/toggleterm.nvim",
  version = "*",
  -- config = true,

  config = function()
    require("toggleterm").setup {
      -- function(term)
      --   if term.direction == "horizontal" then
      --     return 15
      --   elseif term.direction == "vertical" then
      --     return vim.o.columns * 0.4
      --   end
      -- end,

      open_mapping = [[<c-\>]]
    }

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      -- vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<CR>", { desc = "ToggleTerm direction=float" })
    keymap.set("n", "<leader>th", ":ToggleTerm direction=horizontal size=8<CR>",
      { desc = "ToggleTerm direction=horizontal" })
    keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical size=35<CR>",
      { desc = "ToggleTerm direction=vertical" })
    keymap.set("n", "<leader>tt", ":ToggleTerm direction=tab<CR>", { desc = "ToggleTerm direction=tab" })

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end
}
