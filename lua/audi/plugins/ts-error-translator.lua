return {
  'dmmulroy/ts-error-translator.nvim',
  dependencies = { "nvim-lua/plenary.nvim", "folke/trouble.nvim" },          -- Ensure dependencies are installed
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" }, -- Load only for relevant files
  config = function()
    local ts_error_translator = require("ts-error-translator")

    -- Setup the ts-error-translator with error formatting
    ts_error_translator.setup({
      error_format = function(err)
        return string.format(
          "Error: %s at %s (line: %d, col: %d)",
          err.message or "Unknown error",
          err.filename or "Unknown file",
          err.line or 0,
          err.column or 0
        )
      end,
      highlight_group = "ErrorMsg", -- Customize error highlight
    })

    -- Keybinding to translate errors on current line or current diagnostic
    vim.api.nvim_set_keymap('n', '<leader>tr',
      ":lua require('ts-error-translator').translate_error(vim.diagnostic.get(0))<CR>",
      { noremap = true, silent = true, desc = "Translate TypeScript Error" })

    -- Integrating with Trouble.nvim (optional)
    -- vim.api.nvim_set_keymap('n', '<leader>tt', ':TroubleToggle<CR>',
    --   { noremap = true, silent = true, desc = "Toggle Trouble" })

    -- Highlight errors when buffer is written (optional for visibility)
    vim.cmd([[autocmd BufWritePost *.ts,*.tsx,*.js,*.jsx lua vim.highlight.on_yank {higroup="ErrorMsg", timeout=500}]])

    -- Show diagnostics in floating window on save
    vim.cmd([[
      autocmd BufWritePost *.ts,*.tsx,*.js,*.jsx lua vim.diagnostic.open_float(nil, { scope = "line" })
    ]])
  end,
}
