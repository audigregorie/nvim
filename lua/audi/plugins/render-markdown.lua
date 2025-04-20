return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	opts = {
		heading = {
			icons = { "󰲡  ", "󰲣  ", "󰲥  ", "󰲧  ", "󰲩  ", "󰲫  " },
			backgrounds = {
				"RenderMarkdownH1Bg",
				"RenderMarkdownH2Bg",
				"RenderMarkdownH3Bg",
				"RenderMarkdownH4Bg",
				"RenderMarkdownH5Bg",
				"RenderMarkdownH6Bg",
			},
			foregrounds = {
				"RenderMarkdownH1",
				"RenderMarkdownH2",
				"RenderMarkdownH3",
				"RenderMarkdownH4",
				"RenderMarkdownH5",
				"RenderMarkdownH6",
			},
		},
	},
	config = function(_, opts)
		-- vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { bg = "#171717", blend = 70 })
		-- vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { bg = "#171717", blend = 70 })
		-- vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { bg = "#171717", blend = 70 })
		-- vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "#171717", blend = 70 })
		-- vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { bg = "#171717", blend = 70 })
		-- vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { bg = "#171717", blend = 70 })

		-- vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#bf7d56" })
		-- vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = "#bf7d56" })
		-- vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = "#bf7d56" })
		-- vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = "#bf7d56" })
		-- vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = "#bf7d56" })
		-- vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = "#bf7d56" })

		require("render-markdown").setup(opts)
	end,
}
