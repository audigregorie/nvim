return {
  "tpope/vim-rhubarb",
  dependencies = { "tpope/vim-fugitive" }, -- vim-rhubarb requires vim-fugitive to work

  config = function()
    -- Optional keybindings for GitHub actions
    local keymap_opts = { noremap = true, silent = true, desc = "GitHub" }

    -- Open the current file on GitHub in the browser
    vim.keymap.set("n", "<leader>go", ":GBrowse<CR>", keymap_opts)

    -- Open the GitHub pull request page for the current branch
    vim.keymap.set("n", "<leader>gp", ":GBrowse!<CR>", keymap_opts)
  end,
}

