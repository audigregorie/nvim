return {
  "danielvolchek/tailiscope.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },

  config = function()
    -- Safely load telescope
    local telescope_ok, telescope = pcall(require, "telescope")
    if not telescope_ok then
      vim.notify("Telescope not found", vim.log.levels.ERROR)
      return
    end

    -- Load tailiscope extension in telescope
    local tailiscope_ok, tailiscope = pcall(require, "tailiscope")
    if tailiscope_ok then
      telescope.load_extension("tailiscope")
    else
      vim.notify("Tailiscope not found", vim.log.levels.ERROR)
      return
    end

    -- Keybinding to open Tailiscope for searching Tailwind CSS classes
    vim.keymap.set("n", "<leader>tw", ":Telescope tailiscope<CR>",
      { noremap = true, silent = true, desc = "Search Tailwind CSS classes" })
  end,
}

