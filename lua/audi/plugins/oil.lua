return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local ok, oil = pcall(require, "oil")
		if not ok then
			vim.notify("Failed to load oil.nvim: " .. tostring(oil), vim.log.levels.ERROR)
			return
		end

		local setup_ok, setup_err = pcall(function()
			oil.setup({
				-- Oil.nvim configuration
				default_file_explorer = true,
				columns = {
					"size",
					"icon",
				},
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-s>"] = "actions.select_vsplit",
					["<C-h>"] = "actions.select_split",
					["<C-t>"] = "actions.select_tab",
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-l>"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
				},
				view_options = {
					show_hidden = true,
					is_always_hidden = function(name)
						return name == ".." or name == ".git"
					end,
				},
				float = {
					padding = 2,
					max_width = 300,
					max_height = 0,
					border = "rounded",
					win_options = {
						winblend = 0,
					},
				},
			})
		end)

		if not setup_ok then
			vim.notify("Failed to setup oil.nvim: " .. tostring(setup_err), vim.log.levels.ERROR)
			return
		end

		-- Create a default options table at the top of your config function
		local default_opts = { noremap = true, silent = true }

		-- Add keymaps after successful setup
		local keymap_ok, keymap_err = pcall(function()
			-- Standard file navigation keymap
			vim.keymap.set(
				"n",
				"-",
				require("oil").open,
				vim.tbl_extend("force", default_opts, { desc = "Open parent directory" })
			)

			-- Toggle oil float with <leader>e
			vim.keymap.set("n", "<leader>e", function()
				require("oil").toggle_float()
			end, vim.tbl_extend("force", default_opts, { desc = "Toggle Oil Explorer" }))
		end)

		if not keymap_ok then
			vim.notify("Failed to setup oil.nvim keymaps: " .. tostring(keymap_err), vim.log.levels.WARN)
		end
	end,
}
