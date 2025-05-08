return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x", -- or the latest stable branch
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- optional but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			sources = {
				"filesystem",
				"buffers",
				"git_status", -- Enable Git as a source
			},
			source_selector = {
				winbar = true, -- show selector in the winbar (or set to false if you want in the top)
				statusline = false, -- alternatively show it in statusline
				sources = {
					{ source = "filesystem", display_name = "󰉓 Files" },
					{ source = "buffers", display_name = "󰈚 Buffers" },
					{ source = "git_status", display_name = " Git" },
				},
			},
			filesystem = {
				filtered_items = {
					visible = true, -- show hidden files by default
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
			git_status = {
				window = {
					position = "float", -- or "left", "right", "top", "bottom", "float"
				},
			},
			default_component_configs = {
				indent = {
					highlight = "Normal",
				},
			},
		})

		-- Optional: set keymaps
		vim.keymap.set("n", "<leader>t", ":Neotree toggle<CR>", { desc = "Toggle NeoTree" })
		vim.keymap.set("n", "<leader>tf", ":Neotree filesystem toggle<CR>", { desc = "NeoTree Filesystem" })
		vim.keymap.set("n", "<leader>tb", ":Neotree buffers toggle<CR>", { desc = "NeoTree Buffers" })
		vim.keymap.set("n", "<leader>tg", ":Neotree git_status toggle<CR>", { desc = "NeoTree Git Status" })

		-- Add an autocommand to close neo-tree when exiting Vim
		vim.api.nvim_create_autocmd("QuitPre", {
			callback = function()
				local neo_tree_wins = {}
				local floating_wins = {}
				local wins = vim.api.nvim_list_wins()
				for _, w in ipairs(wins) do
					local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
					if
						bufname:match("neo%-tree filesystem")
						or bufname:match("neo%-tree buffers")
						or bufname:match("neo%-tree git_status")
					then
						table.insert(neo_tree_wins, w)
					end
					if vim.api.nvim_win_get_config(w).relative ~= "" then
						table.insert(floating_wins, w)
					end
				end
				if #wins - (#floating_wins + #neo_tree_wins) == 1 then
					-- Only one real window left (besides Neo-tree and floating), so close Neo-tree windows
					for _, w in ipairs(neo_tree_wins) do
						vim.api.nvim_win_close(w, true)
					end
				end
			end,
		})
	end,
}
