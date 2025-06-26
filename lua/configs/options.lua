-- [[ Options ]]
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
