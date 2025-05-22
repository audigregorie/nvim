return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
		if not ok then
			vim.notify("Failed to load nvim-treesitter.configs", vim.log.levels.ERROR)
			return
		end

		-- Setup TreeSitter for highlighting, indentation, etc.
		treesitter_configs.setup({
			ensure_installed = {
				"html",
				"css",
				"scss",
				"javascript",
				"typescript",
				"tsx",
				"lua",
				"git_rebase",
				"gitcommit",
				"angular",
				"json",
				"markdown",
				"markdown_inline",
				"vim",
			},
			highlight = { enable = true },
			indent = { enable = true },
			sync_install = false,
			auto_install = true,
			ignore_install = {},
			modules = {},
		})

		-- Ensure TreeSitter is enabled for all files
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function()
				-- Enable TreeSitter highlighting for the current buffer
				vim.cmd("TSBufEnable highlight")
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				-- For Treesitter
				vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = "#FF7E5F", bold = true }) -- Coral orange
				vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = "#6C8EBF", bold = true }) -- Dusty blue
				vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = "#B27BB4", bold = true }) -- Lavender purple
				vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = "#7CB9A1", bold = true }) -- Sage green
				vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { fg = "#76C1D4", bold = true }) -- Sky blue
				vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { fg = "#D4BF6A", bold = true }) -- Muted gold
			end,
		})
	end,
}
