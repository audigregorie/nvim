return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "sudormrfbin/cheatsheet.nvim" },
    { "marianina8/tailiscope.nvim" },
    { "rcarriga/nvim-notify" },
  },

  config = function()
    local telescope_ok, telescope = pcall(require, "telescope")
    if not telescope_ok then
      vim.notify("Telescope not found!", vim.log.levels.ERROR)
      return
    end

    telescope.setup({
      defaults = {
        layout_strategy = "horizontal",
        -- layout_config = {
        --   height = 0.95,
        --   width = 0.6,
        --   prompt_position = "top",
        --   mirror = true,
        -- },
        mappings = {
          i = {
            ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
            ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-;>"] = require("telescope.actions").which_key,
            ["<C-x>"] = require("telescope.actions").delete_buffer,
          },
          n = {
            ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
            ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
            ["k"] = require("telescope.actions").move_selection_previous,
            ["j"] = require("telescope.actions").move_selection_next,
            ["<C-;>"] = require("telescope.actions").which_key,
            ["<C-x>"] = require("telescope.actions").delete_buffer,
            ["gg"] = require("telescope.actions").move_to_top,
            ["G"] = require("telescope.actions").move_to_bottom,
          },
        },
      },

      pickers = {
        find_files = {
          sort_mru = true,
          find_command = { "fd", "--type", "f", "--exclude", "node_modules" },
        },
        buffer = { sort_mru = true, },
        grep_string = { word_match = "-w", },
      },
    })

    -- Key mappings for Telescope built-ins
    vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
    vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
    vim.keymap.set("n", "<leader>/", function()
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ winblend = 10, previewer = false }))
    end, { desc = "[/] Fuzzily search in current buffer" })
    vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
    vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[F]ind [F]iles" })
    vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[F]ind [H]elp" })
    vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "[F]ind by [G]rep" })
    vim.keymap.set("n", "<leader>wd", require("telescope.builtin").diagnostics, { desc = "[W]orkspace [D]iagnostics" })
    vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers, { desc = "[S]earch [B]uffers" })
    vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols,
      { desc = "[D]ocument [S]ymbols" })
    vim.keymap.set("n", "<leader>qf", require("telescope.builtin").quickfix, { desc = "[Q]uick [F]ix" })
    vim.keymap.set("n", "<leader>gb", require("telescope.builtin").git_bcommits, { desc = "[G]it [B]commits" })
  end,
}
