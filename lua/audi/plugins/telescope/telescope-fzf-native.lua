return {
  "nvim-telescope/telescope-fzf-native.nvim",
  build = "make", -- Ensures the extension is built using 'make'

  -- Check if 'make' is available before loading the plugin
  cond = function()
    return vim.fn.executable("make") == 1
  end,

  config = function()
    -- Safely load telescope
    local telescope_ok, telescope = pcall(require, "telescope")
    if not telescope_ok then
      vim.notify("Telescope not found!", vim.log.levels.ERROR)
      return
    end

    -- Load the fzf-native extension
    local fzf_ok = pcall(telescope.load_extension, "fzf")
    if not fzf_ok then
      vim.notify("Telescope FZF Native extension failed to load!", vim.log.levels.ERROR)
    end
  end,
}

