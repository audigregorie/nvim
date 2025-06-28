return {
	------------------------------------------------------------------
	-- Feature: Treesitter for syntax parsing
	------------------------------------------------------------------
	-- Angular-specific enhancements
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				event = "VeryLazy",
			},
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"angular",
					"typescript",
					"javascript",
					"html",
					"css",
					"scss",
					"json",
					"yaml",
					"lua",
					"vim",
				},
				auto_install = true,
				sync_install = false,
				ignore_install = {},
				modules = {},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
						},
					},
				},
			})
		end,
	},

	------------------------------------------------------------------
	-- Feature: Language Server Protocol (LSP)
	------------------------------------------------------------------
	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- mason.nvim (LSP/DAP/Tool installer)
			{
				"williamboman/mason.nvim",
				build = ":MasonUpdate",
				cmd = "Mason",
				config = function()
					require("mason").setup()
				end,
			},
			-- mason-lspconfig (bridge between mason and lspconfig)
			{
				"williamboman/mason-lspconfig.nvim",
				-- --- This plugin is now a dependency and its config is here.
				config = function()
					require("mason-lspconfig").setup({
						ensure_installed = { "ts_ls", "angularls", "cssls", "jsonls", "tailwindcss", "lua_ls" },
						automatic_installation = true,
						automatic_enable = true,
					})
				end,
			},
			-- LSP Progress UI
			{
				"j-hui/fidget.nvim",
				tag = "legacy",
				event = "LspAttach",
				config = function()
					require("fidget").setup({})
				end,
			},
			-- LSP UI Enhancements
			{
				"nvimdev/lspsaga.nvim",
				event = "LspAttach",
				dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
				config = function()
					require("lspsaga").setup({ lightbulb = { enable = true, enable_in_insert = false } })
				end,
			},
			-- Json Schemas LSP Helper
			{ "b0o/schemastore.nvim", lazy = true },
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Enable inline diagnostics
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					spacing = 2,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Import lspconfig.
			local lspconfig = require("lspconfig")
			-- Import cmp_nvim_lsp for capabilities.
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			-- This on_attach function will be used for all LSP servers.
			-- It sets up keymaps and other buffer-local settings when a server attaches.
			local on_attach = function(client, bufnr)
				-- This is a best practice to prevent conflicts with none-ls.
				-- It ensures that only none-ls provides formatting.
				if client.supports_method("textDocument/formatting") then
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end

				-- LSP Keymaps
				local opts = { noremap = true, silent = true, buffer = bufnr }
				local keymap = vim.keymap.set
				keymap(
					"n",
					"gd",
					require("telescope.builtin").lsp_definitions,
					vim.tbl_extend("force", opts, { desc = "[G]oto [D]efinition" })
				)
				keymap(
					"n",
					"gD",
					vim.lsp.buf.declaration,
					vim.tbl_extend("force", opts, { desc = "[G]oto [D]eclaration" })
				)
				keymap(
					"n",
					"gr",
					require("telescope.builtin").lsp_references,
					vim.tbl_extend("force", opts, { desc = "[G]oto [R]eferences" })
				)
				keymap(
					"n",
					"gi",
					require("telescope.builtin").lsp_implementations,
					vim.tbl_extend("force", opts, { desc = "[G]oto [I]mplementation" })
				)
				keymap(
					"n",
					"gt",
					require("telescope.builtin").lsp_type_definitions,
					vim.tbl_extend("force", opts, { desc = "[G]oto [T]ype Definition" })
				)
				keymap(
					"n",
					"ds",
					require("telescope.builtin").lsp_document_symbols,
					vim.tbl_extend("force", opts, { desc = "[D]ocument [S]ymbols" })
				)
				keymap(
					"n",
					"ws",
					require("telescope.builtin").lsp_dynamic_workspace_symbols,
					vim.tbl_extend("force", opts, { desc = "[W]orkspace [S]ymbols" })
				)
				keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
				keymap(
					"i",
					"<C-k>",
					vim.lsp.buf.signature_help,
					vim.tbl_extend("force", opts, { desc = "Signature Help" })
				)
				keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "[R]e[n]ame" }))
				keymap(
					{ "n", "x" },
					"<leader>ca",
					vim.lsp.buf.code_action,
					vim.tbl_extend("force", opts, { desc = "[C]ode [A]ction" })
				)
				keymap(
					"n",
					"<leader>d",
					vim.diagnostic.open_float,
					vim.tbl_extend("force", opts, { desc = "Show Diagnostics" })
				)
				keymap(
					"n",
					"<leader>wd",
					require("telescope.builtin").diagnostics,
					vim.tbl_extend("force", opts, { desc = "[W]orkspace [D]iagnostics" })
				)
				keymap("n", "[d", function()
					vim.diagnostic.jump({ count = -1 })
				end, vim.tbl_extend("force", opts, { desc = "Previous Diagnostic" }))
				keymap("n", "]d", function()
					vim.diagnostic.jump({ count = 1 })
				end, vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))

				-- Add a keymap for inlay hints if the server supports it.
				if client.server_capabilities.inlayHintProvider then
					vim.keymap.set("n", "<leader>ih", function()
						vim.lsp.inlay_hint.enable(
							not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
							{ bufnr = bufnr }
						)
					end, { buffer = bufnr, desc = "Toggle Inlay Hints" })
				end
			end

			-- Angular Language Server
			lspconfig.angularls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("angular.json", "tsconfig.json", ".git"),
				settings = {
					typescript = {
						experimental = {
							-- This is crucial for allowing the server to find component templates.
							resolveNonTsPathExtension = true,
						},
					},
					html = {
						experimental = {
							-- This enables parsing of Angular's unique binding syntax in templates.
							parseAngularBinding = true,
						},
					},
				},
			})

			-- TypeScript Server
			lspconfig.ts_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", ".git"),
				settings = {
					completions = {
						-- When selecting a function from the completion menu, automatically add parentheses
						completeFunctionCalls = true,
					},
					suggest = {
						-- Enables suggestions for symbols that can be auto-imported
						autoImports = true,
					},
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayVariableTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
						},
					},
				},
			})

			-- CSS Language Server
			lspconfig.cssls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					css = {
						-- Enable validation to get linting diagnostics.
						validate = true,
						lint = {
							-- Warn about duplicate properties.
							duplicateProperties = "warning",
							-- Warn about empty rulesets.
							emptyRules = "warning",
							-- Warn about using vendor-specific prefixes.
							vendorPrefix = "warning",
						},
					},
				},
			})

			-- JSON Language Server
			lspconfig.jsonls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(), -- optional
						validate = { enable = true },
					},
				},
			})

			-- Tailwind CSS Language Server
			lspconfig.tailwindcss.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern(
					"tailwind.config.js",
					"tailwind.config.ts",
					"postcss.config.js",
					"package.json",
					".git"
				),
				-- guarantees that you get Tailwind CSS completions and diagnostics inside
				-- your Angular HTML templates (.html), component files (.ts), and stylesheets (.scss)
				filetypes = { "angular", "html", "typescript", "javascript", "css", "scss" },
			})

			-- Lua Language Server
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
					},
				},
			})
		end,
	},

	------------------------------------------------------------------
	-- Feature: Autocompletion
	------------------------------------------------------------------
	-- nvim-cmp (main completion engine)
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Sources for nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			-- Snippet Engine & Snippets
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				build = "make install_jsregexp",
			},

			{ "saadparwaiz1/cmp_luasnip" },

			-- UI for nvim-cmp
			{ "onsails/lspkind.nvim", lazy = true },
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
			})

			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "luasnip", priority = 750 },
					{ name = "buffer", priority = 500 },
					{ name = "path", priority = 250 },
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			})

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},

	------------------------------------------------------------------
	-- Feature: Formatting & Linting
	------------------------------------------------------------------
	-- None-ls for formatting
	{
		"nvimtools/none-ls.nvim",
		-- `plenary` is a common dependency for many plugins.
		dependencies = { "nvim-lua/plenary.nvim" },
		-- Load none-ls on startup or when you open a file.
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Import the none-ls module.
			local null_ls = require("null-ls")

			-- Configure none-ls.
			null_ls.setup({
				sources = {
					-- `prettierd` is a daemonized version of Prettier for faster performance.
					-- Make sure you have `prettierd` installed globally (`npm i -g @fsouza/prettierd`).
					null_ls.builtins.formatting.prettierd,

					-- For Lua file formatting
					null_ls.builtins.formatting.stylua,
				},

				-- The `on_attach` function is the recommended way to set up
				-- format-on-save and other buffer-specific settings.
				-- This function is called whenever none-ls attaches to a buffer.
				on_attach = function(client, bufnr)
					-- Check if the client attached to the buffer supports formatting.
					if client.supports_method("textDocument/formatting") then
						-- Create a command to allow manual formatting.
						-- You can run it with `:Format`
						vim.api.nvim_create_user_command("Format", function()
							vim.lsp.buf.format({ bufnr = bufnr, async = true })
						end, { desc = "Format current buffer with none-ls" })

						-- Create an autocmd that will run the formatter on the buffer
						-- before every write (`:w`).
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							callback = function()
								-- The `vim.lsp.buf.format` function sends a request to the LSP client
								-- to format the buffer. `none-ls` acts as an LSP client.
								vim.lsp.buf.format({
									bufnr = bufnr,
									-- `async = true` makes it non-blocking.
									async = true,
									-- You can add a filter here to specify which formatters to use.
									-- If you have multiple formatters, you can do:
									-- filter = function(c) return c.name == "prettierd" end,
								})
							end,
						})
					end
				end,
			})
		end,
	},

	-- Linting
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("lint").linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				lua = { "luacheck" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("nvim-lint-autogroup", { clear = true }),
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
