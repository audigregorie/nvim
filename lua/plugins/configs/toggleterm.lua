return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			-- open_mapping = [[<c-\>]], -- Ctrl+\ to toggle
			direction = "float", -- or 'horizontal', 'vertical', 'tab'
			shade_terminals = true,
			start_in_insert = true,
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
					guibg = "#0F0F0F",
				},
			},
		})

		vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
		vim.keymap.set("t", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal in terminal mode" })
	end,
}
