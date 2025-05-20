-- Base Config
-- -- lua/plugins/mason-lspconfig.lua
-- return {
-- 	"williamboman/mason-lspconfig.nvim",
-- 	dependencies = {
-- 		"williamboman/mason.nvim",
-- 		"neovim/nvim-lspconfig",
-- 	},
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	opts = {
-- 		ensure_installed = {
-- 			"ts_ls",    -- TypeScript / JavaScript
-- 			"html",     -- HTML
-- 			"cssls",    -- CSS / SCSS
-- 			"tailwindcss", -- TailwindCSS
-- 			"jsonls",   -- JSON
-- 			"eslint",   -- ESLint (optional)
-- 			"lua_ls",   -- Lua
-- 			"emmet_ls", -- Emmet
-- 			"angularls", -- Angular
-- 		},
-- 		automatic_installation = true,
-- 	},
-- 	config = function(_, opts)
-- 		require("mason").setup()
-- 		require("mason-lspconfig").setup(opts)

-- 		local lspconfig = require("lspconfig")

-- 		local servers = {
-- 			ts_ls = {},
-- 			html = {},
-- 			cssls = {},
-- 			tailwindcss = {},
-- 			jsonls = {},
-- 			eslint = {},
-- 			lua_ls = {},
-- 			emmet_ls = {},
-- 			angularls = {},
-- 		}

-- 		for server, config in pairs(servers) do
-- 			lspconfig[server].setup(config)
-- 		end
-- 	end,
-- }


return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		ensure_installed = {
			"ts_ls",    -- TypeScript / JavaScript
			"html",     -- HTML
			"cssls",    -- CSS / SCSS
			"tailwindcss", -- TailwindCSS
			"jsonls",   -- JSON
			"eslint",   -- ESLint
			"lua_ls",   -- Lua
			"emmet_ls", -- Emmet
			"angularls", -- Angular
		},
		automatic_installation = true,
	},
	config = function(_, opts)
		require("mason").setup()
		require("mason-lspconfig").setup(opts)
		local lspconfig = require("lspconfig")

		-- Define server configurations
		local servers = {
			ts_ls = {
				init_options = {
					preferences = {
						importModuleSpecifierPreference = "relative",
						includeCompletionsForImportStatements = true,
						includeCompletionsWithSnippetText = true,
					},
					plugins = {
						-- Support for .component.html and .component.css files
						["@angular/language-service"] = {
							ngServicePath = "node_modules/@angular/language-service",
						},
					},
				},
			},
			html = {
				filetypes = { "html", "handlebars", "hbs", "component.html" },
				init_options = {
					configurationSection = { "html", "css", "javascript" },
					embeddedLanguages = {
						css = true,
						javascript = true,
					},
					provideFormatter = true,
				},
			},
			cssls = {
				filetypes = { "css", "scss", "less", "component.css" },
				settings = {
					css = {
						validate = true,
						lint = {
							unknownAtRules = "ignore", -- Helps with Angular-specific CSS
						},
					},
				},
			},
			tailwindcss = {
				filetypes = { "html", "css", "scss", "javascript", "typescript", "component.html", "component.ts" },
				init_options = {
					userLanguages = {
						["component.html"] = "html",
						["component.ts"] = "typescript",
					},
				},
			},
			jsonls = {
				settings = {
					json = {
						schemas = {
							{
								fileMatch = { "angular.json" },
								url = "https://json.schemastore.org/angular.json",
							},
							{
								fileMatch = { "package.json" },
								url = "https://json.schemastore.org/package.json",
							},
							{
								fileMatch = { "tsconfig.json", "tsconfig.*.json" },
								url = "https://json.schemastore.org/tsconfig.json",
							},
						},
						validate = { enable = true },
					},
				},
			},
			eslint = {
				settings = {
					workingDirectory = { mode = "auto" },
					packageManager = "npm",
					run = "onSave",
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- Recognize vim global for Neovim config
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			},
			emmet_ls = {
				filetypes = { "html", "css", "scss", "javascript", "typescript", "component.html" },
				init_options = {
					html = {
						options = {
							-- Angular-specific snippets
							["bem.enabled"] = true,
						},
					},
				},
			},
			angularls = {
				root_dir = lspconfig.util.root_pattern("angular.json", "project.json"),
				settings = {
					angular = {
						experimental = {
							preserveWhitespaces = true,
							enableIvy = true,
						},
						suggest = {
							fromTripleSlashReference = true,
						},
						preferences = {
							quoteStyle = "single",
						},
						suggestionActions = {
							inferModule = true,
						},
						format = {
							enable = true,
							placeOpenBraceOnNewLineForFunctions = false,
							placeOpenBraceOnNewLineForControlBlocks = false,
						},
					},
				},
			},
		}

		-- Setup all servers with their configurations
		for server, config in pairs(servers) do
			lspconfig[server].setup(config)
		end
	end,
}
