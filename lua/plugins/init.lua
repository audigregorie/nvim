-- Plugin management with lazy.nvim

return require("lazy").setup({
	-- Lazy can manage itself
	"folke/lazy.nvim",

	-- Core dependencies
	"nvim-lua/plenary.nvim",

	-- -- Import plugin specs from other files
	-- -- Core utilities and language support
	{ import = "plugins.configs.treesitter" }, -- Treesitter for better syntax highlighting and parsing
	{ import = "plugins.configs.mason-lspconfig" }, -- Bridges Mason with lspconfig for easier setup
	-- -- { import = "plugins.configs.mason-null-ls" }, -- Integrates Mason with null-ls for formatters and linters
	{ import = "plugins.configs.mason" }, -- Package manager for LSP, DAP, linters, formatters
	{ import = "plugins.configs.nvim-lspconfig" }, -- Easy configuration for built-in LSP support
	{ import = "plugins.configs.conform" }, -- Null-ls for additional LSP functionality (formatting, diagnostics)
	{ import = "plugins.configs.nvim-cmp" }, -- Autocompletion framework
	{ import = "plugins.configs.colorscheme" }, -- Color scheme management

	-- -- UI Enhancements
	{ import = "plugins.configs.nvim-code-action-menu" }, -- Enhanced UI for LSP code actions
	{ import = "plugins.configs.dressing" }, -- Improves UI for built-in Neovim selection prompts
	{ import = "plugins.configs.noice" }, -- Enhanced notifications, command UI, and messages
	{ import = "plugins.configs.nvim-highlight-colors" }, -- Highlights color codes in files
	{ import = "plugins.configs.nvim-navic" }, -- Displays LSP breadcrumbs in statusline
	{ import = "plugins.configs.nvim-notify" }, -- Fancy notification UI for messages
	{ import = "plugins.configs.nvim-scrollbar" }, -- Adds a visual scrollbar with markers
	{ import = "plugins.configs.rainbow-delimiters" }, -- bracket highlighting in code
	{ import = "plugins.configs.transparent" }, -- Makes Neovim UI transparent

	-- -- Git Integration
	{ import = "plugins.configs.diffview" }, -- Git diff viewer
	{ import = "plugins.configs.git-blame" }, -- Inline Git blame annotations
	{ import = "plugins.configs.gitsigns" }, -- Git decorations (signs, hunks, etc.)
	{ import = "plugins.configs.lazygit" }, -- Git integration GUI for Neovim
	{ import = "plugins.configs.vim-fugitive" }, -- Git interface for neovim
	{ import = "plugins.configs.neogit" }, -- Magit-like Git interface for Neovim

	-- -- Statusline & UI Improvements
	{ import = "plugins.configs.lualine" }, -- Statusline plugin
	{ import = "plugins.configs.neo-tree" }, -- File explorer for Neovim
	{ import = "plugins.configs.telescope" }, -- Fuzzy finder UI
	{ import = "plugins.configs.trouble" }, -- Diagnostics and quickfix list UI

	-- -- Snippets & Editing Enhancements
	{ import = "plugins.configs.luasnip" }, -- Snippet engine
	{ import = "plugins.configs.friendly-snippets" }, -- Friendly snippets
	{ import = "plugins.configs.nvim-auto-pairs" }, -- Auto-closes brackets and quotes
	{ import = "plugins.configs.nvim-ts-autotag" }, -- Auto-closes and renames HTML/XML tags
	{ import = "plugins.configs.mini-cursorword" }, -- Highlights the word under the cursor
	{ import = "plugins.configs.mini-indentscope" }, -- Visualizes indentation levels

	-- -- Scrolling & Navigation
	{ import = "plugins.configs.neoscroll" }, -- Smooth scrolling
	{ import = "plugins.configs.nvim-tmux-navigation" }, -- Seamless navigation between Neovim and Tmux
	{ import = "plugins.configs.oil" }, -- A file explorer alternative with a minimal UI
	{ import = "plugins.configs.harpoon" }, -- Marks and retrieves files

	-- -- Tailwind & Markdown Support
	{ import = "plugins.configs.md-headers" }, -- Improves markdown header navigation
	{ import = "plugins.configs.render-markdown" }, -- Renders markdown files and more
	{ import = "plugins.configs.tailwindcss-colorizer-cmp" }, -- Enhances TailwindCSS autocomplete with color previews

	-- -- Terminal & Debugging
	{ import = "plugins.configs.toggleterm" }, -- Integrated terminal manager
	{ import = "plugins.configs.ts-error-translator" }, -- Translates TypeScript errors for better readability
	{ import = "plugins.configs.undotree" }, -- Visual undo history tree

	-- -- Commenting & Editing Utilities
	{ import = "plugins.configs.fast-cursor-move" }, -- Accerlate the speed of cursor movement
	{ import = "plugins.configs.vim-commentary" }, -- Easy commenting
	{ import = "plugins.configs.vim-px-to-rem" }, -- Converts px to rem in CSS files
	{ import = "plugins.configs.vim-sleuth" }, -- Detects and sets indentation settings automatically
	{ import = "plugins.configs.vim-surround" }, -- Adds shortcuts for surrounding text with brackets, quotes, etc.

	-- -- AI-powered
	{ import = "plugins.configs.supermaven" }, -- AI-powered autocomplete

	-- -- Inactive Plugins (Commented Out)
	-- -- { import = "plugins.configs.avante" }, -- (AI-powered IDE functionality e.g. Cursor)
	-- -- { import = "plugins.configs.luarocks" }, -- Manages Lua dependencies
	-- -- { import = "plugins.configs.nvim-tree" }, -- File explorer for Neovim
	-- -- { import = "plugins.configs.rest" }, -- REST client for Neovim
	-- -- { import = "plugins.configs.vim-markdown" }, -- Enhances markdown editing
}, {
	-- Lazy.nvim configuration for optimization
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	-- install = {
	-- colorscheme = { "tokyonight", "habamax" },
	-- },
	checker = {
		enabled = true,
		frequency = 86400, -- Check for updates once a day
	},
})

