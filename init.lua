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
vim.opt.updatetime = 250   -- Faster completion (4000ms default)
vim.opt.timeoutlen = 300   -- Time to wait for mapped sequence (ms)
vim.opt.history = 500      -- Number of commands to remember
vim.opt.hidden = true      -- Allow buffers to be hidden without saving

-- File Handling
vim.opt.confirm = true                                 -- If operation will fail, ask if you wish to save
vim.opt.backup = false                                 -- Don't create backup files
vim.opt.writebackup = false                            -- Don't backup before overwriting
vim.opt.swapfile = false                               -- Don't create swap files
vim.opt.undofile = true                                -- Enable persistent undo
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir" -- Where to save undo history

-- Visual UI Elements
vim.opt.number = true             -- Show line numbers
vim.opt.relativenumber = true     -- Show relative line numbers
vim.opt.numberwidth = 3           -- Width of number column
vim.opt.statuscolumn = "%s %l   " -- Control the left gutter — numbers, signs, spacing, etc
vim.opt.signcolumn = "yes"        -- Always show sign column
vim.opt.cursorline = true         -- Highlight current line
vim.opt.cursorlineopt = "number"  -- Highlight only line number
vim.opt.showmode = false          -- Hide mode indicator (INSERT/NORMAL)
vim.opt.showtabline = 0           -- Never show tabs
vim.opt.title = true              -- Show filename in window title
vim.opt.fillchars = { eob = "~" } -- Character for end-of-buffer lines
vim.opt.termguicolors = true      -- True color support
vim.opt.cmdheight = 1             -- Command line height
vim.opt.pumheight = 10            -- Popup menu height
vim.opt.background = "dark"       -- Use dark background

-- Status Line
vim.opt.laststatus = 3 -- Global status line (Neovim 0.7+)

-- Search and Completion
vim.opt.hlsearch = true                         -- Highlight search matches
vim.opt.ignorecase = true                       -- Ignore case in search
vim.opt.smartcase = true                        -- Override ignorecase when search includes uppercase
vim.opt.completeopt = { "menuone", "noselect" } -- Completion options
vim.opt.shortmess:append("c")                   -- Don't show completion messages

-- Indentation and Whitespace
vim.opt.tabstop = 2        -- Width of tab character
vim.opt.softtabstop = 2    -- Width of soft tab
vim.opt.shiftwidth = 2     -- Width of indent
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true  -- Copy indent from current line when starting new line

-- Text Display
vim.opt.wrap = true                             -- Wrap long lines
vim.opt.linebreak = true                        -- Wrap at word boundaries
vim.opt.lbr = true                              -- Alias for linebreak
vim.opt.breakindent = true                      -- Preserve indentation in wrapped lines
vim.opt.conceallevel = 0                        -- Don't hide markup (e.g., in markdown)
vim.opt.iskeyword:append("-")                   -- Treat hyphenated words as one word
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- Don't auto-insert comments

-- Window Behavior
vim.opt.splitbelow = true    -- New horizontal splits go below
vim.opt.splitright = true    -- New vertical splits go right
vim.opt.diffopt = "vertical" -- Vertical diff
vim.opt.scrolloff = 8        -- Min lines to keep above/below cursor
vim.opt.sidescrolloff = 10   -- Min columns to keep left/right of cursor

