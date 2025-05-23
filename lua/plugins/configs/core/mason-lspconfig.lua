return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"b0o/schemastore.nvim",
	},
	config = function()
		-- Check for dependencies
		local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
		local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
		local lspconfig_util = require("lspconfig.util")

		-- Exit early if critical dependencies are missing
		if not (cmp_nvim_lsp_ok and mason_lspconfig_ok and lspconfig_ok) then
			vim.notify("Failed to load LSP dependencies. Check your plugins.", vim.log.levels.ERROR)
			return
		end

		-- Get LSP capabilities
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Setup mason-lspconfig
		mason_lspconfig.setup({
			ensure_installed = {
				-- "ts_ls",
				-- "html",
				"cssls",
				"lua_ls",
				"angularls",
				"emmet_ls",
				"jsonls",
				"tailwindcss",
				"vimls",
			},
			automatic_installation = true,
			handlers = { -- Handlers are now a key within this setup table
				-- Default handler
				-- function(server_name)
				-- 	lspconfig[server_name].setup({
				-- 		capabilities = capabilities,
				-- 		on_attach = vim.g.common_on_attach, -- Use the globally defined on_attach function
				-- 	})
				-- end,

				-- Custom handler for angularls
				["angularls"] = function()
					lspconfig.angularls.setup({
						capabilities = capabilities,
						on_attach = vim.g.common_on_attach,
						cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" },
						filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
						root_dir = lspconfig_util.root_pattern(
							"angular.json",
							"project.json",
							".angular-cli.json",
							"angular-cli.json"
						),
						settings = {
							angular = {
								experimental = {
									completions = { emmet = true },
								},
								trace = { server = "messages" },
								templateParser = { enabled = true },
								strictTemplates = true,
								diagnostics = {
									["template"] = true,
									["checkBinding"] = true,
									["checkTemplate"] = true,
									["checkMissingControls"] = true,
									["checkReferencedContent"] = true,
									["checkComponentSelectors"] = true,
									["checkMissingInputs"] = true,
									["semanticTemplateCheck"] = true,
								},
								preferredImports = { fromNgImport = true },
							},
						},
					})
				end,

				-- Custom handler for cssls
				["cssls"] = function()
					lspconfig.cssls.setup({
						capabilities = capabilities,
						on_attach = vim.g.common_on_attach,
						filetypes = { "css", "scss", "less" },
						settings = {
							css = {
								validate = true,
								lint = { unknownAtRules = "ignore" },
							},
							scss = {
								validate = true,
								lint = {
									unknownAtRules = "ignore",
									unknownProperties = "ignore",
									unknownVendorSpecificProperties = "ignore",
								},
							},
							less = {
								validate = true,
								lint = { unknownAtRules = "ignore" },
							},
						},
					})
				end,

				-- Custom handler for jsonls
				["jsonls"] = function()
					local schemastore_ok, schemastore = pcall(require, "schemastore")
					local schemas = schemastore_ok and schemastore.json.schemas() or {}

					lspconfig.jsonls.setup({
						capabilities = capabilities,
						on_attach = vim.g.common_on_attach,
						filetypes = { "json", "jsonc" },
						settings = {
							json = {
								schemas = schemas,
								validate = { enable = true },
							},
						},
					})
				end,

				-- Custom handler for lua_ls
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_attach = vim.g.common_on_attach,
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								diagnostics = {
									globals = { "vim" },
									disable = "missing-fields",
								},
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
								telemetry = { enable = false },
							},
						},
					})
				end,

				-- Custom handler for tailwindcss
				["tailwindcss"] = function()
					lspconfig.tailwindcss.setup({
						capabilities = capabilities,
						on_attach = function(client, bufnr)
							if vim.g.common_on_attach then
								vim.g.common_on_attach(client, bufnr)
							end
						end,
						filetypes = {
							"html",
							"css",
							"scss",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
						},
						settings = {
							tailwindCSS = {
								validate = true,
								lint = {
									cssConflict = "ignore",
									invalidApply = "ignore",
									invalidScreen = "ignore",
									invalidVariant = "ignore",
									invalidConfigPath = "ignore",
									invalidTailwindDirective = "ignore",
									recommendedVariantOrder = "ignore",
								},
								experimental = {
									classRegex = {
										{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
										{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
										{ "@apply\\s+([^;}]*)", "([^\\s]*)" },
										{ "@apply\\s+([^}]*)\\}\\s*", "([^\\s]*)" },
									},
								},
								includeLanguages = {
									typescriptreact = "typescriptreact",
									html = "html",
									javascript = "javascript",
									typescript = "typescript",
									css = "css",
									scss = "scss",
								},
							},
						},
					})
				end,

				-- Custom handler for tsserver (TypeScript)
				-- ["ts_ls"] = function()
				-- 	lspconfig.ts_ls.setup({
				-- 		capabilities = capabilities,
				-- 		on_attach = vim.g.common_on_attach,
				-- 		filetypes = {
				-- 			"javascript",
				-- 			"javascriptreact",
				-- 			"javascript.jsx",
				-- 			"typescript",
				-- 			"typescriptreact",
				-- 			"typescript.tsx",
				-- 		},
				-- 		root_dir = lspconfig_util.root_pattern("tsconfig.json", "jsconfig.json", "package.json"),
				-- 		settings = {
				-- 			typescript = {
				-- 				inlayHints = {
				-- 					includeInlayParameterNameHints = "all",
				-- 					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				-- 					includeInlayFunctionParameterTypeHints = true,
				-- 					includeInlayVariableTypeHints = true,
				-- 					includeInlayPropertyDeclarationTypeHints = true,
				-- 					includeInlayFunctionLikeReturnTypeHints = true,
				-- 					includeInlayEnumMemberValueHints = true,
				-- 				},
				-- 			},
				-- 			javascript = {
				-- 				inlayHints = {
				-- 					includeInlayParameterNameHints = "all",
				-- 					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				-- 					includeInlayFunctionParameterTypeHints = true,
				-- 					includeInlayVariableTypeHints = true,
				-- 					includeInlayPropertyDeclarationTypeHints = true,
				-- 					includeInlayFunctionLikeReturnTypeHints = true,
				-- 					includeInlayEnumMemberValueHints = true,
				-- 				},
				-- 			},
				-- 		},
				-- 	})
				-- end,
			},
		})
	end,
}
