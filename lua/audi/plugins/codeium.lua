return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },

  config = function()
    -- Safely load codeium to avoid runtime errors
    local ok, codeium = pcall(require, "codeium")
    if not ok then
      vim.notify("Codeium plugin not found!", vim.log.levels.ERROR)
      return
    end

    -- Safely load nvim-cmp to ensure it works with Codeium
    local cmp_ok, _ = pcall(require, "cmp")
    if not cmp_ok then
      vim.notify("nvim-cmp not found!", vim.log.levels.ERROR)
      return
    end

    codeium.setup({})
  end,
}

