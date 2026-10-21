vim.cmd([[
  let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
  let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
  let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
  let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
  let g:NERDToggleCheckAllLines = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not
  " Align line-wise comment delimiters flush left instead of following code indentation
  let g:NERDDefaultAlign = "left"
  let g:NERDCreateDefaultMappings = 0 " Cancel NERD's default mappings
]])

return {
  "preservim/nerdcommenter",
  config = function()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    -- Toggles the comment state of the selected line(s).
    keymap.set({ "n", "v" }, "<leader>k<Space>", "<plug>NERDCommenterToggle", { desc = "NERDCommenterToggle" })
    -- Comment out the current line or text selected in visual mode.
    keymap.set({ "n", "v" }, "<leader>kc", "<plug>NERDCommenterComment", { desc = "NERDCommenterComment" })
    -- Uncomments the selected line(s).
    keymap.set({ "n", "v" }, "<leader>ku", "<plug>NERDCommenterUncomment", { desc = "NERDCommenterUncomment" })
    -- Same as kc but forces nesting.
    keymap.set({ "n", "v" }, "<leader>kn", "<plug>NERDCommenterNested", { desc = "NERDCommenterNested" })
    -- Comments the given lines using only one set of multipart delimiters.
    keymap.set({ "n", "v" }, "<leader>km", "<plug>NERDCommenterMinimal", { desc = "NERDCommenterMinimal" })
    -- Toggles the comment state of the selected line(s) individually.
    keymap.set({ "n", "v" }, "<leader>ki", "<plug>NERDCommenterInvert", { desc = "NERDCommenterInvert" })
    -- Comments out the selected lines with a pretty block formatted layout.
    keymap.set({ "n", "v" }, "<leader>ks", "<plug>NERDCommenterSexy", { desc = "NERDCommenterSexy" })
    -- Same as kc except that the commented line(s) are yanked first.
    keymap.set({ "n", "v" }, "<leader>ky", "<plug>NERDCommenterYank", { desc = "NERDCommenterYank" })
    -- Comments the current line from the cursor to the end of line.
    keymap.set({ "n", "v" }, "<leader>k$", "<plug>NERDCommenterToEOL", { desc = "NERDCommenterToEOL" })
    -- Adds comment delimiters to the end of line and goes into insert mode between them.
    keymap.set({ "n", "v" }, "<leader>kA", "<plug>NERDCommenterAppend", { desc = "NERDCommenterAppend" })
    -- Switches to the alternative set of delimiters.
    keymap.set({ "n", "v" }, "<leader>ka", "<plug>NERDCommenterAltDelims", { desc = "NERDCommenterAltDelims" })
  end,
}
