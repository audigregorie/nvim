-- # Colorscheme

-- ## github-nvim-theme
return {
  'projekt0n/github-nvim-theme',
  lazy = false,
  priority = 1000,
  config = function()
    local ok, result = pcall(require, 'github-theme')
    if not ok then
      vim.notify("Failed to load github-nvim-theme: " .. result, vim.log.levels.ERROR)
      return
    end

    local github_theme = result

    local setup_ok, setup_err = pcall(function()
      github_theme.setup({
        options = {
          theme_style = "dark_dimmed",
          transparent = false,
          comment_style = "italic",
          keyword_style = "italic"
        }
      })
    end)

    if not setup_ok then
      vim.notify("Failed to setup github-nvim-theme: " .. setup_err, vim.log.levels.ERROR)
      return
    end

    local theme_ok, theme_err = pcall(function()
      vim.cmd('colorscheme github_dark_dimmed')
    end)

    if not theme_ok then
      vim.notify("Failed to apply github_dark_dimmed colorscheme: " .. theme_err, vim.log.levels.WARN)
    end
  end,
}
