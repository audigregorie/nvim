-- <> Telescope
return {
  -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system requirements installed.
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
    require("telescope").setup({
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
          -- theme = "ivy",
        },
        buffer = {
          sort_mru = true,
        },
        grep_string = {
          word_match = "-w",
        },
      },
      extensions = {
        file_browser = {
          mappings = {
            i = {
              ["<C-n>"] = function()
                require("telescope").extensions.file_browser.actions.create()
              end,
              ["<C-r>"] = function()
                require("telescope").extensions.file_browser.actions.rename()
              end,
              ["<C-l>"] = function()
                require("telescope").extensions.file_browser.actions.change_cwd()
              end,
              ["<C-h>"] = function()
                require("telescope").extensions.file_browser.actions.goto_parent_dir()
              end,
              ["<C-.>"] = function()
                require("telescope").extensions.file_browser.actions.toggle_hidden()
              end,
              ["<C-x>"] = function()
                require("telescope").extensions.file_browser.actions.remove()
              end,
            },
            n = {
              ["<C-n>"] = function()
                require("telescope").extensions.file_browser.actions.create()
              end,
              ["<C-r>"] = function()
                require("telescope").extensions.file_browser.actions.rename()
              end,
              ["l"] = function()
                require("telescope").extensions.file_browser.actions.change_cwd()
              end,
              ["h"] = function()
                require("telescope").extensions.file_browser.actions.goto_parent_dir()
              end,
              ["<C-.>"] = function()
                require("telescope").extensions.file_browser.actions.toggle_hidden()
              end,
              ["<C-x>"] = function()
                require("telescope").extensions.file_browser.actions.remove()
              end,
            },
          },
        },
        bookmarks = {
          selected_browser = "brave",
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
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

    -- Enable telescope fzf native, if installed
    pcall(require("telescope").load_extension, "fzf")

    -- Enable telescope ui select
    pcall(require("telescope").load_extension, "ui-select")

    -- File browser
    pcall(require("telescope").load_extension, "file_browser")
    vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

    -- Cheatsheet of commands
    pcall(require("telescope").load_extension("cheatsheet"))
    vim.keymap.set("n", "<leader>ch", ":Cheatsheet<CR>")

    -- Tailwind CSS guide
    pcall(require("telescope").load_extension("tailiscope"))
    vim.keymap.set("n", "<leader>tw", ":Telescope tailiscope<CR>")

    -- Enable telescope extension for nvim-notify
    pcall(require("telescope").load_extension, "notify")
    vim.keymap.set("n", "<leader>nt", ":Telescope notify<CR>", { desc = "Telescope [N]otifications" })
  end,
}
