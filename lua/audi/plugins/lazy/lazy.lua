-- Automatically install lazy.nvim if it doesn't exist
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Use lazy.nvim to manage plugins
require("lazy").setup({
	spec = {
		{
			{ import = "audi.plugins.colorscheme" }, -- Color scheme management

			-- Core utilities and language support
			{ import = "audi.plugins.core.mason" }, -- Package manager for LSP, DAP, linters, formatters
			{ import = "audi.plugins.core.mason-lspconfig" }, -- Bridges Mason with lspconfig for easier setup
			{ import = "audi.plugins.core.mason-null-ls" }, -- Integrates Mason with null-ls for formatters and linters
			{ import = "audi.plugins.core.null-ls" }, -- Null-ls for additional LSP functionality (formatting, diagnostics)
			{ import = "audi.plugins.core.nvim-cmp" }, -- Autocompletion framework
			{ import = "audi.plugins.core.nvim-code-action-menu" }, -- Enhanced UI for LSP code actions
			{ import = "audi.plugins.core.nvim-lspconfig" }, -- Easy configuration for built-in LSP support
			{ import = "audi.plugins.core.treesitter" }, -- Treesitter for better syntax highlighting and parsing

			-- UI Enhancements
			{ import = "audi.plugins.dressing" }, -- Improves UI for built-in Neovim selection prompts
			{ import = "audi.plugins.noice" }, -- Enhanced notifications, command UI, and messages
			{ import = "audi.plugins.nvim-highlight-colors" }, -- Highlights color codes in files
			{ import = "audi.plugins.nvim-navic" }, -- Displays LSP breadcrumbs in statusline
			{ import = "audi.plugins.nvim-notify" }, -- Fancy notification UI for messages
			{ import = "audi.plugins.nvim-scrollbar" }, -- Adds a visual scrollbar with markers
			{ import = "audi.plugins.rainbow-delimiters" }, -- bracket highlighting in code
			{ import = "audi.plugins.transparent" }, -- Makes Neovim UI transparent

			-- Git Integration
			{ import = "audi.plugins.git.diffview" }, -- Git diff viewer
			{ import = "audi.plugins.git.git-blame" }, -- Inline Git blame annotations
			{ import = "audi.plugins.git.gitsigns" }, -- Git decorations (signs, hunks, etc.)
			{ import = "audi.plugins.git.lazygit" }, -- Git integration GUI for Neovim
			{ import = "audi.plugins.git.neogit" }, -- Magit-like Git interface for Neovim

			-- Statusline & UI Improvements
			{ import = "audi.plugins.lualine" }, -- Statusline plugin
			{ import = "audi.plugins.nvim-tree" }, -- File explorer for Neovim
			{ import = "audi.plugins.telescope" }, -- Fuzzy finder UI
			{ import = "audi.plugins.trouble" }, -- Diagnostics and quickfix list UI

			-- Snippets & Editing Enhancements
			{ import = "audi.plugins.luasnip" }, -- Snippet engine
			{ import = "audi.plugins.friendly-snippets" }, -- Friendly snippets
			{ import = "audi.plugins.nvim-auto-pairs" }, -- Auto-closes brackets and quotes
			{ import = "audi.plugins.nvim-ts-autotag" }, -- Auto-closes and renames HTML/XML tags
			{ import = "audi.plugins.mini-cursorword" }, -- Highlights the word under the cursor
			{ import = "audi.plugins.mini-indentscope" }, -- Visualizes indentation levels

			-- Scrolling & Navigation
			{ import = "audi.plugins.neoscroll" }, -- Smooth scrolling
			{ import = "audi.plugins.nvim-tmux-navigation" }, -- Seamless navigation between Neovim and Tmux
			{ import = "audi.plugins.oil" }, -- A file explorer alternative with a minimal UI
			{ import = "audi.plugins.harpoon" }, -- Marks and retrieves files

			-- Tailwind & Markdown Support
			{ import = "audi.plugins.md-headers" }, -- Improves markdown header navigation
			{ import = "audi.plugins.tailwindcss-colorizer-cmp" }, -- Enhances TailwindCSS autocomplete with color previews

			-- Terminal & Debugging
			{ import = "audi.plugins.toggleterm" }, -- Integrated terminal manager
			{ import = "audi.plugins.ts-error-translator" }, -- Translates TypeScript errors for better readability
			{ import = "audi.plugins.undotree" }, -- Visual undo history tree

			-- Commenting & Editing Utilities
			{ import = "audi.plugins.fast-cursor-move" }, -- Accerlate the speed of cursor movement
			{ import = "audi.plugins.vim-commentary" }, -- Easy commenting
			{ import = "audi.plugins.vim-px-to-rem" }, -- Converts px to rem in CSS files
			{ import = "audi.plugins.vim-sleuth" }, -- Detects and sets indentation settings automatically
			{ import = "audi.plugins.vim-surround" }, -- Adds shortcuts for surrounding text with brackets, quotes, etc.

			-- AI-powered
			{ import = "audi.plugins.supermaven" }, -- AI-powered autocomplete

			-- Inactive Plugins (Commented Out)
			-- { import = "audi.plugins.avante" }, -- (AI-powered IDE functionality e.g. Cursor)
			-- { import = "audi.plugins.luarocks" }, -- Manages Lua dependencies
			-- { import = "audi.plugins.rest" }, -- REST client for Neovim
			-- { import = "audi.plugins.vim-markdown" }, -- Enhances markdown editing
		},
	},
}, {})
