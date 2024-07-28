-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
 --   {
 --     "nvim-neo-tree/neo-tree.nvim",
 --     branch = "v2.x",
 --     dependencies = {
 --       "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons",
 --       "MunifTanjim/nui.nvim", "s1n7ax/nvim-window-picker"
 --     }
 --   },
  
    { 
      "nvim-tree/nvim-tree.lua", 
      dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    { "nvim-treesitter/nvim-treesitter" },
    { "sainnhe/everforest" },
    { "folke/which-key.nvim" },
});
