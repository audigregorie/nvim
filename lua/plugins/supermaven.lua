return { -- Supermaven.nvim
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<Tab>",
				clear_suggestion = "<C-w>",
				accept_word = "<leader>l",
			},
			color = {
				suggestion_color = "#a1a1a1",
				cterm = 244,
			},
		})
	end,
}
