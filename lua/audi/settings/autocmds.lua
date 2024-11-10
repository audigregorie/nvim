-- ========================================
-- # CONFIGURE AUGROUPS
-- ========================================

-- # Yank Highlighting
-- ========================================
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200, visual = true })
  end,
  group = highlight_group,
  pattern = "*",
  desc = "Highlight selection on yank",
})


-- # Relative Number Settings
-- ========================================
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


-- # Formatting Options
-- ========================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "setlocal formatoptions-=cro",
  desc = "Disable comment continuation on new lines",
})


-- #  Markdown Code Highlighting
-- ========================================
vim.api.nvim_create_autocmd({ "FileType", "ColorScheme" }, {
  pattern = { "markdown" },
  callback = function()
    vim.api.nvim_set_hl(0, "markdownCode", { bg = "#2A3542" })
    vim.api.nvim_set_hl(0, "markdownCodeBlock", { bg = "#2A3542" })
  end,
})


-- # Highlighting
-- ========================================
-- Comment colors
vim.api.nvim_set_hl(0, "Comment", { fg = "#555555" })
vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })

-- Normal colors
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0A0F14" })

-- NvimTree colors
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#008080" })


-- # Markdown Heading Highlighting
-- ========================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.cmd([[
      highlight MarkdownH1 guifg=#FF5733 gui=bold
      highlight MarkdownH2 guifg=#3357FF gui=bold
      highlight MarkdownH3 guifg=#33FF57 gui=bold
      highlight MarkdownH4 guifg=#FF33A1 gui=bold
      highlight MarkdownH5 guifg=#33FFF7 gui=bold
      highlight MarkdownH6 guifg=#F7FF33 gui=bold

      syntax match MarkdownH1 /^# .*/ containedin=ALL
      syntax match MarkdownH2 /^## .*/ containedin=ALL
      syntax match MarkdownH3 /^### .*/ containedin=ALL
      syntax match MarkdownH4 /^#### .*/ containedin=ALL
      syntax match MarkdownH5 /^##### .*/ containedin=ALL
      syntax match MarkdownH6 /^###### .*/ containedin=ALL

      highlight link markdownH1 MarkdownH1
      highlight link markdownH2 MarkdownH2
      highlight link markdownH3 MarkdownH3
      highlight link markdownH4 MarkdownH4
      highlight link markdownH5 MarkdownH5
      highlight link markdownH6 MarkdownH6
    ]])
  end,
})






-- Unused configurations
-- ========================================
-- Set code block color in markdown
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     vim.api.nvim_set_hl(0, "MarkdownCodeBlock", { bg = "#FFFFFF" })
--     vim.api.nvim_set_hl(0, "MarkdownCode", { bg = "#FFFFFF" })
--   end,
-- })


-- Git fugitive diff colors
-- vim.api.nvim_set_hl(0, "DiffAdded", { bg = "green", })
-- vim.api.nvim_set_hl(0, "DiffRemoved", { bg = "red", })
-- vim.api.nvim_set_hl(0, "DiffChange", { bg = "lightblue", })
-- vim.api.nvim_set_hl(0, "DiffText", { bg = "yellow", })


---- Autocmd to highlight yanked text
--vim.api.nvim_create_autocmd("TextYankPost", {
--  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
--  pattern = "*",
--  desc = "Highlight selection on yank",
--  callback = function()
--    vim.highlight.on_yank({ timeout = 200, visual = true })
--  end,
-- })


---- Git directory working tree util
-- local is_git_directory = function()
--  local result = vim.fn.system("git rev-parse --is-inside-work-tree")
--  if vim.v.shell_error == 0 and result:find("true") then
--    return true
--  else
--    return false
--  end
-- end


-- NvimTree background highlight
-- vim.cmd("highlight NvimTreeNormal guibg=#0F0F0F ctermbg=NONE")
-- vim.cmd("highlight NvimTreeNormal guibg=#121212 ctermbg=NONE")
-- vim.cmd("highlight NvimTreeNormal guibg=#0A0F14 ctermbg=NONE")
-- vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#0A0F14" })

-- -- Nvim background highlighting
-- vim.cmd("highlight Normal guibg=#151921 ctermbg=NONE")

-- -- SignColumn highlighting
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "#151921" })

-- -- Line Number highlight
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#555555", bg = "#151921" })

-- -- NvimTree highlight
-- vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#3D94FF" })
