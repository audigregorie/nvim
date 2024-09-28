-- <> Mason Null-ls
return {
  "jay-babu/mason-null-ls.nvim",
  event = {
    "BufReadPre",
    "BufNewFile"
  },
  dependencies = {
    "williamboman/mason.nvim",
    "jose-elias-alvarez/null-ls.nvim"
  },
  config = function()
    -- Load mason-null-ls and configure it
    require("mason-null-ls").setup({
      -- Ensure the specified language servers are installed
      ensure_installed = {
        "prettier",
        "stylua",
        "jq"
      },
      -- Automatically install missing language servers
      automatic_installation = true,
    })
  end,
}
