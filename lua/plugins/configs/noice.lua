return {
	"folke/noice.nvim",
	event = "VeryLazy", -- Load only when UI is ready
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		local ok, noice = pcall(require, "noice")
		if not ok then
			vim.notify("Failed to load noice.nvim: " .. tostring(noice), vim.log.levels.ERROR)
			return
		end

		local setup_ok, setup_err = pcall(function()
			noice.setup({
				-- Optimized configuration
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
					},
					-- Disable hover in favor of native LSP hover
					hover = {
						enabled = false,
					},
					-- Lightweight signature help
					signature = {
						enabled = true,
						auto_open = {
							enabled = true,
							trigger = true,
							luasnip = false,
							throttle = 50,
						},
					},
				},

				-- Minimal messages
				messages = {
					enabled = true,
					view = "notify",
					view_error = "notify",
					view_warn = "notify",
					view_history = "messages",
					view_search = "virtualtext",
				},

				-- Lightweight cmdline
				cmdline = {
					view = "cmdline",
					format = {
						cmdline = { icon = ">" },
						search_down = { icon = "🔍⌄" },
						search_up = { icon = "🔍⌃" },
						filter = { icon = "$" },
						lua = { icon = "☾" },
						help = { icon = "?" },
					},
				},

				-- Optimized routes to filter noisy messages
				routes = {
					-- Skip written messages
					{ filter = { event = "msg_show", find = "written" }, opts = { skip = true } },
					-- Skip save messages
					{ filter = { event = "msg_show", find = "lines" }, opts = { skip = true } },
					-- Skip search count
					{ filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
				},

				-- Minimal presets
				presets = {
					bottom_search = true,
					command_palette = false,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = false,
				},

				-- Additional performance optimizations
				throttle = 1000 / 30, -- 30 fps
			})
		end)
		if not setup_ok then
			vim.notify("Failed to setup noice.nvim: " .. tostring(setup_err), vim.log.levels.ERROR)
			return
		end

		-- Efficient keymaps
		local keymap_ok, keymap_err = pcall(function()
			-- vim.keymap.set("n", "<leader>n", ":NoiceDismiss<CR>", { desc = "Dismiss Noice", silent = true })
		end)
		if not keymap_ok then
			vim.notify("Failed to setup noice.nvim keymaps: " .. tostring(keymap_err), vim.log.levels.WARN)
		end
	end,
}
