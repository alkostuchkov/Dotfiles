vim.cmd([[
  let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
  let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
  let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
  let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
  let g:NERDToggleCheckAllLines = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not
  " Align line-wise comment delimiters flush left instead of following code indentation
  let g:NERDDefaultAlign = "left"
  " let g:NERDCreateDefaultMappings = 0 " Cancel NERD's default mappings
]])

return {
  "preservim/nerdcommenter",
  -- config = function()
  --   -- set keymaps
  --   -- local keymap = vim.keymap -- for conciseness
  --
  --   --keymap.set("n", "<leader>gy", "<cmd>Yazi<CR>", { desc = "Toggle Yazi" })
  -- end,
}
