return {
	"williamboman/mason.nvim",
	config = function()
		local ok, mason = pcall(require, "mason")
		if not ok then
			vim.notify("Failed to load mason.nvim: " .. tostring(mason), vim.log.levels.ERROR)
			return
		end

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				border = "rounded",
				width = 0.8,
				height = 0.8,
			},
			-- Add your formatters and linters here!
			ensure_installed = {
				-- Formatters
				"prettier",
				"stylua",

				-- Linters
				"luacheck",
				"eslint",
				"shellcheck",
				"jsonlint",
			},
		})
	end,
}
