return {
  "doctorfree/cheatsheet.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
  },

  config = function()
    -- Safely load telescope and cheatsheet extensions
    local telescope_ok, telescope = pcall(require, "telescope")
    if telescope_ok then
      telescope.load_extension("cheatsheet")
    else
      vim.notify("Telescope not found", vim.log.levels.ERROR)
      return
    end

    -- Keybinding to open the cheatsheet
    vim.keymap.set("n", "<leader>ch", ":Cheatsheet<CR>", { silent = true, noremap = true, desc = "Open Cheatsheet" })

    -- Safely load cheatsheet and telescope actions
    local cheatsheet_ok, cheatsheet = pcall(require, "cheatsheet")
    if not cheatsheet_ok then
      vim.notify("Cheatsheet not found", vim.log.levels.ERROR)
      return
    end

    local ctactions_ok, ctactions = pcall(require, "cheatsheet.telescope.actions")
    if not ctactions_ok then
      vim.notify("Cheatsheet Telescope actions not found", vim.log.levels.ERROR)
      return
    end

    cheatsheet.setup({
      bundled_cheatsheets = {
        enabled = {
          "default",
          "lua",
          "markdown",
          "regex",
          "netrw",
          "unicode",
        },
        disabled = {
          "nerd-fonts",
        },
      },

      bundled_plugin_cheatsheets = {
        enabled = {
          "auto-session",
          "goto-preview",
          "octo.nvim",
          "telescope.nvim",
          "vim-easy-align",
          "vim-sandwich",
        },
        disabled = {
          "gitsigns",
        },
      },

      include_only_installed_plugins = true,

      telescope_mappings = {
        ["<CR>"] = ctactions.select_or_fill_commandline,
        ["<A-CR>"] = ctactions.select_or_execute,
        ["<C-Y>"] = ctactions.copy_cheat_value,
        ["<C-E>"] = ctactions.edit_user_cheatsheet,
      },
    })
  end,
}

