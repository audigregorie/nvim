return {
  "echasnovski/mini.cursorword",
  lazy = true,           -- Load only when needed
  event = "CursorMoved", -- Trigger on cursor movement

  config = function()
    -- Safely load mini.cursorword to avoid runtime errors
    local ok, mini_cursorword = pcall(require, "mini.cursorword")
    if not ok then
      vim.notify("mini.cursorword plugin not found!", vim.log.levels.ERROR)
      return
    end

    -- Set up the plugin
    mini_cursorword.setup()
  end,
}

