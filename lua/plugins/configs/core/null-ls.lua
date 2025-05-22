-- -- null-ls.lua
-- return {
--   "jose-elias-alvarez/null-ls.nvim",
--   dependencies = { "nvim-lua/plenary.nvim" },
--   config = function()
--     -- Safely load null-ls to avoid runtime errors
--     local null_ls_ok, null_ls = pcall(require, "null-ls")
--     if not null_ls_ok then
--       vim.notify("Null ls not found!", vim.log.levels.ERROR)
--       return
--     end
--     local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

--     -- Setup null-ls with specific configurations
--     null_ls.setup({
--       debug = true,
--       sources = {
--         -- Use Prettier for specific frontend formatting
--         null_ls.builtins.formatting.prettier.with({
--           prefer_local = "node_modules/.bin",
--           filetypes = {
--             "javascript",
--             "javascriptreact",
--             "typescript",
--             "typescriptreact",
--             "tsx",
--             "json",
--             "html",
--             "css",
--             "scss",
--             "sass",
--             -- Removed "lua" from here since we'll use stylua
--           },
--         }),

--         -- Use stylua for Lua
--         null_ls.builtins.formatting.stylua.with({
--           filetypes = { "lua" },
--         }),

--         -- Use jq for JSON
--         null_ls.builtins.formatting.jq.with({
--           filetypes = { "json" },
--         }),
--       },

--       -- Automatically format the buffer on save if supported
--       on_attach = function(client, bufnr)
--         -- Only use null-ls for formatting to avoid conflicts
--         if client.supports_method("textDocument/formatting") then
--           -- Disable formatting for other LSP clients to prevent conflicts
--           if client.name ~= "null-ls" then
--             client.server_capabilities.documentFormattingProvider = false
--             client.server_capabilities.documentRangeFormattingProvider = false
--           end

--           vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--           vim.api.nvim_create_autocmd("BufWritePre", {
--             group = augroup,
--             buffer = bufnr,
--             callback = function()
--               -- Save view state (including scroll position, folds, etc.)
--               local view = vim.fn.winsaveview()
--               -- Format the buffer
--               vim.lsp.buf.format({
--                 bufnr = bufnr,
--                 -- Only use null-ls for formatting
--                 filter = function(format_client)
--                   return format_client.name == "null-ls"
--                 end
--               })
--               -- Restore view state after a very short delay
--               vim.defer_fn(function()
--                 vim.fn.winrestview(view)
--               end, 1)
--             end,
--           })
--         end
--       end,
--     })
--   end,
-- }

-- testing
return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		-- Safely load null-ls to avoid runtime errors
		local null_ls_ok, null_ls = pcall(require, "null-ls")
		if not null_ls_ok then
			vim.notify("Null ls not found!", vim.log.levels.ERROR)
			return
		end
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		-- Setup null-ls with specific configurations
		null_ls.setup({
			debug = true,
			sources = {
				-- Use Prettier for specific frontend formatting, excluding SCSS
				null_ls.builtins.formatting.prettier.with({
					prefer_local = "node_modules/.bin",
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"tsx",
						"json",
						"html",
						"css",
						-- SCSS and SASS explicitly excluded
					},
				}),
				-- Use stylua for Lua
				null_ls.builtins.formatting.stylua.with({
					filetypes = { "lua" },
				}),
				-- Use jq for JSON
				null_ls.builtins.formatting.jq.with({
					filetypes = { "json" },
				}),
			},
			-- Skip SCSS files entirely in on_attach
			on_attach = function(client, bufnr)
				-- Skip SCSS files
				if vim.bo[bufnr].filetype == "scss" then
					return
				end

				-- Only use null-ls for formatting to avoid conflicts
				if client.supports_method("textDocument/formatting") then
					-- Disable formatting for other LSP clients to prevent conflicts
					if client.name ~= "null-ls" then
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							-- Double-check it's not an SCSS file
							if vim.bo[bufnr].filetype == "scss" then
								return
							end

							-- Save view state (including scroll position, folds, etc.)
							local view = vim.fn.winsaveview()
							-- Format the buffer
							vim.lsp.buf.format({
								bufnr = bufnr,
								-- Only use null-ls for formatting
								filter = function(format_client)
									return format_client.name == "null-ls"
								end,
							})
							-- Restore view state after a very short delay
							vim.defer_fn(function()
								vim.fn.winrestview(view)
							end, 1)
						end,
					})
				end
			end,
		})

		-- Create an autocmd to ensure null-ls doesn't process SCSS files
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "scss",
			callback = function(args)
				local bufnr = args.buf
				-- Prevent null-ls from attaching to SCSS buffers
				vim.b[bufnr] = vim.b[bufnr] or {}
				vim.b[bufnr].null_ls_disabled = true
			end,
		})
	end,
}