-- Input
vim.opt.mouse = "a"                              -- Enable mouse in all modes
vim.opt.backspace = { "indent", "eol", "start" } -- Backspace behavior
vim.opt.guicursor = "a:block"                    -- Use block cursor in all modes
vim.o.clipboard = "unnamedplus"                  -- Use system clipboard
vim.opt.shell = "zsh"                            -- Shell to use for external commands

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
vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#00af00", bg = "NONE" })    -- Bright but readable green
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#d70000", bg = "NONE" }) -- Readable red
vim.api.nvim_set_hl(0, "DiffChange", { fg = "#5f5fff", bg = "NONE" }) -- Blue for changed lines
vim.api.nvim_set_hl(0, "DiffText", { fg = "#d75f00", bg = "NONE" })   -- Orange for changed text within lines

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

  -- Null-ls for formatting and diagnostics
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls-extras.nvim", -- Needed for eslint_d
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")
      local formatting = require("none-ls.formatting.eslint_d")
      local diagnostics = require("none-ls.diagnostics.eslint_d")

      null_ls.setup({
        sources = {
          -- Only register eslint_d diagnostics if .eslintrc* is present
          diagnostics.with({
            condition = function(utils)
              return utils.root_has_file({
                ".eslintrc",
                ".eslintrc.js",
                ".eslintrc.cjs",
                ".eslintrc.json",
                ".eslintrc.yaml",
                ".eslintrc.yml",
              })
            end,
            filetypes = { "javascript", "typescript", },
          }),

          -- Only register eslint_d formatting if .eslintrc* is present
          formatting.with({
            condition = function(utils)
              return utils.root_has_file({
                ".eslintrc",
                ".eslintrc.js",
                ".eslintrc.cjs",
                ".eslintrc.json",
                ".eslintrc.yaml",
                ".eslintrc.yml",
              })
            end,
            filetypes = { "javascript", "typescript", },
          }),

          -- Prettier (conditionally enabled by presence of Prettier config)
          null_ls.builtins.formatting.prettierd.with({
            condition = function(utils)
              return utils.root_has_file({
                ".prettierrc",
                ".prettierrc.js",
                ".prettierrc.json",
                ".prettierrc.yaml",
                ".prettierrc.yml",
                "prettier.config.js",
                "prettier.config.cjs",
              })
            end,
          }),
        },

        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, async = false })
              end,
            })
          end
        end,
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "b0o/schemastore.nvim", lazy = true },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Enable inline diagnostics
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 2,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      local lspconfig = require("lspconfig")

      -- Common on_attach function for format-on-save
      local function common_on_attach(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
        -- LSP Keymaps
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local keymap = vim.keymap.set
        keymap("n", "gd", require("telescope.builtin").lsp_definitions,
          vim.tbl_extend("force", opts, { desc = "[G]oto [D]efinition" }))
        keymap("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "[G]oto [D]eclaration" }))
        keymap("n", "gr", require("telescope.builtin").lsp_references,
          vim.tbl_extend("force", opts, { desc = "[G]oto [R]eferences" }))
        keymap("n", "gi", require("telescope.builtin").lsp_implementations,
          vim.tbl_extend("force", opts, { desc = "[G]oto [I]mplementation" }))
        keymap("n", "gt", require("telescope.builtin").lsp_type_definitions,
          vim.tbl_extend("force", opts, { desc = "[G]oto [T]ype Definition" }))
        keymap("n", "ds", require("telescope.builtin").lsp_document_symbols,
          vim.tbl_extend("force", opts, { desc = "[D]ocument [S]ymbols" }))
        keymap("n", "ws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
          vim.tbl_extend("force", opts, { desc = "[W]orkspace [S]ymbols" }))
        keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
        keymap("i", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature Help" }))
        keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "[R]e[n]ame" }))
        keymap({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action,
          vim.tbl_extend("force", opts, { desc = "[C]ode [A]ction" }))
        keymap("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, vim.tbl_extend("force", opts, { desc = "Format Buffer" }))
        keymap("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show Diagnostics" }))
        keymap("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end,
          vim.tbl_extend("force", opts, { desc = "Previous Diagnostic" }))
        keymap("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end,
          vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))
      end


      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      -- Angular Language Server
      lspconfig.angularls.setup({
        on_attach = common_on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("angular.json", "tsconfig.json", ".git"),
      })

      -- TypeScript Server
      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
          common_on_attach(client, bufnr)

          -- Enable inlay hints if supported
          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      -- CSS Language Server
      lspconfig.cssls.setup({
        on_attach = common_on_attach,
        capabilities = capabilities,
      })

      -- JSON Language Server
      lspconfig.jsonls.setup({
        on_attach = common_on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(), -- optional
            validate = { enable = true },
          },
        },
      })

      -- Tailwind CSS Language Server
      lspconfig.tailwindcss.setup({
        on_attach = common_on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern(
          "tailwind.config.js",
          "tailwind.config.ts",
          "postcss.config.js",
          "package.json",
          ".git"
        ),
      })

      -- Lua Language Server
      lspconfig.lua_ls.setup({
        on_attach = common_on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      })
    end,
  },

  -- Fidget (LSP Progress UI)
  {
    "j-hui/fidget.nvim",
    tag = "legacy", -- Optional: remove if you're using the latest version
    event = "LspAttach",
    config = function()
      require("fidget").setup({})
    end,
  },

  -- Lspsaga (LSP UI Enhancements)
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        lightbulb = {
          enable = true,
          enable_in_insert = false,
          sign = true,
          virtual_text = false,
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional but improves UI
      "nvim-tree/nvim-web-devicons",     -- optional for icons
    },
  },

  -- lspkind (VSCode-like pictograms)
  {
    "onsails/lspkind.nvim",
    lazy = true,
  },

  -- mason.nvim (LSP/DAP/Tool installer)
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },

  -- mason-lspconfig (bridge between mason and lspconfig)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "angularls",
          "cssls",
          "jsonls",
          "tailwindcss",
          "lua_ls",
          "eslint",
        },
        automatic_installation = true,
        automatic_enable = true
      })
    end,
  },

  -- nvim-cmp (main completion engine)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

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
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

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

  -- LuaSnip (Snippet engine)
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp", -- optional if using regex-based snippets
    event = "InsertEnter",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip").config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })
    end,
  },

  -- Detect tabstop and shiftwidth automatically
  {
    "NMAC427/guess-indent.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },


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
  require 'plugins.lualine',

  -- Unused plugins
  -- require 'plugins.supermaven',
  -- require 'plugins.ts-error-translator',
  -- require 'plugins.todo-comments',
  -- require 'plugins.neo-tree',
  -- require 'plugins.vim-commentary',
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
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
