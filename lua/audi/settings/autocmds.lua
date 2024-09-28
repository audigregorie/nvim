-- ========================================
-- # CONFIGURE AUGROUPS
-- ========================================
-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

---- Autocmd to highlight yanked text
--vim.api.nvim_create_autocmd("TextYankPost", {
--  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
--  pattern = "*",
--  desc = "Highlight selection on yank",
--  callback = function()
--    vim.highlight.on_yank({ timeout = 200, visual = true })
--  end,
-- })

-- Autocommand to set relative numbers in all windows
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  pattern = "*",
  callback = function()
    vim.wo.relativenumber = true
  end,
})

-- Optionally, you can also ensure that relative numbers are turned off in specific windows
-- like for quickfix or terminal windows if needed. For example:
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "terminal" },
  callback = function()
    vim.wo.relativenumber = false
  end,
})

-- Removes the automatic comment continuation when creating a new line
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "setlocal formatoptions-=cro",
})



---- ========================================
---- # CONFIGURE UTIL
---- ========================================
---- Git directory working tree util
--local is_git_directory = function()
--  local result = vim.fn.system("git rev-parse --is-inside-work-tree")
--  if vim.v.shell_error == 0 and result:find("true") then
--    return true
--  else
--    return false
--  end
--end


-- ========================================
-- # CONFIGURE VIM APIs
-- ========================================
-- Comment highlight
vim.api.nvim_set_hl(0, "Comment", { fg = "#555555" })
vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })

-- NvimTree background highlight
-- vim.cmd("highlight NvimTreeNormal guibg=#0F0F0F ctermbg=NONE")
-- vim.cmd("highlight NvimTreeNormal guibg=#121212 ctermbg=NONE")
-- vim.cmd("highlight NvimTreeNormal guibg=#0A0F14 ctermbg=NONE")
-- vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#0A0F14" })

-- -- Nvim background highlighting
-- vim.cmd("highlight Normal guibg=#151921 ctermbg=NONE")
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0A0F14" })

-- -- SignColumn highlighting
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "#151921" })

-- -- Line Number highlight
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#555555", bg = "#151921" })

-- NvimTree Opened Folder Name highlight
-- vim.cmd("highlight NvimTreeOpenedFolderName guibg=NONE")

-- vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#3D94FF" })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#008080" })


-- Git fugitive diff colors
vim.cmd([[
      highlight diffAdded ctermfg=green guifg=#00ff00
      highlight diffRemoved ctermfg=red guifg=#ff0000
]])
