-- Catppuccin
-- ================================
-- return {
--   "catppuccin/nvim",
--   config = function()
--     -- Safely load catppuccin to avoid runtime errors
--     local ok, catppuccin = pcall(require, "catppuccin")
--     if not ok then
--       vim.notify("catppuccin.nvim not found!", vim.log.levels.ERROR)
--       return
--     end

--     -- Setup catppuccin with integrations and options
--     catppuccin.setup({
--       integrations = {
--         cmp = true,                 -- Enable integration with nvim-cmp
--         fidget = true,              -- Enable fidget integration for LSP progress
--         gitsigns = true,            -- Enable gitsigns integration
--         harpoon = true,             -- Enable harpoon integration
--         indent_blankline = {
--           enabled = false,          -- Disable indent_blankline integration
--           scope_color = "sapphire", -- Set scope color for indent guides
--           colored_indent_levels = false,
--         },
--         mason = true,                    -- Enable Mason integration
--         native_lsp = { enabled = true }, -- Enable native LSP integration
--         noice = true,                    -- Enable Noice integration for better notifications
--         notify = true,                   -- Enable nvim-notify integration
--         symbols_outline = true,          -- Enable symbols outline integration
--         telescope = true,                -- Enable Telescope integration
--         treesitter = true,               -- Enable Treesitter integration
--         treesitter_context = true,       -- Enable Treesitter context integration
--         nvimtree = true,                 -- Enable nvim-tree integration
--       },
--     })

--     -- Apply the Catppuccin color scheme
--     vim.cmd.colorscheme("catppuccin-macchiato")

--     -- Hide all semantic highlights until upstream issues are resolved
--     -- Reference: https://github.com/catppuccin/nvim/issues/480
--     for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
--       vim.api.nvim_set_hl(0, group, {})
--     end
--   end,
-- }


-- Vscode
-- ================================
-- return {
--   "Mofiqul/vscode.nvim",
--   config = function()
--     -- Safely load vscode.nvim to prevent runtime errors
--     local ok, vscode = pcall(require, "vscode")
--     if not ok then
--       vim.notify("vscode.nvim not found!", vim.log.levels.ERROR)
--       return
--     end

--     -- Setup vscode theme with integrations and options
--     vscode.setup({
--       integrations = {
--         cmp = true,        -- Enable nvim-cmp integration
--         fidget = true,     -- Enable fidget integration for LSP progress
--         gitsigns = true,   -- Enable gitsigns integration
--         harpoon = true,    -- Enable harpoon integration
--         indent_blankline = {
--           enabled = false, -- Disable indent_blankline integration
--           scope_color = "sapphire",
--           colored_indent_levels = false,
--         },
--         mason = true,                    -- Enable Mason integration
--         native_lsp = { enabled = true }, -- Enable native LSP integration
--         noice = true,                    -- Enable Noice integration for notifications
--         notify = true,                   -- Enable nvim-notify integration
--         symbols_outline = true,          -- Enable symbols outline integration
--         telescope = true,                -- Enable Telescope integration
--         treesitter = true,               -- Enable Treesitter integration
--         treesitter_context = true,       -- Enable Treesitter context integration
--       },
--     })

--     -- Apply the vscode colorscheme
--     vim.cmd.colorscheme("vscode")

--     -- Hide all semantic highlights until upstream issues are resolved
--     -- Reference: https://github.com/catppuccin/nvim/issues/480
--     for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
--       vim.api.nvim_set_hl(0, group, {})
--     end
--   end,
-- }


-- Github-colors
-- ================================
return {
  'lourenci/github-colors',
  run = ':TSUpdate', -- Ensure Treesitter parsers are updated

  config = function()
    -- Safely load Treesitter configuration and colorscheme
    local ts_ok, treesitter_configs = pcall(require, 'nvim-treesitter.configs')
    if not ts_ok then
      vim.notify("nvim-treesitter not found!", vim.log.levels.ERROR)
      return
    end

    local color_ok, _ = pcall(vim.cmd.colorscheme, "github-colors")
    if not color_ok then
      vim.notify("Colorscheme 'github-colors' not found!", vim.log.levels.ERROR)
      return
    end

    -- Configure Treesitter with highlighting enabled
    treesitter_configs.setup {
      highlight = {
        enable = true, -- Enable Treesitter highlighting
      }
    }
  end,
}


-- Rasmus
-- ================================
-- return {
--   "kvrohit/rasmus.nvim",
--   lazy = false,    -- Load immediately
--   priority = 1000, -- High priority to load the colorscheme first

--   config = function()
--     -- Safely apply the colorscheme to avoid runtime errors
--     local ok, _ = pcall(vim.cmd.colorscheme, "rasmus")
--     if not ok then
--       vim.notify("Colorscheme 'rasmus' not found!", vim.log.levels.ERROR)
--       return
--     end
--   end,
-- }


-- Zenbones
-- ================================
-- return {
--   "zenbones-theme/zenbones.nvim",
--   dependencies = {
--     { "rktjmp/lush.nvim", opt = true },
--   },
--   lazy = false,    -- Load immediately
--   priority = 1000, -- High priority to ensure it loads first

--   config = function()
--     -- Safely apply the colorscheme to avoid runtime errors
--     local ok, _ = pcall(vim.cmd.colorscheme, "zenbones")
--     if not ok then
--       vim.notify("Colorscheme 'zenbones' not found!", vim.log.levels.ERROR)
--       return
--     end

--     -- Set compatibility mode if Lush is not installed (for Vim compatibility)
--     if not pcall(require, "lush") then
--       vim.g.zenbones_compat = 1
--     end
--   end,
-- }


-- Monochrome
-- ================================
-- return {
--   "kdheepak/monochrome.nvim",
--   lazy = false, -- Load immediately
--   priority = 1000, -- High priority to load the colorscheme first

--   config = function()
--     -- Safely apply the colorscheme to avoid runtime errors
--     local ok, _ = pcall(vim.cmd.colorscheme, "monochrome")
--     if not ok then
--       vim.notify("Colorscheme 'monochrome' not found!", vim.log.levels.ERROR)
--       return
--     end

--     -- Hide all semantic highlights until upstream issues are resolved
--     -- Reference: https://github.com/catppuccin/nvim/issues/480
--     for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
--       vim.api.nvim_set_hl(0, group, {})
--     end
--   end,
-- }
