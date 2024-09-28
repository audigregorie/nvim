-- <> TS context comment string
return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    local function save_cursor_position()
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      vim.b.saved_cursor_position = { row, col }
    end

    local function restore_cursor_position()
      local saved_position = vim.b.saved_cursor_position
      if saved_position then
        vim.api.nvim_win_set_cursor(0, saved_position)
      end
    end

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = save_cursor_position,
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
      callback = restore_cursor_position,
    })

    require('ts_context_commentstring').setup({
      context_commentstring = {
        enable = true,
        enable_autocmd = false, -- Prevent automatic updates if not needed
      },
    })
  end,
}
