return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			direction = "float",
			float_opts = {
				border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' for floating terminals
				winblend = 3, -- Transparency level for the floating window
				-- width = function(term)
				--   return math.floor(vim.o.columns * 0.8)
				-- end,
				-- height = function(term)
				--   return math.floor(vim.o.lines * 0.8)
				-- end,
			},
			highlights = {
				Normal = {
					guibg = "#111112",
				},
				NormalFloat = {
					guibg = "#111112",
				},
				FloatBorder = {
					-- guifg = "#1d90f5",
					guifg = "#006400",
					guibg = "#111112",
				},
			},
		})

		-- Set your keymap here
		vim.api.nvim_set_keymap(
			"n",
			"<leader>0",
			":ToggleTerm<CR>",
			{ noremap = true, silent = true, desc = "Toggle terminal" }
		)
	end,
}
