return {
  {
    "tpope/vim-commentary",
    event = { "BufReadPost", "BufNewFile" }, -- Lazy load on buffer read/creation
    keys = {
      { "gc",  desc = "Comment operator" },
      { "gcc", desc = "Comment line" },
    },
    config = function()
      -- Handle potential errors during setup
      local status_ok, _ = pcall(function()
        -- Keymaps for easier commenting with descriptive help text
        vim.keymap.set("n", "gcc", "<Plug>CommentaryLine", {
          noremap = false,
          silent = true,
          desc = "Comment out current line"
        })

        vim.keymap.set("v", "gc", "<Plug>Commentary", {
          noremap = false,
          silent = true,
          desc = "Comment out selection"
        })

        vim.keymap.set("o", "gc", "<Plug>Commentary", {
          noremap = false,
          silent = true,
          desc = "Comment target of motion"
        })

        -- Add file type specific comment strings for languages that need special handling
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "c,cpp,cs,java",
          callback = function()
            vim.bo.commentstring = "// %s"
          end,
          desc = "Set C-style comments"
        })

        vim.api.nvim_create_autocmd("FileType", {
          pattern = "sql",
          callback = function()
            vim.bo.commentstring = "-- %s"
          end,
          desc = "Set SQL comments"
        })

        vim.api.nvim_create_autocmd("FileType", {
          pattern = "html,xml",
          callback = function()
            vim.bo.commentstring = "<!-- %s -->"
          end,
          desc = "Set HTML/XML comments"
        })

        -- Performance optimization: only process commentstring on relevant files
        vim.api.nvim_create_autocmd("BufEnter", {
          callback = function()
            -- Check if filetype is set before processing
            if vim.bo.filetype ~= "" then
              -- Pre-calculate commentstring to avoid runtime overhead
              if vim.bo.commentstring == "" then
                -- Default to double slash comments if not set
                vim.bo.commentstring = "// %s"
              end
            end
          end,
          desc = "Ensure commentstring is set for all files"
        })
      end)

      -- Notify user if there was an error during setup
      if not status_ok then
        vim.notify("Error setting up vim-commentary: " .. (status_ok or "Unknown error"),
          vim.log.levels.ERROR)
      end
    end,
    -- Command for manual loading if needed
    cmd = { "Commentary" },
  }
}

