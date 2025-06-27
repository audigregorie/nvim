return {
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  "Mofiqul/vscode.nvim",
  priority = 1000,   -- Make sure to load this before all the other start plugins.
  config = function()
    require("vscode").setup({
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
        comments = { italic = false },   -- Disable italics in comments
      },
      -- Optional: enables terminal colors matching the theme
      terminal_colors = true,
      italic_comments = true,
      underline_links = true,
      -- Transparent backgrounds and borders for various UI elements
      group_overrides = {
        NormalFloat = { bg = "NONE" },
        VertSplit = { fg = "#000000" },
        FloatBorder = { fg = "#252525" },
        Pmenu = { bg = "NONE" },
        -- StatusLine = { bg = "NONE" },
        -- StatusLineNC = { bg = "NONE" },
        -- PmenuSel = { bg = "NONE" },
        -- NormalNC = { bg = "NONE" },
        -- LineNr = { bg = "NONE" },
        -- SignColumn = { bg = "NONE" },
        -- EndOfBuffer = { bg = "NONE" },
        -- TelescopeBorder = { fg = "#252525" },
      },
    })
    -- Load the colorscheme here.
    vim.cmd.colorscheme("vscode")
  end,
}
