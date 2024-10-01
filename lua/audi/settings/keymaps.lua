-- ========================================
-- # CONFIGURE KEYMAPS
-- ========================================

--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
-- Sets <space> as the global leader key for general mappings
vim.g.mapleader = " "
-- Sets <space> as the local leader key for buffer-local mappings
vim.g.maplocalleader = " "

-- No operation for the space key in normal and visual mode
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap split windows vertically and horizontally
vim.keymap.set("n", "<leader>|", "<C-w>v")
vim.keymap.set("n", "<leader>_", "<C-w>s")

-- Remap to go into normal mode
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "kj", "<ESC>")

-- Setting "Q" to nothing, dangerous button
vim.keymap.set("n", "Q", "<nop>")

-- Toggle between previous file and current file
vim.keymap.set("n", "<leader>.", "<c-^>")

-- Vim Fugitive
vim.keymap.set("n", "<leader>gg", ":Git<cr>")

-- Swap between last two buffers
vim.keymap.set("n", "<leader>'", "<C-^>", { desc = "Switch to last buffer", noremap = true, silent = true })

-- Press 'S' for quick find/replace for the word under the cursor
vim.keymap.set("n",
  "S", function()
    local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
    local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
  end, { noremap = true, silent = true })

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vim.keymap.set("n", "L", "$", { noremap = true, silent = true })
vim.keymap.set("n", "H", "^", { noremap = true, silent = true })

-- Turn off highlighted results
vim.keymap.set("n", "<leader>nh", "<cmd>noh<cr>", { noremap = true, silent = true })

-- Toggle undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Yank and then comment out the selected code in visual mode
vim.keymap.set('x', '<leader>y', function()
  -- Yank the selected lines
  vim.cmd('normal! "+y')

  -- Get the range of the selected lines
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Comment out the entire range
  vim.cmd(start_line .. ',' .. end_line .. 'Commentary')

  -- Move the cursor to the last line
  vim.fn.cursor(end_line, 0)
end, { noremap = true, silent = true })


-- Diagnostics
-- Open the diagnostic under the cursor in a float window
vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float({ border = "rounded", }) end,
  { noremap = true, silent = true })

-- Goto next diagnostic of any severity
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({})
  vim.api.nvim_feedkeys("zz", "n", false)
end, { noremap = true, silent = true })

-- Goto previous diagnostic of any severity
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({})
  vim.api.nvim_feedkeys("zz", "n", false)
end, { noremap = true, silent = true })

-- Goto next error diagnostic
vim.keymap.set("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  vim.api.nvim_feedkeys("zz", "n", false)
end, { noremap = true, silent = true })

-- Goto previous error diagnostic
vim.keymap.set("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  vim.api.nvim_feedkeys("zz", "n", false)
end, { noremap = true, silent = true })

-- Goto next warning diagnostic
vim.keymap.set("n", "]w", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
  vim.api.nvim_feedkeys("zz", "n", false)
end, { noremap = true, silent = true })

-- Goto previous warning diagnostic
vim.keymap.set("n", "[w", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
  vim.api.nvim_feedkeys("zz", "n", false)
end, { noremap = true, silent = true })

-- Place all dignostics into a qflist
vim.keymap.set("n", "<leader>ld", vim.diagnostic.setqflist,
  { desc = "Quickfix [L]ist [D]iagnostics", noremap = true, silent = true })

-- Navigate to next qflist item
vim.keymap.set("n", "<leader>cn", ":cnext<cr>zz", { noremap = true, silent = true })

-- Navigate to previous qflist item
vim.keymap.set("n", "<leader>cp", ":cprevious<cr>zz", { noremap = true, silent = true })

-- Open the qflist
vim.keymap.set("n", "<leader>co", ":copen<cr>zz", { noremap = true, silent = true })

-- Close the qflist
vim.keymap.set("n", "<leader>cc", ":cclose<cr>zz", { noremap = true, silent = true })

-- Map MaximizerToggle (szw/vim-maximizer) to leader-m
vim.keymap.set("n", "<leader>m", ":MaximizerToggle<cr>", { noremap = true, silent = true })

-- Resize split windows to be equal size
vim.keymap.set("n", "<leader>=", "<C-w>=", { noremap = true, silent = true })

