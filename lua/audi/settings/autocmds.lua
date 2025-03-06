-- # Autocmds


-- ## Yank Highlighting
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200, visual = true })
  end,
  group = highlight_group,
  pattern = "*",
  desc = "Highlight selection on yank",
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

-- ## Window split
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "#000000", fg = "#222222" })

-- ## Markdown Heading Highlighting
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
