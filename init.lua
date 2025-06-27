-- This allows `require("configs.filename")` to correctly find files
-- in `lua/configs/filename.lua`.
vim.opt.runtimepath:append(vim.fn.stdpath("config") .. "/lua")

require("configs.options")
require("configs.keymaps")
require("configs.autocmds")
require("configs.highlights")

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	-- Require plugins into the config
	require("plugins.autopairs"),
	require("plugins.avante"),
	require("plugins.claudecode"),
	require("plugins.codesnap"),
	require("plugins.colorscheme"),
	require("plugins.diffview"),
	require("plugins.gitsigns"),
	require("plugins.guess-indent"),
	require("plugins.harpoon"),
	require("plugins.lazydev"),
	require("plugins.lazygit"),
	require("plugins.lsp-cmp"),
	require("plugins.lualine"),
	require("plugins.mini"),
	require("plugins.oil"),
	require("plugins.supermaven"),
	require("plugins.telescope"),
	require("plugins.trouble"),
	require("plugins.undotree"),
	require("plugins.vim-fugitive"),

	-- Unused plugins
	-- require 'plugins.codecompanion',
	-- require("plugins.copilot"),
	-- require 'plugins.indent_line',
	-- require 'plugins.neo-tree',
	-- require 'plugins.todo-comments',
	-- require 'plugins.which-key',

	-- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
	---@diagnostic disable-next-line: missing-fields
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
	-- Performance optimizations
	performance = {
		cache = {
			enabled = true,
		},
		-- reset_packpath = true,
		rtp = {
			disabled_plugins = {
				-- "gzip",        -- Automatic gzip file handling
				-- "matchit",     -- Extended % matching for HTML/XML tags
				-- "matchparen",  -- Highlight matching parentheses
				"netrwPlugin", -- Built-in file explorer (you're using oil.nvim)
				-- "tarPlugin",   -- Tar file handling
				"tohtml", -- Convert buffer to HTML
				"tutor", -- Vim tutor (:Tutor command)
				-- "zipPlugin",   -- Zip file handling
			},
		},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
