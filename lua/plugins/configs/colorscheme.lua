-- # Colorscheme

-- ## Vscode
-- return {
-- 	"Mofiqul/vscode.nvim",
-- 	config = function()
-- 		-- Safely load vscode.nvim to prevent runtime errors
-- 		local ok, vscode = pcall(require, "vscode")
-- 		if not ok then
-- 			vim.notify("vscode.nvim not found!", vim.log.levels.ERROR)
-- 			return
-- 		end

-- 		-- Setup vscode theme with integrations and options
-- 		vscode.setup({
-- 			-- integrations = {
-- 			--   cmp = true,        -- Enable nvim-cmp integration
-- 			--   fidget = true,     -- Enable fidget integration for LSP progress
-- 			--   gitsigns = true,   -- Enable gitsigns integration
-- 			--   harpoon = true,    -- Enable harpoon integration
-- 			--   indent_blankline = {
-- 			--     enabled = false, -- Disable indent_blankline integration
-- 			--     scope_color = "sapphire",
-- 			--     colored_indent_levels = false,
-- 			--   },
-- 			--   mason = true,                    -- Enable Mason integration
-- 			--   native_lsp = { enabled = true }, -- Enable native LSP integration
-- 			--   noice = true,                    -- Enable Noice integration for notifications
-- 			--   notify = true,                   -- Enable nvim-notify integration
-- 			--   symbols_outline = true,          -- Enable symbols outline integration
-- 			--   telescope = true,                -- Enable Telescope integration
-- 			--   treesitter = true,               -- Enable Treesitter integration
-- 			--   treesitter_context = true,       -- Enable Treesitter context integration
-- 			-- },
-- 			-- options = {
-- 			--   comment_style = "italic",
-- 			--   keyword_style = "italic",
-- 			-- }
-- 		})

-- 		-- Apply the vscode colorscheme
-- 		vim.cmd.colorscheme("vscode")

-- 		-- Hide all semantic highlights until upstream issues are resolved
-- 		-- Reference: https://github.com/catppuccin/nvim/issues/480
-- 		for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
-- 			vim.api.nvim_set_hl(0, group, {})
-- 		end
-- 	end,
-- }

-- ## github-nvim-theme
return {
	"projekt0n/github-nvim-theme",
	lazy = false,
	priority = 1000,
	opts = {},

	config = function()
		local ok, github_theme = pcall(require, "github-theme")

		if not ok then
			vim.notify("Failed to load github-nvim-theme", vim.log.levels.ERROR)
			return
		end

		-- Plugin configuration
		github_theme.setup({
			options = {
				styles = {
					comments = "italic",
				},
				sidebars = { "qf", "vista_kind", "terminal", "packer" },
				dark_sidebar = true,
			},
		})

		-- Apply the colorscheme
		local colorscheme_ok = pcall(vim.cmd, "colorscheme github_dark_default")

		-- GitHub.com-like TypeScript colors (Tree-sitter groups)
		local custom_highlights = {
			-- Comments
			["@comment"] = { fg = "#8B949E", italic = true },

			-- Keywords (return, const, etc.)
			["@keyword"] = { fg = "#f8aa3e", italic = true },
			["@keyword.return"] = { fg = "#f8aa3e", italic = true },
			["@keyword.function"] = { fg = "#f8aa3e", italic = true },

			-- Control flow (if, else, while, for)
			["@conditional"] = { fg = "#f8aa3e", italic = true },
			["@repeat"] = { fg = "#f8aa3e", italic = true },
			["@exception"] = { fg = "#a2d2ff", italic = true },

			-- Identifiers / Variables
			["@variable"] = { fg = "#FFFFFC" },
			["@variable.builtin"] = { fg = "#FFFFFC" },
			["@parameter"] = { fg = "#FFFFFC" },
			["@property"] = { fg = "#a2d2ff" },
			["@field"] = { fg = "#a2d2ff" },

			-- Functions and Methods
			["@function"] = { fg = "#dab6fc" },
			["@function.builtin"] = { fg = "#a2d2ff" },
			["@function.call"] = { fg = "#a2d2ff" },
			["@method"] = { fg = "#a2d2ff" },
			["@method.call"] = { fg = "#a2d2ff" },

			-- Types, Classes, Interfaces
			["@type"] = { fg = "#a2d2ff" },
			["@type.builtin"] = { fg = "#a2d2ff" },
			["@type.definition"] = { fg = "#a2d2ff" },
			["@storageclass"] = { fg = "#a2d2ff" },
			["@attribute"] = { fg = "#a2d2ff" },

			-- Operators
			["@operator"] = { fg = "#C9D1D9" },

			-- Literals
			["@number"] = { fg = "#a2d2ff" },
			["@boolean"] = { fg = "#f8aa3e" },
			["@constant"] = { fg = "#f8aa3e" },

			-- Strings
			["@string"] = { fg = "#a2d2ff" },

			-- Tags (JSX/HTML)
			["@tag"] = { fg = "#51afef" },
			["@tag.attribute"] = { fg = "#f8aa3e" },
			["@tag.delimiter"] = { fg = "#C9D1D9" },

			-- Punctuation
			["@punctuation.delimiter"] = { fg = "#C9D1D9" },
			["@punctuation.bracket"] = { fg = "#C9D1D9" },
			["@punctuation.special"] = { fg = "#C9D1D9" },
		}

		-- Apply highlights
		for group, settings in pairs(custom_highlights) do
			vim.api.nvim_set_hl(0, group, settings)
		end

		if not colorscheme_ok then
			vim.notify("Failed to apply github-nvim-theme colorscheme", vim.log.levels.ERROR)
		end
	end,
}

