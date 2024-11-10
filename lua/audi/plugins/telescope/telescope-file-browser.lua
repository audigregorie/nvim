return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },

  config = function()
    -- Safely load telescope
    local telescope_ok, telescope = pcall(require, "telescope")
    if not telescope_ok then
      vim.notify("Telescope not found!", vim.log.levels.ERROR)
      return
    end

    -- Load file_browser extension
    local file_browser_ok = pcall(telescope.load_extension, "file_browser")
    if not file_browser_ok then
      vim.notify("Telescope file browser extension not found!", vim.log.levels.ERROR)
      return
    end

    -- Keybinding for opening the file browser
    vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {
      noremap = true,
      silent = true,
      desc = "Open File Browser"
    })


    -- Configure telescope with the file_browser settings
    telescope.setup({
      extensions = {
        file_browser = {
          hidden = true,    -- Show hidden files
          -- respect_gitignore = false, -- Ignore .gitignore
          grouped = true,   -- Group files/folders in display

          mappings = {
            ["i"] = {
              -- Insert mode mappings
              ["<C-n>"] = telescope.extensions.file_browser.actions.create,
              ["<C-r>"] = telescope.extensions.file_browser.actions.rename,
              ["<C-l>"] = telescope.extensions.file_browser.actions.change_cwd,
              ["<C-h>"] = telescope.extensions.file_browser.actions.goto_parent_dir,
              ["<C-.>"] = telescope.extensions.file_browser.actions.toggle_hidden,
              ["<C-x>"] = telescope.extensions.file_browser.actions.remove,
            },
            ["n"] = {
              -- Normal mode mappings
              ["<C-n>"] = telescope.extensions.file_browser.actions.create,
              ["<C-r>"] = telescope.extensions.file_browser.actions.rename,
              ["l"] = telescope.extensions.file_browser.actions.change_cwd,
              ["h"] = telescope.extensions.file_browser.actions.goto_parent_dir,
              ["<C-.>"] = telescope.extensions.file_browser.actions.toggle_hidden,
              ["<C-x>"] = telescope.extensions.file_browser.actions.remove,
            },
          },
        },
      },
    })
  end,
}
