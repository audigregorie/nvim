return {
	"stevearc/conform.nvim",
	event = "VeryLazy", -- Or { "BufReadPre", "BufNewFile" }
	opts = {
		-- Map filetypes to formatters
		formatters_by_ft = {
			lua = { "stylua" },

			-- For JavaScript, TypeScript, JSON, HTML, CSS, SCSS etc.
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			vue = { "prettier" }, -- If you use Vue
			json = { "prettier" },
			jsonc = { "prettier" }, -- For JSON with comments
			yaml = { "prettier" },
			markdown = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			htmlangular = { "prettier" },
			-- You can also specify multiple formatters, they run in order
			-- javascript = { "prettier", "eslint --fix" }, -- Example: Prettier then ESLint fix

			-- Universal fallback formatters
			["_"] = { "trim_whitespace" }, -- Trim trailing whitespace for any filetype
		},

		-- Enable format on save
		format_on_save = {
			timeout_ms = 700, -- Max time to wait for formatting
			lsp_fallback = true, -- Fallback to LSP formatting if conform fails or no formatter is found
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)

		-- Optional: Add a keymap for manual formatting of the current buffer or a visual selection
		vim.keymap.set({ "n", "v" }, "<leader>cf", function()
			require("conform").format({ async = true, lsp_fallback = "fallback" })
		end, { desc = "Format code" })
	end,
}