-- Catppuccin
-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {},
-- 	config = function()
-- 		local ok, catppuccin = pcall(require, "catppuccin")
-- 		if not ok then
-- 			vim.notify("Failed to load catppuccin", vim.log.levels.ERROR)
-- 			return
-- 		end
-- 		-- Plugin configuration
-- 		catppuccin.setup({
-- 			flavour = "mocha", -- Options: "mocha", "macchiato", "frappe", "latte"
-- 			background = {
-- 				light = "latte",
-- 				dark = "mocha",
-- 			},
-- 			transparent_background = false,
-- 			term_colors = true,
-- 			styles = {
-- 				comments = { "italic" },
-- 				conditionals = {},
-- 				loops = {},
-- 				functions = {},
-- 				keywords = {},
-- 				strings = {},
-- 				variables = {},
-- 				numbers = {},
-- 				booleans = {},
-- 				properties = {},
-- 				types = {},
-- 			},
-- 			integrations = {
-- 				cmp = true,
-- 				gitsigns = true,
-- 				nvimtree = true,
-- 				telescope = true,
-- 				notify = true,
-- 				treesitter = true,
-- 				which_key = true,
-- 				mason = true,
-- 				lsp_trouble = true,
-- 				native_lsp = {
-- 					enabled = true,
-- 					virtual_text = {
-- 						errors = { "italic" },
-- 						hints = { "italic" },
-- 						warnings = { "italic" },
-- 						information = { "italic" },
-- 					},
-- 					underlines = {
-- 						errors = { "underline" },
-- 						hints = { "underline" },
-- 						warnings = { "underline" },
-- 						information = { "underline" },
-- 					},
-- 				},
-- 			},
-- 		})
-- 		-- Apply the colorscheme
-- 		local colorscheme_ok = pcall(vim.cmd, "colorscheme catppuccin")
-- 		if not colorscheme_ok then
-- 			vim.notify("Failed to apply catppuccin colorscheme", vim.log.levels.ERROR)
-- 		end
-- 	end,
-- }

-- ## Tokyonight
-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {},

-- 	config = function()
-- 		local ok, tokyonight = pcall(require, "tokyonight")

-- 		if not ok then
-- 			vim.notify("Failed to load tokyonight.nvim", vim.log.levels.ERROR)
-- 			return
-- 		end

-- 		-- Plugin configuration
-- 		tokyonight.setup({
-- 			style = "night", -- Options: "storm", "night", "day", "moon"
-- 			transparent = false,
-- 			terminal_colors = true,
-- 			styles = {
-- 				comments = { italic = true },
-- 				keywords = { italic = false },
-- 				functions = {},
-- 				variables = {},
-- 				sidebars = "dark",
-- 				floats = "dark",
-- 			},
-- 			on_colors = function(_)
-- 				-- Customize specific colors (currently unused)
-- 			end,
-- 			on_highlights = function(_, _)
-- 				-- Customize highlights (currently unused)
-- 			end,
-- 		})

-- 		-- Apply the colorscheme
-- 		local colorscheme_ok = pcall(vim.cmd, "colorscheme tokyonight")

-- 		if not colorscheme_ok then
-- 			vim.notify("Failed to apply tokyonight colorscheme", vim.log.levels.ERROR)
-- 		end
-- 	end,
-- }

-- ## Gruvbox Material
-- return {
-- 	"sainnhe/gruvbox-material",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		-- Optionally configure and load the colorscheme
-- 		-- directly inside the plugin declaration.
-- 		vim.g.gruvbox_material_enable_italic = true
-- 		vim.cmd.colorscheme("gruvbox-material")
-- 	end,
-- }
