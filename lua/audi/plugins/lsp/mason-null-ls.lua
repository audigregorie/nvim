return {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile", },
  dependencies = {
    "williamboman/mason.nvim",
    "jose-elias-alvarez/null-ls.nvim",
  },
  config = function()
    -- Safely load mason-null-ls
    local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
    if not mason_null_ls_ok then
      vim.notify("Mason Null ls not found!", vim.log.levels.ERROR)
      return
    end

    -- Configure mason-null-ls
    mason_null_ls.setup({
      -- Ensure these tools are installed by Mason
      ensure_installed = {
        "prettier", -- JavaScript/TypeScript/CSS formatter
        "stylua",   -- Lua formatter
        "jq",       -- JSON processor
      },
      -- Automatically install missing tools
      automatic_installation = true,
    })
  end,
}
