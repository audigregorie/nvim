return {
  'stevearc/conform.nvim',
  opts = {},
  config = function(_, opts)
    -- Safely load conform.nvim to avoid runtime errors
    local ok, conform = pcall(require, "conform")
    if not ok then
      vim.notify("Conform plugin not found!", vim.log.levels.ERROR)
      return
    end

    conform.setup(opts)
  end,
}

