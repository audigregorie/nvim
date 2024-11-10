return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
    -- "ibhagwan/fzf-lua",              -- optional
    -- "echasnovski/mini.pick",         -- optional
  },
  config = function()
    -- Safely load Neogit to avoid errors
    local neogit_ok, neogit = pcall(require, "neogit")
    if not neogit_ok then
      vim.notify("Neogit not found!", vim.log.levels.ERROR)
      return
    end

    -- Setup Neogit
    neogit.setup()

    -- Keymaps for Neogit commands
    local keymap_opts = { silent = true, noremap = true }
    vim.keymap.set("n", "<leader>gs", neogit.open, keymap_opts)          -- Open Neogit
    vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", keymap_opts) -- Commit changes
    vim.keymap.set("n", "<leader>gP", ":Neogit pull<CR>", keymap_opts)   -- Pull changes
    vim.keymap.set("n", "<leader>gp", ":Neogit push<CR>", keymap_opts)   -- Push changes

    -- Keymaps for additional Git commands
    vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", keymap_opts) -- Git branches picker
    vim.keymap.set("n", "<leader>gB", ":G blame<CR>", keymap_opts)                -- Git blame
  end
}
