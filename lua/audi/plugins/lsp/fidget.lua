return {
  "j-hui/fidget.nvim",
  tag = "legacy",         -- Use the legacy version for backward compatibility
  event = { "BufEnter" }, -- Load Fidget on buffer enter

  config = function()
    -- Safely load Fidget to avoid errors
    local fidget_ok, fidget = pcall(require, "fidget")
    if not fidget_ok then
      vim.notify("Fidget not found!", vim.log.levels.ERROR)
      return
    end

    -- Fidget configuration for LSP progress display
    fidget.setup({
      text = {
        spinner = "dots_negative", -- Spinner style for progress indication
      },
    })
  end,
}
