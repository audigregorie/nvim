return {
	"mfussenegger/nvim-lint",
	event = "VeryLazy", -- Or { "BufReadPre", "BufNewFile" }
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			-- Lua
			lua = { "luacheck" },

			-- JavaScript / TypeScript (example using eslint_d for better performance)
			javascript = { "eslint" },
			javascriptreact = { "eslint" },
			typescript = { "eslint" },
			typescriptreact = { "eslint" },

			-- JSON
			json = { "jsonlint" }, -- Example: requires `jsonlint` CLI tool

			-- Shell scripts
			sh = { "shellcheck" },

			-- Add more filetypes and their linters as needed:
			-- python = { "flake8", "pylint" },
			-- css = { "stylelint" },
			-- markdown = { "markdownlint" },
		}

		-- Optional: Add a keymap for manual linting of the current buffer
		vim.keymap.set("n", "<leader>cl", function()
			lint.try_lint()
		end, { desc = "Lint current file" })
	end,
}
