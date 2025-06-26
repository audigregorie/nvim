-- ## Options ##
--
-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
--
-- Performance Optimization
vim.opt.shadafile = "NONE" -- Don't read/write shada file on startup/exit
vim.opt.updatetime = 250 -- Faster completion (4000ms default)
vim.opt.timeoutlen = 300 -- Time to wait for mapped sequence (ms)
vim.opt.history = 500 -- Number of commands to remember
vim.opt.hidden = true -- Allow buffers to be hidden without saving

-- File Handling
vim.opt.confirm = true -- If operation will fail, ask if you wish to save
vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't backup before overwriting
vim.opt.swapfile = false -- Don't create swap files
vim.opt.undofile = true -- Enable persistent undo
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir" -- Where to save undo history

-- Visual UI Elements
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.numberwidth = 3 -- Width of number column
vim.opt.statuscolumn = "%s %l   " -- Control the left gutter — numbers, signs, spacing, etc
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.cursorline = true -- Highlight current line
vim.opt.cursorlineopt = "number" -- Highlight only line number
vim.opt.showmode = false -- Hide mode indicator (INSERT/NORMAL)
vim.opt.showtabline = 0 -- Never show tabs
vim.opt.title = true -- Show filename in window title
vim.opt.fillchars = { eob = "~" } -- Character for end-of-buffer lines
vim.opt.termguicolors = true -- True color support
vim.opt.cmdheight = 1 -- Command line height
vim.opt.pumheight = 10 -- Popup menu height
vim.opt.background = "dark" -- Use dark background

-- Status Line
vim.opt.laststatus = 3 -- Global status line (Neovim 0.7+)

-- Search and Completion
vim.opt.hlsearch = true -- Highlight search matches
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true -- Override ignorecase when search includes uppercase
vim.opt.completeopt = { "menuone", "noselect" } -- Completion options
vim.opt.shortmess:append("c") -- Don't show completion messages

-- Indentation and Whitespace
vim.opt.tabstop = 2 -- Width of tab character
vim.opt.softtabstop = 2 -- Width of soft tab
vim.opt.shiftwidth = 2 -- Width of indent
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true -- Copy indent from current line when starting new line

-- Text Display
vim.opt.wrap = true -- Wrap long lines
vim.opt.linebreak = true -- Wrap at word boundaries
vim.opt.lbr = true -- Alias for linebreak
vim.opt.breakindent = true -- Preserve indentation in wrapped lines
vim.opt.conceallevel = 0 -- Don't hide markup (e.g., in markdown)
vim.opt.iskeyword:append("-") -- Treat hyphenated words as one word
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- Don't auto-insert comments

-- Window Behavior
vim.opt.splitbelow = true -- New horizontal splits go below
vim.opt.splitright = true -- New vertical splits go right
vim.opt.diffopt = "vertical" -- Vertical diff
vim.opt.scrolloff = 8 -- Min lines to keep above/below cursor
vim.opt.sidescrolloff = 10 -- Min columns to keep left/right of cursor

-- Input
vim.opt.mouse = "a" -- Enable mouse in all modes
vim.opt.backspace = { "indent", "eol", "start" } -- Backspace behavior
vim.opt.guicursor = "a:block" -- Use block cursor in all modes
vim.o.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.shell = "zsh" -- Shell to use for external commands

-- [[ Basic Keymaps ]]
--
-- No operation for the space key in normal and visual mode
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Setting "Q" to nothing, dangerous button
vim.keymap.set("n", "Q", "<nop>")

-- keymap to copy to system clipboard
-- vim.keymap.set('n', 'y', '"+y')
-- vim.keymap.set('v', 'y', '"+y')

-- Remap split windows vertically and horizontally
vim.keymap.set("n", "<leader>|", "<C-w>v")
vim.keymap.set("n", "<leader>_", "<C-w>s")

-- Remap to go into normal mode
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "kj", "<ESC>")

-- Paste below without indentation
vim.keymap.set("n", "p", "]p")
vim.keymap.set("n", "P", "[p")

-- Toggle between previous file and current file
vim.keymap.set("n", "<leader><leader>", "<c-^>")

-- Swap between last two buffers
vim.keymap.set("n", "<leader>'", "<C-^>", { desc = "Switch to last buffer", noremap = true, silent = true })

