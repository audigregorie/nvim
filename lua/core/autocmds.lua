-- # Autocmds
local vim = vim

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

-- ## Disable SCSS Linter
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "scss",
-- 	callback = function()
-- 		-- Disable specific linters or set LSP settings
-- 		vim.lsp.diagnostic.disable()
-- 		-- Or use a custom setup for SCSS here
-- 	end,
-- })

-- ## Window split
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "#000000", fg = "#222222" })

-- ## NvimTree Highlighting
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#FF8800" }) -- Folder icons
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#7bace0", bg = "#111112" })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFile", { fg = "#7bace0" }) -- Files that are open in a buffer
-- vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#4682B4" })       -- Default/closed folders

-- ## Git diff
-- Clear backgrounds and set readable foreground colors for diff highlighting
vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#00af00", bg = "NONE" }) -- Bright but readable green
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#d70000", bg = "NONE" }) -- Readable red
vim.api.nvim_set_hl(0, "DiffChange", { fg = "#5f5fff", bg = "NONE" }) -- Blue for changed lines
vim.api.nvim_set_hl(0, "DiffText", { fg = "#d75f00", bg = "NONE" }) -- Orange for changed text within lines

-- ## Navic Highlighting
-- Set background color for the winbar
vim.api.nvim_set_hl(0, "WinBar", { bg = "#000000" })
-- vim.api.nvim_set_hl(0, "WinBar", { bg = "#111112" })
-- vim.api.nvim_set_hl(0, "WinBar", { bg = "#0d1014" })

-- Define highlight groups for navic
vim.api.nvim_set_hl(0, "NavicIconsFile", { fg = "#ECBE7B" })
vim.api.nvim_set_hl(0, "NavicIconsModule", { fg = "#98be65" })
vim.api.nvim_set_hl(0, "NavicIconsNamespace", { fg = "#51afef" })
vim.api.nvim_set_hl(0, "NavicIconsPackage", { fg = "#ECBE7B" })
vim.api.nvim_set_hl(0, "NavicIconsClass", { fg = "#ECBE7B" })
vim.api.nvim_set_hl(0, "NavicIconsMethod", { fg = "#a9a1e1" })
vim.api.nvim_set_hl(0, "NavicIconsProperty", { fg = "#51afef" })
vim.api.nvim_set_hl(0, "NavicIconsField", { fg = "#51afef" })
vim.api.nvim_set_hl(0, "NavicIconsConstructor", { fg = "#ECBE7B" })
vim.api.nvim_set_hl(0, "NavicIconsEnum", { fg = "#ECBE7B" })
vim.api.nvim_set_hl(0, "NavicIconsInterface", { fg = "#ECBE7B" })
vim.api.nvim_set_hl(0, "NavicIconsFunction", { fg = "#a9a1e1" })
vim.api.nvim_set_hl(0, "NavicIconsVariable", { fg = "#c678dd" })
vim.api.nvim_set_hl(0, "NavicIconsConstant", { fg = "#c678dd" })
vim.api.nvim_set_hl(0, "NavicIconsString", { fg = "#98be65" })
vim.api.nvim_set_hl(0, "NavicIconsNumber", { fg = "#ff6c6b" })
vim.api.nvim_set_hl(0, "NavicIconsBoolean", { fg = "#ff6c6b" })
vim.api.nvim_set_hl(0, "NavicIconsArray", { fg = "#ECBE7B" })
vim.api.nvim_set_hl(0, "NavicIconsObject", { fg = "#ECBE7B" })
vim.api.nvim_set_hl(0, "NavicIconsKey", { fg = "#51afef" })
vim.api.nvim_set_hl(0, "NavicIconsNull", { fg = "#ff6c6b" })
vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { fg = "#51afef" })
vim.api.nvim_set_hl(0, "NavicIconsStruct", { fg = "#ECBE7B" })
vim.api.nvim_set_hl(0, "NavicIconsEvent", { fg = "#ECBE7B" })
vim.api.nvim_set_hl(0, "NavicIconsOperator", { fg = "#51afef" })
vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { fg = "#51afef" })
vim.api.nvim_set_hl(0, "NavicText", { fg = "#bbc2cf" })
vim.api.nvim_set_hl(0, "NavicSeparator", { fg = "#5B6268" })

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
