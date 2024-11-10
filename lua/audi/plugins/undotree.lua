return {
  "mbbill/undotree",
  config = function()
    -- Keymap to toggle the undo tree window
    vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle UndoTree" })

    -- Customize undo tree appearance
    vim.g.undotree_WindowLayout = 1       -- Layout for undo tree, 3 is a vertical split on the right side
    vim.g.undotree_ShortIndicators = 1    -- Short indicators for undo tree entries
    vim.g.undotree_SetFocusWhenToggle = 1 -- Automatically focus on the undo tree window when opened
    vim.g.undotree_DiffpanelHeight = 10   -- Set height of the diff panel
    vim.g.undotree_HelpLine = 0           -- Disable the help line at the bottom of the undo tree
    vim.g.undotree_SplitWidth = 40        -- Change the width of the undo tree window (default is 30)


    -- Enable persistent undo (to keep undo history across Vim sessions)
    vim.o.undofile = true
    vim.o.undodir = vim.fn.expand("~/.vim/undodir") -- Set the undo directory
    vim.fn.mkdir(vim.o.undodir, "p")                -- Create the undo directory if it doesn't exist
  end,
}

