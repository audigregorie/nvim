return {
  "szw/vim-maximizer",
  config = function()
    -- Keymaps for maximizing and restoring windows
    -- Toggle maximization of the current window
    vim.keymap.set("n", "<leader>m", ":MaximizerToggle<CR>",
      { noremap = true, silent = true, desc = "Toggle window maximization" })
  end,
}

