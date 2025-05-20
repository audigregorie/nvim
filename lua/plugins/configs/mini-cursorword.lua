return {
"echasnovski/mini.cursorword",
lazy = true,           -- Load only when needed
event = "CursorMoved", -- Trigger on cursor movement
config = function()
  -- Safely load mini.cursorword to avoid runtime errors
  local ok, mini_cursorword = pcall(require, "mini.cursorword")
  if not ok then
    vim.notify("Failed to load mini.cursorword", vim.log.levels.ERROR)
    return
  end
  
  local setup_ok, setup_err = pcall(function()
    mini_cursorword.setup()
  end)
  if not setup_ok then
    vim.notify("Failed to setup mini.cursorword: " .. setup_err, vim.log.levels.ERROR)
    return
  end
end,
}
