-- # Colorscheme

-- ## github-nvim-theme

-- Github-nvim-theme
-- return {
--   'projekt0n/github-nvim-theme',
--   config = function()
--     local status_ok, github_theme = pcall(require, 'github-theme')
--     if not status_ok then
--       vim.notify("Failed to load github-nvim-theme", vim.log.levels.ERROR)
--       return
--     end

--     -- Try to set up the theme with protected call
--     local setup_ok, _ = pcall(function()
--       github_theme.setup({
--         options = {
--           theme_style = "dark_dimmed", -- Match this with the colorscheme name
--           transparent = false,
--           comment_style = "italic",
--           keyword_style = "italic",
--           function_style = "NONE",
--           variable_style = "NONE",
--           contrast = "normal",
--           hide_inactive_statusline = false,
--           hide_end_of_buffer = true,
--           dark_float = true,
--           dark_sidebar = true,
--           colors_override = {},
--         }
--       })
--     end)

--     if not setup_ok then
--       vim.notify("Failed to set up github-nvim-theme", vim.log.levels.WARN)
--     end

--     -- Try to apply the colorscheme with protected call
--     local colorscheme_ok, err = pcall(vim.cmd, 'colorscheme github_dark_dimmed')
--     if not colorscheme_ok then
--       vim.notify("Failed to apply colorscheme: " .. err, vim.log.levels.WARN)
--       -- Optionally set a fallback colorscheme
--       pcall(vim.cmd, 'colorscheme default')
--     end
--   end,
-- }


-- ## Vscode
return {
  "Mofiqul/vscode.nvim",
  config = function()
    -- Safely load vscode.nvim to prevent runtime errors
    local ok, vscode = pcall(require, "vscode")
    if not ok then
      vim.notify("vscode.nvim not found!", vim.log.levels.ERROR)
      return
    end

    -- Setup vscode theme with integrations and options
    vscode.setup({
      -- integrations = {
      --   cmp = true,        -- Enable nvim-cmp integration
      --   fidget = true,     -- Enable fidget integration for LSP progress
      --   gitsigns = true,   -- Enable gitsigns integration
      --   harpoon = true,    -- Enable harpoon integration
      --   indent_blankline = {
      --     enabled = false, -- Disable indent_blankline integration
      --     scope_color = "sapphire",
      --     colored_indent_levels = false,
      --   },
      --   mason = true,                    -- Enable Mason integration
      --   native_lsp = { enabled = true }, -- Enable native LSP integration
      --   noice = true,                    -- Enable Noice integration for notifications
      --   notify = true,                   -- Enable nvim-notify integration
      --   symbols_outline = true,          -- Enable symbols outline integration
      --   telescope = true,                -- Enable Telescope integration
      --   treesitter = true,               -- Enable Treesitter integration
      --   treesitter_context = true,       -- Enable Treesitter context integration
      -- },
    })

    -- Apply the vscode colorscheme
    vim.cmd.colorscheme("vscode")

    -- Hide all semantic highlights until upstream issues are resolved
    -- Reference: https://github.com/catppuccin/nvim/issues/480
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end
  end,
}

-- ## Github Theme
-- return {
--   'projekt0n/github-nvim-theme',
--   priority = 1000, -- Ensure it loads before other plugins
--   lazy = false,
--   opts = {
--     options = {
--       -- Customize style
--       theme_style = "dimmed", -- Options: 'dark', 'dimmed', 'dark_default', 'dark_colorblind', 'light', 'light_default', 'light_colorblind'
--       transparent = false,    -- Make background transparent
--       dim_inactive = false,   -- Dim inactive windows
--       styles = {
--         comments = "italic",
--       },
--     },
--   },
--   config = function(_, opts)
--     -- Setup theme with options
--     require('github-theme').setup(opts)

--     -- Set colorscheme
--     vim.cmd('colorscheme github_dark_dimmed')

--     -- Define custom highlights
--     local custom_highlights = {
--       -- Keywords (return, if, etc.) - soft orange
--       Keyword = { fg = "#F9A959", italic = true },
--       Statement = { fg = "#F9A959", italic = true },
--       Conditional = { fg = "#F9A959", italic = true },
--       Repeat = { fg = "#F9A959", italic = true },
--       Exception = { fg = "#F9A959", italic = true },
--       -- Operator = { fg = "#F9A959" },

--       -- Variable names, types and interfaces - white
--       Identifier = { fg = "#FFFFFF" },
--       Variable = { fg = "#FFFFFF" },
--       Type = { fg = "#FFFFFF" },
--       Structure = { fg = "#FFFFFF" },
--       Typedef = { fg = "#FFFFFF" },
--       StorageClass = { fg = "#FFFFFF" },

--       -- Function names - soft purple
--       Function = { fg = "#C792EA" },
--       Method = { fg = "#C792EA" },
--     }

--     -- Apply highlights
--     for group, settings in pairs(custom_highlights) do
--       vim.api.nvim_set_hl(0, group, settings)
--     end

-- Hide all semantic highlights until upstream issues are resolved
-- Reference: https://github.com/catppuccin/nvim/issues/480
-- for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
--   vim.api.nvim_set_hl(0, group, {})
-- end

--   end,
-- }
