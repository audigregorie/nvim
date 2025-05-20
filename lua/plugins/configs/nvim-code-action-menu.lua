return {
  "weilbith/nvim-code-action-menu",
  cmd = "CodeActionMenu", -- Lazy-load on command
  config = function()
    local ok, code_action_menu = pcall(require, "nvim-code-action-menu")
    if not ok then
      vim.notify("Failed to load nvim-code-action-menu: " .. tostring(code_action_menu), vim.log.levels.ERROR)
      return
    end

    -- Setup options
    local setup_ok, setup_err = pcall(function()
      -- Configure global options
      vim.g.code_action_menu_window_border = "rounded"
      vim.g.code_action_menu_show_details = true
      vim.g.code_action_menu_show_diff = true
      vim.g.code_action_menu_show_action_kind = true
    end)
    if not setup_ok then
      vim.notify("Failed to setup nvim-code-action-menu options: " .. tostring(setup_err), vim.log.levels.ERROR)
      return
    end

    -- Setup keymaps
    local keymap_ok, keymap_err = pcall(function()
      vim.keymap.set("n", "<leader>cm", ":CodeActionMenu<CR>",
        { silent = true, noremap = true, desc = "Code Action Menu" })
    end)
    if not keymap_ok then
      vim.notify("Failed to setup nvim-code-action-menu keymaps: " .. tostring(keymap_err), vim.log.levels.WARN)
    end
  end,
}
