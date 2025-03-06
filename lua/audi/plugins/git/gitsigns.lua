return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local ok, gitsigns = pcall(require, "gitsigns")
    if not ok then
      vim.notify("Failed to load gitsigns.nvim: " .. tostring(gitsigns), vim.log.levels.ERROR)
      return
    end

    local setup_ok, setup_err = pcall(function()
      gitsigns.setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        on_attach = function(bufnr)
          -- Safely get gitsigns from loaded packages
          local gs_ok, gs = pcall(function() return package.loaded.gitsigns end)
          if not gs_ok then
            vim.notify("Failed to get gitsigns from package.loaded", vim.log.levels.WARN)
            return
          end

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            local keymap_ok, keymap_err = pcall(vim.keymap.set, mode, l, r, opts)
            if not keymap_ok then
              vim.notify("Failed to set keymap " .. mode .. " " .. l .. ": " .. tostring(keymap_err), vim.log.levels
              .WARN)
            end
          end

          -- Navigation
          local nav_next_ok, _ = pcall(function()
            map("n", "]c", function()
              if vim.wo.diff then return "]c" end
              vim.schedule(function() gs.next_hunk() end)
              return "<Ignore>"
            end, { expr = true, desc = "Next git hunk" })
          end)

          if not nav_next_ok then
            vim.notify("Failed to set next hunk navigation", vim.log.levels.WARN)
          end

          local nav_prev_ok, _ = pcall(function()
            map("n", "[c", function()
              if vim.wo.diff then return "[c" end
              vim.schedule(function() gs.prev_hunk() end)
              return "<Ignore>"
            end, { expr = true, desc = "Previous git hunk" })
          end)

          if not nav_prev_ok then
            vim.notify("Failed to set previous hunk navigation", vim.log.levels.WARN)
          end

          -- Actions
          local actions_ok, actions_err = pcall(function()
            map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
            map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
            map("n", "<leader>hb", function() gs.blame_line { full = true } end, { desc = "Blame line" })
            map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })

            -- Additional useful mappings
            map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
            map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
            map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
            map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
            map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })
          end)

          if not actions_ok then
            vim.notify("Failed to set gitsigns actions: " .. tostring(actions_err), vim.log.levels.WARN)
          end
        end
      })
    end)

    if not setup_ok then
      vim.notify("Failed to setup gitsigns.nvim: " .. tostring(setup_err), vim.log.levels.ERROR)
    end
  end,
}
