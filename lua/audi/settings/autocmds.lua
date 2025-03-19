-- # Autocmds
-- -@diagnostic disable: undefined-global
--  Or alternatively:
-- vim = vim

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

-- ## NvimTree Highlighting
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#FF8800" }) -- Folder icons
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#7bace0", bg = "#111112" })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFile", { fg = "#7bace0" }) -- Files that are open in a buffer
-- vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#4682B4" })       -- Default/closed folders

-- ## Navic Highlighting
-- Set background color for the winbar
vim.api.nvim_set_hl(0, "WinBar", { bg = "#111112" })

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
