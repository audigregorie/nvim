return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local ok, result = pcall(require, "nvim-treesitter.configs")
    if not ok then
      vim.notify("Failed to load nvim-treesitter.configs: " .. result, vim.log.levels.ERROR)
      return
    end
    local treesitter_configs = result
    local setup_ok, setup_err = pcall(function()
      treesitter_configs.setup({
        ensure_installed = {
          "html", "css", "javascript", "typescript", "tsx", "lua", "git_rebase",
          "gitcommit", "angular", "json", "markdown", "markdown_inline"
        },
        highlight = { enable = true },
        indent = { enable = true, },
        -- Add the missing required fields
        modules = {},
        sync_install = false,
        ignore_install = {},
        auto_install = true,
      })
    end)
    if not setup_ok then
      vim.notify("Failed to setup nvim-treesitter: " .. setup_err, vim.log.levels.ERROR)
      return
    end
    -- Optional: You can add additional operations here that might fail
    -- For example, if you want to do something with the parsers after setup:
    local post_setup_ok, post_setup_err = pcall(function()
      -- Any additional operations with treesitter
      -- For example, setting up a parser or custom configuration
    end)
    if not post_setup_ok then
      vim.notify("Failed to complete post-setup treesitter operations: " .. post_setup_err, vim.log.levels.WARN)
    end
  end,
}
