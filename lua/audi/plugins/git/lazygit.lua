return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    vim.schedule(function()
      -- Safely load telescope to avoid runtime errors
      local telescope_ok, telescope = pcall(require, "telescope")
      if not telescope_ok then
        vim.notify("Telescope not found!", vim.log.levels.ERROR)
        return
      end

      -- Safely load lazygit extension for telescope
      local lazygit_ok, err = pcall(function()
        telescope.load_extension("lazygit")
      end)

      if not lazygit_ok then
        vim.notify("Failed to load LazyGit extension for Telescope: " .. tostring(err), vim.log.levels.ERROR)
      end

      -- Set up keymaps for lazygit
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Open lazygit
      keymap("n", "<leader>gg", "<cmd>LazyGit<CR>", opts)

      -- Open lazygit in telescope
      keymap("n", "<leader>gl", "<cmd>Telescope lazygit<CR>", opts)
    end)
  end,
}
