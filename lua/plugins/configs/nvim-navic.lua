-- VSCode-like breadcrumbs
return {
	"SmiteshP/nvim-navic",
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		local vim = vim

		-- Set background color for the winbar
		vim.api.nvim_set_hl(0, "WinBar", { bg = "#111112" })
		-- vim.api.nvim_set_hl(0, "WinBar", { bg = "#0d1014" })

		local navic = require("nvim-navic")
		navic.setup({
			icons = {
				File = "󰈙 ",
				Module = " ",
				Namespace = "󰌗 ",
				Package = " ",
				Class = "󰌗 ",
				Method = "󰆧 ",
				Property = " ",
				Field = " ",
				Constructor = " ",
				Enum = "󰕘",
				Interface = "󰕘",
				Function = "󰊕 ",
				Variable = "󰆧 ",
				Constant = "󰏿 ",
				String = "󰀬 ",
				Number = "󰎠 ",
				Boolean = "◩ ",
				Array = "󰅪 ",
				Object = "󰅩 ",
				Key = "󰌋 ",
				Null = "󰟢 ",
				EnumMember = " ",
				Struct = "󰌗 ",
				Event = " ",
				Operator = "󰆕 ",
				TypeParameter = "󰊄 ",
			},
			highlight = true,
			separator = " > ",
			depth_limit = 0,
			depth_limit_indicator = "..",
			safe_output = true,
		})

		-- Create a winbar with breadcrumbs
		vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

		-- Create a reusable on_attach function for LSP that includes navic attachment
		local on_attach = function(client, bufnr)
			if client.server_capabilities.documentSymbolProvider then
				navic.attach(client, bufnr)
			end
		end

		-- Attach to TypeScript/JavaScript server
		local lspconfig = require("lspconfig")

		-- TypeScript server
		lspconfig.ts_ls.setup({
			on_attach = on_attach,
			-- Add any other TypeScript-specific settings here
		})

		-- Angular Language Service
		lspconfig.angularls.setup({
			on_attach = on_attach,
			-- Add any other Angular-specific settings here
		})

		-- HTML Language Server
		lspconfig.html.setup({
			on_attach = on_attach,
			-- Add any other CSS-specific settings here
		})

		-- CSS Language Server
		lspconfig.cssls.setup({
			on_attach = on_attach,
			-- Add any other HTML-specific settings here
		})

		-- Lua Language Server
		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			-- Add any other Lua-specific settings here
		})

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
	end,
}
