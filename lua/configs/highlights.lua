-- [[ Highlights ]]
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
