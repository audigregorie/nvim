-- lua/plugins/lspconfig.lua
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
		local vim = vim

		-- Define capabilities (e.g., for nvim-cmp if used)
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		if has_cmp then
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
		end

		-- List of LSP servers and optional custom config
		local servers = {
			ts_ls = {},
			html = {},
			cssls = {},
			tailwindcss = {},
			jsonls = {},
			eslint = {},
			lua_ls = {},
			emmet_ls = {},
		}

		-- Setup all servers
		for server, config in pairs(servers) do
			config.capabilities = capabilities
			lspconfig[server].setup(config)
		end

		-- Configure diagnostics float window
		vim.diagnostic.config({
			float = {
				-- Make the window larger
				width = 80, -- Increase width (default is ~40)
				height = 20, -- Increase height

				-- Style settings
				border = "rounded", -- Options: "none", "single", "double", "rounded", "solid", "shadow"

				-- Format settings
				format = function(diagnostic)
					-- Custom format function for diagnostic messages
					local message = diagnostic.message
					local source = diagnostic.source or "unknown"
					local code = diagnostic.code or ""

					if code ~= "" then
						return string.format("%s [%s] (%s)", message, code, source)
					else
						return string.format("%s (%s)", message, source)
					end
				end,

				-- Content settings
				prefix = function(diagnostic, i, total)
					-- Custom prefix for each diagnostic
					local icon = "● " -- You can use different icons based on severity
					if diagnostic.severity == vim.diagnostic.severity.ERROR then
						icon = "✖ "
					elseif diagnostic.severity == vim.diagnostic.severity.WARN then
						icon = "⚠ "
					elseif diagnostic.severity == vim.diagnostic.severity.INFO then
						icon = "ℹ "
					elseif diagnostic.severity == vim.diagnostic.severity.HINT then
						icon = "➤ "
					end
					return string.format("%s %d/%d: ", icon, i, total)
				end,

				-- Additional visual customization
				focusable = true,                 -- Make the window focusable
				focus = false,                    -- Don't focus automatically
				severity_sort = true,             -- Sort by severity
				header = { "Diagnostics:", "Title" }, -- Custom header
				footer = { " ", "Comment" },      -- Custom footer
			},

			-- Other diagnostic settings (not related to float window)
			virtual_text = { spacing = 4, prefix = "●" },
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		-- Optional: Keybindings (basic)
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				local opts = { buffer = event.buf }


				-- Keymaps for LSP
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts, "Hover documentation")
				vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts, "Go to declaration")
				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts, "Go to definition")
				vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts, "Go to implementation")
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts, "Code action")
				vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, opts, "Go to type definition")
				vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts, "Show references")

				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>f", function()
					vim.lsp.buf.format({ async = true })
				end, opts)

				-- Keymaps for LSP diagnostics
				vim.keymap.set("n", "<leader>wd", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist, opts)
			end,
		})
	end,
}
