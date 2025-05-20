-- lua/plugins/mason-lspconfig.lua
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
			"eslint",   -- ESLint (optional)
			"lua_ls",   -- Lua
			"emmet_ls", -- Emmet
		},
		automatic_installation = true,
	},
	config = function(_, opts)
		require("mason").setup()
		require("mason-lspconfig").setup(opts)

		local lspconfig = require("lspconfig")

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

		for server, config in pairs(servers) do
			lspconfig[server].setup(config)
		end
	end,
}