-- Press 'S' for quick find/replace for the word under the cursor
vim.keymap.set("n", "S", function()
	local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end, { noremap = true, silent = true })

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vim.keymap.set("n", "L", "$", { noremap = true, silent = true })
vim.keymap.set("n", "H", "^", { noremap = true, silent = true })

-- Turn off highlighted results
vim.keymap.set("n", "<leader>nh", "<cmd>noh<cr>", { noremap = true, silent = true })

-- Yank and then comment out the selected code in visual mode
vim.keymap.set("x", "<leader>y", function()
	-- Yank the selected lines
	vim.cmd('normal! "+y')

	-- Get the range of the selected lines
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")

	-- Comment out the entire range
	vim.cmd(start_line .. "," .. end_line .. "Commentary")

	-- Move the cursor to the last line
	vim.fn.cursor(end_line, 0)
end, { noremap = true, silent = true })

-- Navigate split windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Navigate split windows in the terminal
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { noremap = true, silent = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { noremap = true, silent = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { noremap = true, silent = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { noremap = true, silent = true })

-- Resize split windows to be equal size
vim.keymap.set("n", "<leader>=", "<C-w>=", { noremap = true, silent = true })

-- For macOS with Option key (Meta key in Neovim)
vim.keymap.set("n", "<M-h>", ":vertical resize +2<CR>", { silent = true, desc = "Increase window width" })
vim.keymap.set("n", "<M-l>", ":vertical resize -2<CR>", { silent = true, desc = "Decrease window width" })
vim.keymap.set("n", "<M-j>", ":resize +2<CR>", { silent = true, desc = "Increase window height" })
vim.keymap.set("n", "<M-k>", ":resize -2<CR>", { silent = true, desc = "Decrease window height" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- Paste and keep the replaced text in register
vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true })

-- Move text up and down in visual mode
vim.keymap.set("v", "<S-j>", ":m '>+1<cr>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-k>", ":m '<-2<cr>gv=gv", { noremap = true, silent = true })

-- Remap to indent and outdent lines or blocks of code
vim.keymap.set("n", "<Tab>", ">>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true, silent = true })
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Toggle boolean
local function toggle_boolean()
	local word = vim.fn.expand("<cword>")
	if word == "true" then
		vim.cmd("normal! ciwfalse")
	elseif word == "false" then
		vim.cmd("normal! ciwtrue")
	end
end

vim.keymap.set("n", "<leader>`", toggle_boolean, { noremap = true, silent = true, desc = "Toggle true/false" })

-- Toggle LSP inlay hints
vim.keymap.set("n", "<leader>ih", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
	vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
end, { desc = "Toggle Inlay Hints" })

-- Git preview hunk
vim.keymap.set("n", "<leader>ph", ":Gitsigns preview_hunk<CR>", { noremap = true, desc = "Gitsigns: preview [h]unk" })
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { noremap = true, desc = "Git: blame" })
vim.keymap.set("n", "<leader>gl", ":Gclog<CR>", { noremap = true, desc = "Git: log" })
-- Gclog (to see the commits, copy the commit hash and run :Gdiffsplit <hash>)

-- [[ Autocommands ]]
--  See `:help lua-guide-autocommands`

-- ## Yank Highlighting
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- ## Relative Number Settings
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
	pattern = "*",
	callback = function()
		vim.wo.relativenumber = true
	end,
	desc = "Enable relative numbers",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf", "terminal" },
	callback = function()
		vim.wo.relativenumber = false
	end,
	desc = "Disable relative numbers for quickfix and terminal",
})

-- ## Formatting Options
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	command = "setlocal formatoptions-=cro",
	desc = "Disable comment continuation on new lines",
})

-- ##  Markdown Code Highlighting
vim.api.nvim_create_autocmd({ "FileType", "ColorScheme" }, {
	pattern = { "markdown" },
	callback = function()
		vim.api.nvim_set_hl(0, "markdownCode", { bg = "#2A3542" })
		vim.api.nvim_set_hl(0, "markdownCodeBlock", { bg = "#2A3542" })
	end,
})

-- vim.api.nvim_create_autocmd('QuitPre', {
--   callback = function()
--     -- Try to close Neo-tree if it's open
--     vim.cmd 'Neotree close'
--   end,
-- })
vim.api.nvim_create_autocmd("QuitPre", {
	callback = function()
		-- Check if any window has a buffer with filetype 'neo-tree'
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(win)
			local ft = vim.api.nvim_buf_get_option(buf, "filetype")
			if ft == "neo-tree" then
				vim.cmd("Neotree close")
				break
			end
		end
	end,
})

