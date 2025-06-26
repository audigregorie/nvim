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
