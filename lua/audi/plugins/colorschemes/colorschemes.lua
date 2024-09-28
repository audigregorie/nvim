-- <> Colorscheme Catppuccin
-- return {
--   "catppuccin/nvim",
--   config = function()
--     require("catppuccin").setup({
--       integrations = {
--         cmp = true,
--         fidget = true,
--         gitsigns = true,
--         harpoon = true,
--         indent_blankline = {
--           enabled = false,
--           scope_color = "sapphire",
--           colored_indent_levels = false,
--         },
--         mason = true,
--         native_lsp = { enabled = true },
--         noice = true,
--         notify = true,
--         symbols_outline = true,
--         telescope = true,
--         treesitter = true,
--         treesitter_context = true,
--         nvimtree = true,

--       },

--     })

--     vim.cmd.colorscheme("catppuccin-macchiato")

--     -- Hide all semantic highlights until upstream issues are resolved (https: //github.com/catppuccin/nvim/issues/480)
--     for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
--       vim.api.nvim_set_hl(0, group, {})
--     end
--   end,
-- }


-- <> Colorscheme Vscode
-- return {
--   "Mofiqul/vscode.nvim",
--   config = function()
--     require("vscode").setup({
--       integrations = {
--         cmp = true,
--         fidget = true,
--         gitsigns = true,
--         harpoon = true,
--         indent_blankline = {
--           enabled = false,
--           scope_color = "sapphire",
--           colored_indent_levels = false,
--         },
--         mason = true,
--         native_lsp = { enabled = true
--         },
--         noice = true,
--         notify = true,
--         symbols_outline = true,
--         telescope = true,
--         treesitter = true,
--         treesitter_context = true,
--       },
--     })

--     vim.cmd.colorscheme("vscode")

--     -- Hide all semantic highlights until upstream issues are resolved (https: //github.com/catppuccin/nvim/issues/480)
--     for _, group in ipairs(vim.fn.getcompletion("@lsp",
--       "highlight")) do
--       vim.api.nvim_set_hl(0, group,
--         {})
--     end
--   end,
-- }


-- <> Colorscheme Github
-- return {
--   "projekt0n/github-nvim-theme",
--   config = function()
--     require("github-theme").setup({
--       integrations = {
--         cmp = true,
--         fidget = true,
--         gitsigns = true,
--         harpoon = true,
--         indent_blankline = {
--           enabled = false,
--           scope_color = "sapphire",
--           colored_indent_levels = false,
--         },
--         mason = true,
--         native_lsp = { enabled = true
--         },
--         noice = true,
--         notify = true,
--         symbols_outline = true,
--         telescope = true,
--         treesitter = true,
--         treesitter_context = true,
--       },
--     })

--     -- vim.cmd.colorscheme("github_dark")
--     vim.cmd.colorscheme("github_dark_dimmed")

--     -- Hide all semantic highlights until upstream issues are resolved (https: //github.com/catppuccin/nvim/issues/480)
--     for _, group in ipairs(vim.fn.getcompletion("@lsp",
--       "highlight")) do
--       vim.api.nvim_set_hl(0, group,
--         {})
--     end
--     vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#0A0F14" })
--   end,
-- }


-- <> Colorscheme Rasmus
-- return {
--   'kvrohit/rasmus.nvim',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme("rasmus")
--   end
-- }


-- <> Colorscheme Zenbones
return {
  "zenbones-theme/zenbones.nvim",
  -- Optionally install Lush. Allows for more configuration or extending the colorscheme
  -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
  -- In Vim, compat mode is turned on as Lush only works in Neovim.
  dependencies = "rktjmp/lush.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd.colorscheme("zenbones")
  end
}


-- <> Colorscheme Monochrome
-- return {
--   "kdheepak/monochrome.nvim",
--   config = function()
--     vim.cmd.colorscheme("monochrome")

--     -- Hide all semantic highlights until upstream issues are resolved (https: //github.com/catppuccin/nvim/issues/480)
--     for _, group in ipairs(vim.fn.getcompletion("@lsp",
--       "highlight")) do
--       vim.api.nvim_set_hl(0, group,
--         {})
--     end
--   end,
-- }

-- return {
--   'lourenci/github-colors',
--   run = ':TSUpdate',
--   config = function()
--     require 'nvim-treesitter.configs'.setup {
--       highlight = {
--         enable = true,
--       }
--     }

--     vim.cmd.colorscheme("github-colors")
--   end,
-- }