-- ## Window split
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "#000000", fg = "#222222" })

-- ## NvimTree Highlighting
-- vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { fg = '#FF8800' }) -- Folder icons
-- vim.api.nvim_set_hl(0, 'NvimTreeOpenedFolderName', { fg = '#7bace0', bg = '#111112' })
-- vim.api.nvim_set_hl(0, 'NvimTreeOpenedFile', { fg = '#7bace0' }) -- Files that are open in a buffer
-- -- vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#4682B4" })       -- Default/closed folders

-- ## Git diff
-- Clear backgrounds and set readable foreground colors for diff highlighting
vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#00af00", bg = "NONE" }) -- Bright but readable green
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#d70000", bg = "NONE" }) -- Readable red
vim.api.nvim_set_hl(0, "DiffChange", { fg = "#5f5fff", bg = "NONE" }) -- Blue for changed lines
vim.api.nvim_set_hl(0, "DiffText", { fg = "#d75f00", bg = "NONE" }) -- Orange for changed text within lines

-- ## Render Markdown
vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { bg = "#171717", blend = 70 })
vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { bg = "#171717", blend = 70 })
vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { bg = "#171717", blend = 70 })
vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "#171717", blend = 70 })
vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { bg = "#171717", blend = 70 })
vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { bg = "#171717", blend = 70 })

vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#bf7d56" })
vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = "#bf7d56" })
vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = "#bf7d56" })
vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = "#bf7d56" })
vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = "#bf7d56" })
vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = "#bf7d56" })

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
	-- Enhanced Lua development for Neovim config
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"Mofiqul/vscode.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			require("vscode").setup({
				-- Enable transparent background
				transparent = true,
				-- Style configurations
				styles = {
					sidebars = "transparent",
					floats = "transparent",
					comments = { italic = false }, -- Disable italics in comments
				},
				-- Optional: enables terminal colors matching the theme
				terminal_colors = true,
				-- Optional: style tweaks
				italic_comments = true,
				underline_links = true,
				-- Transparent backgrounds and borders for various UI elements
				group_overrides = {
					-- StatusLine = { bg = "NONE" },
					-- StatusLineNC = { bg = "NONE" },
					NormalFloat = { bg = "NONE" },
					VertSplit = { fg = "#000000" },
					FloatBorder = { fg = "#252525" },
					Pmenu = { bg = "NONE" },
					-- PmenuSel = { bg = "NONE" },
					-- NormalNC = { bg = "NONE" },
					-- LineNr = { bg = "NONE" },
					-- SignColumn = { bg = "NONE" },
					-- EndOfBuffer = { bg = "NONE" },
					-- -- Add plugin-specific borders as needed:
					-- TelescopeBorder = { fg = "#252525" },
				},
			})
			-- Load the colorscheme here.
			vim.cmd.colorscheme("vscode")
		end,
	},
	-- Angular-specific enhancements
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"angular",
					"typescript",
					"javascript",
					"html",
					"css",
					"scss",
					"json",
					"yaml",
					"lua",
					"vim",
				},
				auto_install = true,
				sync_install = false,
				ignore_install = {},
				modules = {},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
						},
					},
				},
			})
		end,
	},

	-- LSP Configuration with better Angular support
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Mason for LSP/tool management
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Better status updates
			{ "j-hui/fidget.nvim", opts = {} },

			-- Schema store for better JSON/YAML support
			"b0o/schemastore.nvim",
		},
		config = function()
			-- LSP attach configuration
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Essential LSP mappings
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
					map("<leader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("<leader>gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("<leader>gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("<leader>gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("<C-k>", vim.lsp.buf.signature_help, "Signature Help", "i")

					-- Document highlighting
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- Inlay hints toggle
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Enhanced diagnostic configuration
			vim.diagnostic.config({
				severity_sort = true,
				float = {
					border = "rounded",
					source = "if_many",
					header = "",
					prefix = "",
				},
				underline = { severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN } },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚",
						[vim.diagnostic.severity.WARN] = "󰀪",
						[vim.diagnostic.severity.INFO] = "󰋽",
						[vim.diagnostic.severity.HINT] = "󰌶",
					},
				},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					prefix = "●",
				},
			})

			-- Enhanced capabilities for completion
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- LSP servers configuration
			local servers = {
				-- Angular Language Server (UNCOMMENTED FOR ANGULAR SUPPORT)
				angularls = {
					-- Ensure Mason installs 'angular-language-server' for this to work.
					-- Filetypes for Angular templates and TypeScript files.
					filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular", "angular" },
					-- Automatically detect Angular projects by looking for angular.json or project.json.
					root_dir = require("lspconfig.util").root_pattern("angular.json", "project.json"),
					settings = {
						angular = {
							forceStrictTemplates = false,
							enable_strict_mode_prompt = false,
							disable_version_check = true,
							log = "off",
						},
					},
				},

				-- TypeScript Language Server
				ts_ls = {
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
					root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
					init_options = {
						preferences = {
							disableSuggestions = false,
							quotePreference = "single",
							includeCompletionsForModuleExports = true,
							includeCompletionsForImportStatements = true,
							includeCompletionsWithSnippetText = true,
							includeAutomaticOptionalChainCompletions = true,
						},
					},
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
							-- Disable specific TypeScript checks that cause false positives with Angular standalone
							preferences = {
								includePackageJsonAutoImports = "off",
							},
							suggest = {
								autoImports = false, -- Disable auto-imports that might conflict with Angular standalone
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
					-- Filter TypeScript diagnostics for Angular-specific false positives
					handlers = {
						["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
							if result and result.diagnostics then
								result.diagnostics = vim.tbl_filter(function(diagnostic)
									local message = diagnostic.message:lower()
									local code = diagnostic.code
									-- Filter out specific TypeScript errors that are false positives in Angular
									return not (
										code == 2307 -- Cannot find module
										or code == 2304 -- Cannot find name
										or code == 2322 -- Type is not assignable (common with Angular standalone)
										or message:match("cannot find module") and message:match("@angular")
										or message:match("has no exported member") and message:match("standalone")
									)
								end, result.diagnostics)
							end
							vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
						end,
					},
				},

				-- Enhanced HTML support with Angular templates
				html = {
					filetypes = { "html", "htmlangular", "angular" }, -- Added 'angular' for explicit recognition
					settings = {
						html = {
							format = {
								templating = true,
								wrapLineLength = 120,
								wrapAttributes = "auto",
							},
							hover = {
								documentation = true,
								references = true,
							},
						},
					},
				},

				-- CSS/SCSS support
				cssls = {
					filetypes = { "css", "scss", "less" },
					settings = {
						css = {
							validate = true,
							lint = {
								unknownAtRules = "ignore",
							},
						},
						scss = {
							validate = true,
							lint = {
								unknownAtRules = "ignore",
							},
						},
					},
				},

				-- Tailwind CSS
				tailwindcss = {
					filetypes = {
						"css",
						"scss",
						"sass",
						"html",
						"htmlangular", -- Already included, good.
						"typescript",
						"javascript",
						"angular", -- Added 'angular' for explicit recognition
					},
					settings = {
						tailwindCSS = {
							lint = {
								cssConflict = "warning",
								invalidApply = "error",
								invalidConfigPath = "error",
								invalidScreen = "error",
								invalidTailwindDirective = "error",
								invalidVariant = "error",
								recommendedVariantOrder = "warning",
							},
							validate = true,
							classAttributes = { "class", "className", "classList", "ngClass" },
							experimental = {
								classRegex = {
									{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
									{ "cx\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								},
							},
						},
					},
					init_options = {
						userLanguages = {
							htmlangular = "html",
							angular = "html", -- Explicitly map 'angular' filetype to 'html' for Tailwind
						},
					},
				},

				-- JSON with schema support
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},

				-- YAML with schema support
				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				},

				-- Lua for Neovim config
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								checkThirdParty = false,
							},
						},
					},
				},

				-- ESLint
				eslint = {
					filetypes = {
						"javascript",
						"typescript",
					},
					settings = {
						workingDirectories = { mode = "auto" },
					},
				},
			}

			-- Tool installation
			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, {
				"prettier",
				"stylua",
				"eslint_d",
				"angular-language-server", -- Ensure Mason installs the Angular Language Server
			})

			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
				auto_update = false,
				run_on_start = true,
			})

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{
		-- Linting
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			-- Function to check if ESLint is available in the project
			local function has_eslint()
				-- Check for local eslint in node_modules
				if vim.fn.executable(vim.fn.getcwd() .. "/node_modules/.bin/eslint") == 1 then
					return true
				end
				-- Check for global eslint
				if vim.fn.executable("eslint") == 1 then
					return true
				end
				-- Check for package.json with eslint dependency
				local package_json = vim.fn.getcwd() .. "/package.json"
				if vim.fn.filereadable(package_json) == 1 then
					local ok, content = pcall(vim.fn.readfile, package_json)
					if ok then
						local json_str = table.concat(content, "\n")
						if string.find(json_str, '"eslint"') then
							return true
						end
					end
				end
				return false
			end

			-- Only set up eslint if it's available
			if has_eslint() then
				lint.linters_by_ft = {
					typescript = { "eslint" },
					javascript = { "eslint" },
					angular = { "eslint" }, -- Added for Angular-specific linting
				}
			else
			end

			-- Create autocommand which carries out the actual linting
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					-- Only run the linter in buffers that you can modify and if linters are configured
					if vim.bo.modifiable then
						local ft = vim.bo.filetype
						if lint.linters_by_ft[ft] and #lint.linters_by_ft[ft] > 0 then
							lint.try_lint()
						end
					end
				end,
			})
		end,
	},

	{ -- Prettier.nvim for formatting
		"MunifTanjim/prettier.nvim",
		config = function()
			require("prettier").setup({
				bin = "prettier", -- or `prettierd` (if installed)
				args = { "--single-quote", "--jsx-single-quote", "--print-width", "120" }, -- customize your Prettier arguments
				filetypes = {
					"html",
					"htmlangular",
					"angular", -- Added 'angular' filetype
					"css",
					"scss",
					"javascript",
					"typescript",
					"json",
					"jsonc",
					"yaml",
					"markdown",
					"graphql",
					"lua",
				},
			})
		end,
	},

	{ -- Enhanced formatting with conform.nvim
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = { "n", "v" },
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Skip formatting for specific file types
				local disable_filetypes = { c = true, cpp = true }
				local filetype = vim.bo[bufnr].filetype

				if disable_filetypes[filetype] then
					return nil
				end

				return {
					timeout_ms = 5000,
					lsp_format = "fallback",
				}
			end,
			formatters_by_ft = {
				-- JavaScript/TypeScript
				javascript = { "eslint_d", "prettier" },
				typescript = { "eslint_d", "prettier" },
				angular = { "eslint_d", "prettier" }, -- Added 'angular' for conform

				-- Web technologies
				html = { "prettier" },
				htmlangular = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				yaml = { "prettier" },

				-- Lua
				lua = { "stylua" },
			},
			formatters = {
				prettier = {
					require_cwd = true,
				},
				eslint_d = {
					require_cwd = true,
				},
			},
		},
	},

	-- Modern completion with nvim-cmp (more stable than blink.cmp)
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Completion sources
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",

			-- Snippet engine
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				build = "make install_jsregexp",
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
			},
			"saadparwaiz1/cmp_luasnip",

			-- Icons
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			-- Load friendly snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					-- { name = 'supermaven' },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})

			-- Command line completion
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},

	{ "NMAC427/guess-indent.nvim" }, -- Detect tabstop and shiftwidth automatically

	-- Require plugins into the config
	require("plugins.oil"),
	require("plugins.telescope"),
	require("plugins.trouble"),
	require("plugins.autopairs"),
	require("plugins.gitsigns"),
	require("plugins.diffview"),
	require("plugins.harpoon"),
	require("plugins.undotree"),
	require("plugins.vim-fugitive"),
	require("plugins.codesnap"),
	require("plugins.claudecode"),
	require("plugins.mini"),
	require("plugins.avante"),
	require("plugins.copilot"),

	-- Unused plugins
	-- require 'plugins.ts-error-translator',
	-- require 'plugins.todo-comments',
	-- require 'plugins.neo-tree',
	-- require 'plugins.vim-commentary',
	-- require 'plugins.lualine',
	-- require 'plugins.rainbow-delimiters',
	-- require 'plugins.tailwindcss-colorizer-cmp',
	-- require 'plugins.transparent',
	-- require 'plugins.dressing',
	-- require 'plugins.render-markdown',
	-- require 'plugins.nvim-notify',
	-- require 'plugins.codecompanion',
	-- require 'kickstart.plugins.nvim-navic',
	-- require 'kickstart.plugins.avante',
	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.indent_line',
	-- require 'kickstart.plugins.which-key',

	-- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
	-- Or use telescope!
	-- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
	-- you can continue same window with `<space>sr` which resumes last telescope search
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
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
