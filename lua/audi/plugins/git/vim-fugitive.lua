return {
	"tpope/vim-fugitive",
	cmd = { "Git", "G", "Gdiffsplit", "Gblame", "Gstatus", "Gcommit" },
	keys = {
		-- Example keymaps (use your preferred leader key and mappings)
		{ "<leader>gs", "<cmd>G<cr>", desc = "Git Status" }, -- Open Git status window
		{ "<leader>gb", "<cmd>Gblame<cr>", desc = "Git Blame" }, -- Open Git blame view
		{ "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git Diff" }, -- Diff current file against index

		-- Example for staging the current file from the status window
		-- Note: These work when the cursor is on the file in the :G status buffer
		-- { "s", ":G stage %<CR>", mode = "n", buffer = true, desc = "Stage File" }, -- map 's' in status buffer
		-- { "u", ":G unstage %<CR>", mode = "n", buffer = true, desc = "Unstage File" }, -- map 'u' in status buffer
		-- Fugitive provides defaults like 's' and 'u' in its buffer, so explicit mapping might not be needed
		-- unless you want to override or ensure they exist.
	},
}
