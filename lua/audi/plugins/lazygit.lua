return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- Safely load telescope to avoid runtime errors
    local telescope_ok, telescope = pcall(require, "telescope")
    if not telescope_ok then
      vim.notify("Telescope not found!", vim.log.levels.ERROR)
      return
    end

    -- Safely load lazygit extension for telescope
    local lazygit_ok, _ = pcall(telescope.load_extension, "lazygit")
    if not lazygit_ok then
      vim.notify("Failed to load LazyGit extension for Telescope!", vim.log.levels.ERROR)
    end
  end,
}

