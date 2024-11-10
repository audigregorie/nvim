-- ========================================
-- # CONFIGURE OPTIONS
-- ========================================
-- See :help options
vim.opt.autoindent = true                        -- Enable auto-indentation.
vim.opt.background = "dark"                      -- Set the background option to "dark" to indicate a dark color scheme.
vim.opt.backspace = { "indent", "eol", "start" } -- allows <backspace> to function as we expect
vim.opt.backup = false                           -- creates a backup file
vim.opt.breakindent = true                       -- " Indents word-wrapped lines as much as the 'parent' line
vim.opt.clipboard = "unnamedplus"                -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                            -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" }  -- mostly just for cmp
vim.opt.conceallevel = 0                         -- 0 is so that `` is visible in markdown files
vim.opt.cursorline = true                        -- highlight the current line
vim.opt.cursorlineopt =
"number"                                         -- Set cursorlineopt to "number" to enable line numbering for the cursor line.
vim.opt.diffopt = 'vertical'
vim.opt.expandtab = true                         -- convert tabs to spaces
vim.opt.formatoptions:remove({ "c", "r", "o" })  -- don't insert the current comment leader automatically for...
vim.opt.guicursor = ""                           -- guicursor as a block instead of a line
vim.opt.hlsearch = true                          -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                        -- ignore case in search patterns
vim.opt.iskeyword:append("-")                    -- hyphenated words recognized by searches
vim.opt.laststatus = 2                           -- Set laststatus to always show statusline.
-- vim.opt.laststatus = 3    -- Set laststatus to always show statusline for Avante.nvim
vim.opt.lbr = true                               -- Enable line break, which wraps long lines at the last space before the width of the window.
vim.opt.linebreak = true                         -- companion to wrap, don't split words
vim.opt.mouse = "a"                              -- allow the mouse to be used in neovim
vim.opt.number = true                            -- set numbered lines
vim.opt.numberwidth = 3                          -- set number column width to 2 {default 4 }
vim.opt.pumheight = 10                           -- pop up menu height
vim.opt.relativenumber = true                    -- set relative numbered lines
vim.opt.scrolloff = 8                            -- minimal number of screen lines to keep above and below the cursor
vim.opt.shell = "zsh"                            -- Set shell to use zsh.
vim.opt.shiftwidth = 2                           -- the number of spaces inserted for each indentation
vim.opt.shortmess:append("c")                    -- don't give |ins-completion-menu| messages
vim.opt.showmode = false                         -- hide -- NORMAL --  -- INSERT --, mode
vim.opt.showtabline = 0                          -- always show tabs
vim.opt.sidescrolloff = 10                       -- minimal number of screen columns either side of cursor if wrap is `false`
vim.opt.signcolumn =
"yes"                                            -- always show the sign column, otherwise it would shift the text each time
vim.opt.smartcase = true                         -- smart case
vim.opt.smartindent = true                       -- make indenting smarter again
vim.opt.softtabstop = 2                          -- the number of spaces inserted for each indentation
vim.opt.splitbelow = true                        -- force all horizontal splits to go below current window
vim.opt.splitright = true                        -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                         -- creates a swapfile
vim.opt.tabstop = 2                              -- insert 2 spaces for a tab
vim.opt.termguicolors = true                     -- set termguicolors to enable highlight groups
vim.opt.timeoutlen = 300                         -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true                             -- Enable window title manipulation.
vim.opt.undofile = true                          -- enable persistent undo
vim.opt.updatetime = 300                         -- faster completion (4000ms default)
vim.opt.whichwrap = "bs<>[]hl"                   -- which "horizontal" keys are allowed to travel to prev/next line
vim.opt.wrap = true                              -- display lines as one long line
vim.opt.writebackup = false                      -- if a file is being edited or was written to file with another program, it is not allowed to be edited

-- Unused configurations
-- vim.opt.foldmethod = "manual"                    -- Set fold method to 'manual' to manually define folds.
-- vim.opt.fileencoding = "UTF-8"                   -- the encoding written to a file
-- vim.opt.fillchars = "eob: "                      -- Remove "~" from empty lines
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Set fold expression to use nvim-treesitter for folding.
-- vim.opt.formatoptions = 1                       -- " Ensures word-wrap does not split words
-- vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
