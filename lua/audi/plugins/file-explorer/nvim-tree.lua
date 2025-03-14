return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local ok, nvim_tree = pcall(require, "nvim-tree")
    if not ok then
      vim.notify("Failed to load nvim-tree: " .. tostring(nvim_tree), vim.log.levels.ERROR)
      return
    end

    local setup_ok, setup_err = pcall(function()
      nvim_tree.setup({
        disable_netrw = true,
        hijack_netrw = true,
        view = {
          width = 55,
          relativenumber = true,
          side = "left",
        },
        filters = {
          dotfiles = true,
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          icons = {
            hint = "H",
            info = "I",
            warning = "W",
            error = "E",
          },
        },
        log = {
          enable = true,
          truncate = true,
          types = {
            diagnostics = true,
          },
        },
        renderer = {
          group_empty = true,
          highlight_opened_files = "name",
          icons = {
            web_devicons = {
              file = {
                enable = true,
                color = true,
              },
              folder = {
                enable = false,
                -- enable = true,
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
              default = "",
              symlink = "",
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                deleted = "",
                untracked = "★",
                ignored = "◌",
              },
              folder = {
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
            },
          },
        },
      })
    end)

    if not setup_ok then
      vim.notify("Failed to setup nvim-tree: " .. tostring(setup_err), vim.log.levels.ERROR)
      return
    end

    -- Create default options for keymaps
    local default_opts = { noremap = true, silent = true }

    -- Add keymaps after successful setup
    local keymap_ok, keymap_err = pcall(function()
      vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>",
        vim.tbl_extend("force", default_opts, { desc = "Toggle NvimTree" }))
    end)

    if not keymap_ok then
      vim.notify("Failed to setup nvim-tree keymaps: " .. tostring(keymap_err), vim.log.levels.WARN)
    end

    -- Add an autocommand to close nvim-tree when exiting Vim
    vim.api.nvim_create_autocmd("QuitPre", {
      callback = function()
        local tree_wins = {}
        local floating_wins = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match("NvimTree_") ~= nil then
            table.insert(tree_wins, w)
          end
          if vim.api.nvim_win_get_config(w).relative ~= "" then
            table.insert(floating_wins, w)
          end
        end
        if 1 == #wins - #floating_wins - #tree_wins then
          -- Should quit, so we close all invalid windows.
          for _, w in ipairs(tree_wins) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end
    })
  end,
}
