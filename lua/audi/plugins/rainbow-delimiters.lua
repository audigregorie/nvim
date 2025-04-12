return {
	"HiPhish/rainbow-delimiters.nvim",
	config = function()
		require("rainbow-delimiters.setup").setup({
			strategy = {
				[""] = "rainbow-delimiters.strategy.global",
				commonlisp = "rainbow-delimiters.strategy.local",
			},
			query = {
				[""] = "rainbow-delimiters",
				latex = "rainbow-blocks",
			},
			highlight = {
				"RainbowDelimiterRed",
				"RainbowDelimiterYellow",
				"RainbowDelimiterBlue",
				"RainbowDelimiterOrange",
				"RainbowDelimiterGreen",
				"RainbowDelimiterViolet",
				"RainbowDelimiterCyan",
			},
			blacklist = { "c", "cpp", "html" },
		})

		-- Optional: Define custom highlight colors if you want
		vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#E06C75" })
		vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B" })
		vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61AFEF" })
		vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66" })
		vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98C379" })
		vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56B6C2" })
	end,
}