-- Format the current buffer
vim.keymap.set("n", "<leader>f", function() require("conform").format({ async = true, lsp_fallback = true }) end,
  { desc = "Format the current buffer", noremap = true, silent = true })

-- Rotate open windows
vim.keymap.set("n", "<leader>rw", ":RotateWindows<cr>", { desc = "[R]otate [W]indows", noremap = true, silent = true })

-- Open the link under the cursor
vim.keymap.set("n", "gx", ":sil !open <cWORD><cr>", { silent = true, noremap = true })

-- TSC autocommand keybind to run TypeScripts tsc
vim.keymap.set("n", "<leader>tsc", ":TSC<cr>", { desc = "[T]ypeScript [C]ompile", noremap = true, silent = true })

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


-- Miscellaneous keymaps
-- Run tests with neotest
vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,
  { desc = "[T]est [F]ile", noremap = true, silent = true })

vim.keymap.set("n", "<leader>tn", function() require("neotest").run.run() end,
  { desc = "[T]est [N]earest", noremap = true, silent = true })

vim.keymap.set("n", "<leader>tt", function() require("neotest").run.run({ strategy = "dap" }) end,
  { desc = "[T]est with [D]ebugger", noremap = true, silent = true })

vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end,
  { desc = "[T]est [S]ummary", noremap = true, silent = true })

vim.keymap.set("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end,
  { desc = "[T]est [O]utput", noremap = true, silent = true })

vim.keymap.set("n", "<leader>tp", function() require("neotest").output_panel.toggle() end,
  { desc = "[T]est [P]anel", noremap = true, silent = true })


-- Window + better kitty navigation
vim.keymap.set("n", "<C-j>", function()
    if vim.fn.exists(":KittyNavigateDown") ~= 0 and TERM == "xterm-kitty" then
      vim.cmd.KittyNavigateDown()
    elseif vim.fn.exists(":NvimTmuxNavigateDown") ~= 0 then
      vim.cmd.NvimTmuxNavigateDown()
    else
      vim.cmd.wincmd("j")
    end
  end,
  { noremap = true, silent = true })

vim.keymap.set("n", "<C-k>", function()
    if vim.fn.exists(":KittyNavigateUp") ~= 0 and TERM == "xterm-kitty" then
      vim.cmd.KittyNavigateUp()
    elseif vim.fn.exists(":NvimTmuxNavigateUp") ~= 0 then
      vim.cmd.NvimTmuxNavigateUp()
    else
      vim.cmd.wincmd("k")
    end
  end,
  { noremap = true, silent = true })

vim.keymap.set("n", "<C-l>", function()
    if vim.fn.exists(":KittyNavigateRight") ~= 0 and TERM == "xterm-kitty" then
      vim.cmd.KittyNavigateRight()
    elseif vim.fn.exists(":NvimTmuxNavigateRight") ~= 0 then
      vim.cmd.NvimTmuxNavigateRight()
    else
      vim.cmd.wincmd("l")
    end
  end,
  { noremap = true, silent = true })

vim.keymap.set("n", "<C-h>", function()
    if vim.fn.exists(":KittyNavigateLeft") ~= 0 and TERM == "xterm-kitty" then
      vim.cmd.KittyNavigateLeft()
    elseif vim.fn.exists(":NvimTmuxNavigateLeft") ~= 0 then
      vim.cmd.NvimTmuxNavigateLeft()
    else
      vim.cmd.wincmd("h")
    end
  end,
  { noremap = true, silent = true })


-- Center buffer while navigating
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "{", "{zz", { noremap = true, silent = true })
vim.keymap.set("n", "}", "}zz", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true, silent = true })
vim.keymap.set("n", "n", "nzz", { noremap = true, silent = true })
vim.keymap.set("n", "G", "Gzz", { noremap = true, silent = true })
vim.keymap.set("n", "gg", "ggzz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-i>", "<C-i>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-o>", "<C-o>zz", { noremap = true, silent = true })
vim.keymap.set("n", "%", "%zz", { noremap = true, silent = true })
vim.keymap.set("n", "*", "*zz", { noremap = true, silent = true })
vim.keymap.set("n", "#", "#zz", { noremap = true, silent = true })

-- Keymap to show the full file path
vim.api.nvim_set_keymap('n', '<leader>fp', ':echo expand("%:p")<CR>', { noremap = true, silent = true })
