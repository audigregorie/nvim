-- <> Nvim-tree
return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    vim.g.loaded_netrw = 1                     -- Disable netrw at the very start of your init.lua
    vim.g.loaded_netrwPlugin = 1               -- Disable netrwPlugin at the very start of your init.lua
    vim.g.nvim_tree_highlight_opened_files = 1 -- Enable highlighting of opened files in nvim-tree
    vim.g.nvim_tree_highlight_modified = 1     -- Enable highlighting of modified files in nvim-tree

    -- Standard left positioned nvim-tree window
    require("nvim-tree").setup({
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      sort_by = "case_sensitive",
      view = {
        width = 55,
        -- relativenumber = true,
        side = "left",
        -- side = "right",
        signcolumn = "yes",
      },
      log = {
        enable = true,
        truncate = true,
        types = {
          diagnostics = true,
        },
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      renderer = {
        group_empty = true,
        root_folder_label = ":~:s?$?/..?",
        indent_width = 3,
        special_files = {
          "Cargo.toml",
          "Makefile",
          "README.md",
          "readme.md"
        },
        symlink_destination = true,
        highlight_git = false,
        highlight_diagnostics = true,
        highlight_opened_files = "name",
        highlight_modified = "none",
        highlight_bookmarks = "none",
        highlight_clipboard = "none",
        indent_markers = {
          -- enable = true,
          enable = false,
          inline_arrows = true,
          icons = {
            -- corner = "└",
            corner = " ",
            edge = "│ ",
            item = "│ ",
            -- bottom = "─",
            bottom = " ",
            none = " ",
          },
        },
        icons = {
          web_devicons = {
            file = {
              enable = true,
              color = true,
            },
            folder = {
              enable = false,
              color = true,
            },
          },
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
            diagnostics = true,
            bookmarks = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "󰆤",
            modified = "●",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              -- arrow_closed = "●",
              -- arrow_open = "○",
              default = "",
              open = "",
              empty = "",
              -- open = "",
              -- empty = "○",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
          },
        },
      },
      filters = {
        -- show hidden files using 'shift + h'
        dotfiles = false,
        custom = { 'dist' },
      },
    })
    vim.keymap.set("n",
      "<leader>t",
      ":NvimTreeToggle<CR>",
      { desc = "Open Nvim Tree"
      })
  end,
}
