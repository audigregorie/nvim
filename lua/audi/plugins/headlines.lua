return {
  "lukas-reineke/headlines.nvim",
  config = function()
    -- Safely load headlines.nvim to avoid runtime errors
    local ok, headlines = pcall(require, "headlines")
    if not ok then
      vim.notify("Headlines plugin not found!", vim.log.levels.ERROR)
      return
    end

    -- Set up highlighting using Lua-native API
    vim.api.nvim_set_hl(0, "Headline1", { fg = "#d78700" })
    vim.api.nvim_set_hl(0, "Headline2", { fg = "#87afff" })
    vim.api.nvim_set_hl(0, "Headline3", { fg = "#d75f87" })
    vim.api.nvim_set_hl(0, "CodeBlock", { bg = "#202020" })

    headlines.setup({
      markdown = {
        headline_highlights = {
          "Headline1",
          "Headline2",
          "Headline3",
        },
        fat_headlines = false, -- Disable fat headlines
        bullets = "",          -- Set bullets to empty string (can be customized)
      },
    })
  end,
}

