-- <> Nvim TS context commentstring
return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  event = { "BufReadPost", "BufNewFile" }, -- Lazy load for better performance
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function(_, opts)
    -- Function to save cursor position on buffer write
    local function save_cursor_position()
      vim.b.saved_cursor_position = vim.api.nvim_win_get_cursor(0)
    end

    -- Function to restore cursor position after buffer write
    local function restore_cursor_position()
      local saved_position = vim.b.saved_cursor_position
      if saved_position then
        local row = saved_position[1]
        local total_lines = vim.api.nvim_buf_line_count(0)
        -- Only restore if the saved row is within the buffer
        if row <= total_lines then
          pcall(vim.api.nvim_win_set_cursor, 0, saved_position)
        end
      end
    end

    -- Autocommands to save and restore cursor position
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = save_cursor_position,
      desc = "Save cursor position before writing buffer",
    })
    vim.api.nvim_create_autocmd("BufWritePost", {
      callback = restore_cursor_position,
      desc = "Restore cursor position after writing buffer",
    })

    -- Setup ts-context-commentstring plugin with merged options
    require('ts_context_commentstring').setup(vim.tbl_deep_extend("force", {
      enable = true,
      enable_autocmd = false, -- Disable automatic context updates for performance
    }, opts or {}))
  end,
}
