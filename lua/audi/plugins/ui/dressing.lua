return {
"stevearc/dressing.nvim",
config = function(_, opts)
  -- Safely load dressing.nvim to avoid runtime errors
  local ok, dressing = pcall(require, "dressing")
  if not ok then
    vim.notify("Failed to load dressing.nvim", vim.log.levels.ERROR)
    return
  end
  
  local setup_ok, setup_err = pcall(function()
    dressing.setup(opts or {})
  end)
  if not setup_ok then
    vim.notify("Failed to setup dressing.nvim: " .. setup_err, vim.log.levels.ERROR)
    return
  end
end,
}
