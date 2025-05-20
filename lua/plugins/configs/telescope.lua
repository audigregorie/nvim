return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "sudormrfbin/cheatsheet.nvim" },
		{ "rcarriga/nvim-notify" },
	},
	config = function()
		local ok, telescope = pcall(require, "telescope")
		if not ok then
			vim.notify("Failed to load telescope.nvim", vim.log.levels.ERROR)
			return
		end

		local builtin_ok, builtin = pcall(require, "telescope.builtin")
		if not builtin_ok then
			vim.notify("Failed to load telescope.builtin", vim.log.levels.ERROR)
			return
		end

		local actions = require("telescope.actions")
		local fb_actions = require("telescope").extensions.file_browser.actions
		local sorters = require("telescope.sorters")

		local setup_ok, setup_err = pcall(function()
			telescope.setup({
				defaults = {
					initial_mode = "insert",
					path_display = { "smart" },
					winblend = 0,
					file_sorter = sorters.get_fuzzy_file,
					selection_strategy = "reset",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					file_ignore_patterns = {
						"^.git/",
						"^node_modules/",
						"^dist/",
						"package-lock.json",
					},
					mappings = {
						i = {
							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-;>"] = actions.which_key,
							["<C-x>"] = actions.delete_buffer,
						},
					},
				},
				pickers = {
					find_files = {
						sort_mru = true,
						find_command = {
							"fd",
							"--type",
							"f",
							"--hidden",
							"--exclude",
							"node_modules",
							"--strip-cwd-prefix",
						},
						sorter = sorters.get_fuzzy_file(),
						file_sorter = function(a, b)
							local a_ext = a:match("%.([^.]+)$") or ""
							local b_ext = b:match("%.([^.]+)$") or ""

							-- Prioritize TypeScript files over HTML files
							local priority = { ts = 1, tsx = 1, html = 2 }

							return (priority[a_ext] or 99) < (priority[b_ext] or 99)
						end,
					},
					buffer = { sort_mru = true },
					grep_string = { word_match = "-w" },
					live_grep = {
						additional_args = function()
							return { "--hidden" }
						end,
					},
					projects = {
						theme = "dropdown",
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					find_files = {
						layout_config = { preview_width = 0.6 },
					},
					file_browser = {
						hijack_netrw = true,
						hidden = true,
						mappings = {
							["i"] = {
								["<C-h>"] = fb_actions.goto_parent_dir,
							},
						},
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							winblend = 15,
							layout_config = {
								width = 0.8,
								height = 0.4,
							},
						}),
					},
				},
			})
		end)

		if not setup_ok then
			vim.notify("Failed to setup telescope.nvim: " .. setup_err, vim.log.levels.ERROR)
			return
		end

		-- Load extensions
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "find_files")
		pcall(telescope.load_extension, "file_browser")
		pcall(telescope.load_extension, "ui-select")

		-- Key mappings
		local keymap_ok, keymap_err = pcall(function()
			-- Default keymap opts
			local opts = { noremap = true, silent = true }

			-- Helper function to merge options with default opts
			local function keymap_opts(desc)
				return vim.tbl_deep_extend("force", opts, { desc = desc })
			end

			-- Find files
			vim.keymap.set("n", "<leader>ff", builtin.find_files, keymap_opts("[F]ind [F]iles"))
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, keymap_opts("[F]ind by [G]rep"))
			vim.keymap.set("n", "<leader>fe", builtin.buffers, keymap_opts("[S]earch [B]uffers"))
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, keymap_opts("[F]ind [H]elp"))
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, keymap_opts("[?] Find recently opened files"))
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, keymap_opts("[S]earch current [W]ord"))

			-- File browser
			vim.keymap.set(
				"n",
				"<leader>fb",
				":Telescope file_browser path=%:p:h select_buffer=true<CR>",
				keymap_opts("Open File Browser")
			)

			-- Git
			vim.keymap.set("n", "<leader>gf", builtin.git_files, keymap_opts("Search [G]it [F]iles"))
			vim.keymap.set("n", "<leader>gc", builtin.git_bcommits, keymap_opts("[G]it [B]commits"))

			-- LSP
			vim.keymap.set("n", "<leader>wd", builtin.diagnostics, keymap_opts("[W]orkspace [D]iagnostics"))
			vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, keymap_opts("[D]ocument [S]ymbols"))
			vim.keymap.set("n", "<leader>qf", builtin.quickfix, keymap_opts("[Q]uick [F]ix"))
		end)

		if not keymap_ok then
			vim.notify("Failed to set telescope keymaps: " .. keymap_err, vim.log.levels.WARN)
		end
	end,
}
