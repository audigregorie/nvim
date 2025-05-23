return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- Single check to ensure the core LSP module is available
		if not vim.lsp then
			vim.notify("Neovim LSP module (vim.lsp) not found. Skipping LSP configuration.", vim.log.levels.ERROR)
			return
		end

		-- Create autogroup for LSP configurations.
		-- Adding `clear = true` makes it safe to re-source this file.
		vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

		-- Configure diagnostics.
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = true,
			severity_sort = true,
			float = {
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- Diagnostic keymaps
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				local opts = { buffer = ev.buf }

				-- 	-- Navigation keymaps
				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, opts)

				-- 	-- Information keymaps
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

				-- 	-- Workspace keymaps
				vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)

				-- 	-- Code action keymaps
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<space>f", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
			end,
		})
	end,
}
