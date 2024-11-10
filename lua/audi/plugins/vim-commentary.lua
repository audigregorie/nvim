return {
  "tpope/vim-commentary",
  config = function()
    -- Keymaps for easier commenting

    -- Map `gcc` to comment out a line in normal mode
    vim.keymap.set("n", "gcc", "<Plug>CommentaryLine", { noremap = false, silent = true, desc = "Comment out line" })

    -- Map `gcap` to comment out a paragraph in visual mode
    vim.keymap.set("v", "gcap", "<Plug>Commentary", { noremap = false, silent = true, desc = "Comment out paragraph" })
  end,
  -- Default keymaps available in vim-commentary:
  -- [ gcc ] to comment out a line in one go
  -- [ gcap ] to comment out a paragraph in visual mode
}

