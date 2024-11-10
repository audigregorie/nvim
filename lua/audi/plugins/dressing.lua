return {
  "stevearc/dressing.nvim",
  config = function(_, opts)
    -- Safely load dressing.nvim to avoid runtime errors
    local ok, dressing = pcall(require, "dressing")
    if not ok then
      vim.notify("Dressing plugin not found!", vim.log.levels.ERROR)
      return
    end

    dressing.setup(opts or {})
  end,
}

