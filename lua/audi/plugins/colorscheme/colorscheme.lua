-- # Colorscheme

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
      -- options = {
      --   comment_style = "italic",
      --   keyword_style = "italic",
      -- }
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


-- ## github-nvim-theme
-- return {
--   "projekt0n/github-nvim-theme",
--   lazy = false,
--   priority = 1000,
--   opts = {},

--   config = function()
--     local ok, github_theme = pcall(require, 'github-theme')

--     if not ok then
--       vim.notify("Failed to load github-nvim-theme", vim.log.levels.ERROR)
--       return
--     end

--     -- Plugin configuration
--     github_theme.setup({
--       options = {
--         styles = {
--           comment = "italic",
--           -- keyword = "bold",
--           -- functions = "bold",
--           -- variable = "none",
--         },
--         sidebars = { "qf", "vista_kind", "terminal", "packer" },
--         dark_sidebar = true,
--         colors = {},
--       },
--     })

--     -- Apply the colorscheme
--     local colorscheme_ok = pcall(vim.cmd, "colorscheme github_dark")

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


--     if not colorscheme_ok then
--       vim.notify("Failed to apply github-nvim-theme colorscheme", vim.log.levels.ERROR)
--     end
--   end
-- }


-- ## Tokyonight
-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},

--   config = function()
--     local ok, tokyonight = pcall(require, 'tokyonight')

--     if not ok then
--       vim.notify("Failed to load tokyonight.nvim", vim.log.levels.ERROR)
--       return
--     end

--     -- Plugin configuration
--     tokyonight.setup({
--       style = "night", -- Options: "storm", "night", "day", "moon"
--       transparent = false,
--       terminal_colors = true,
--       styles = {
--         comments = { italic = true },
--         keywords = { italic = false },
--         functions = {},
--         variables = {},
--         sidebars = "dark",
--         floats = "dark",
--       },
--       on_colors = function(_)
--         -- Customize specific colors (currently unused)
--       end,
--       on_highlights = function(_, _)
--         -- Customize highlights (currently unused)
--       end,
--     })

--     -- Apply the colorscheme
--     local colorscheme_ok = pcall(vim.cmd, "colorscheme tokyonight")

--     if not colorscheme_ok then
--       vim.notify("Failed to apply tokyonight colorscheme", vim.log.levels.ERROR)
--     end
--   end
-- }
