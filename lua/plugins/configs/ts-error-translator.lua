return {
  'dmmulroy/ts-error-translator.nvim',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim"
  },
  ft = {
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact"
  },
  config = function()
    -- Safe require with error handling
    local status_ok, ts_error_translator = pcall(require, "ts-error-translator")
    if not status_ok then
      vim.notify("ts-error-translator.nvim not found! Please make sure it's installed.", vim.log.levels.ERROR)
      return
    end

    -- Setup with error handling
    local setup_ok, err = pcall(function()
      ts_error_translator.setup({
        -- Custom error format function for better readability
        error_format = function(err)
          local filename = err.filename or "Unknown file"
          -- Get just the file name without the path for cleaner display
          local short_filename = filename:match("([^/\\]+)$") or filename

          return string.format(
            "TS Error: %s\nLocation: %s (line: %d, col: %d)",
            err.message or "Unknown error",
            short_filename,
            err.line or 0,
            err.column or 0
          )
        end,
        -- Additional options
        auto_translate = true,      -- Automatically translate errors
        highlight_group = "ErrorMsg", -- Use ErrorMsg highlight group
        show_full_file_path = false, -- Show shortened file paths
        format_lsp_message = true   -- Format LSP diagnostic messages
      })
    end)

    if not setup_ok then
      vim.notify("Error setting up ts-error-translator: " .. (err or "unknown error"), vim.log.levels.ERROR)
      return
    end

    -- Create user command for translation
    vim.api.nvim_create_user_command("TranslateTS", function()
      -- Get current diagnostics with error handling
      local get_diag_ok, diagnostics = pcall(vim.diagnostic.get, 0)
      if not get_diag_ok or not diagnostics or #diagnostics == 0 then
        vim.notify("No diagnostics found in current buffer", vim.log.levels.INFO)
        return
      end

      -- Translate with error handling
      local translate_ok, result = pcall(ts_error_translator.translate_error, diagnostics)
      if not translate_ok then
        vim.notify("Failed to translate TypeScript error: " .. (result or "unknown error"), vim.log.levels.ERROR)
      end
    end, { desc = "Translate TypeScript Error" })

    -- Key mappings with descriptive comments
    -- Keybinding to translate errors on current line
    vim.keymap.set('n', '<leader>tr', function()
      local diag_ok, diagnostics = pcall(vim.diagnostic.get, 0)
      if diag_ok and diagnostics and #diagnostics > 0 then
        pcall(ts_error_translator.translate_error, diagnostics)
      else
        vim.notify("No diagnostics found", vim.log.levels.INFO)
      end
    end, { noremap = true, silent = true, desc = "Translate TypeScript Error" })

    -- Translate and show in floating window
    vim.keymap.set('n', '<leader>tR', function()
      local diag_ok, diagnostics = pcall(vim.diagnostic.get, 0)
      if diag_ok and diagnostics and #diagnostics > 0 then
        local translate_ok, translated = pcall(ts_error_translator.translate_error, diagnostics)
        if translate_ok and translated then
          vim.diagnostic.open_float(nil, { scope = "line" })
        end
      else
        vim.notify("No diagnostics found", vim.log.levels.INFO)
      end
    end, { noremap = true, silent = true, desc = "Translate TS Error & Show Float" })

    -- Integration with Trouble.nvim
    if pcall(require, "trouble") then
      -- Open translated errors in Trouble
      vim.keymap.set('n', '<leader>tt', function()
        local diag_ok, diagnostics = pcall(vim.diagnostic.get, 0)
        if diag_ok and diagnostics and #diagnostics > 0 then
          pcall(ts_error_translator.translate_error, diagnostics)
          vim.cmd("Trouble diagnostics toggle")
        else
          vim.notify("No diagnostics found", vim.log.levels.INFO)
        end
      end, { noremap = true, silent = true, desc = "Translate TS Error & Open Trouble" })
    end

    -- Set up autocommands with error handling
    local augroup = vim.api.nvim_create_augroup("TSErrorTranslator", { clear = true })

    -- Highlight errors when buffer is written
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = augroup,
      pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
      callback = function()
        pcall(vim.highlight.on_yank, { higroup = "ErrorMsg", timeout = 500 })

        -- Only show diagnostics if they exist
        local diag_ok, diagnostics = pcall(vim.diagnostic.get, 0)
        if diag_ok and diagnostics and #diagnostics > 0 then
          -- Translate errors first
          pcall(ts_error_translator.translate_error, diagnostics)
          -- Then show floating window with a small delay
          vim.defer_fn(function()
            pcall(vim.diagnostic.open_float, nil, { scope = "line" })
          end, 100)
        end
      end,
      desc = "Highlight and translate TypeScript errors on save"
    })
  end,
}
