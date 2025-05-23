-- Snippets
return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node
		local f = ls.function_node

		-- Optional: load friendly-snippets collection
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Basic LuaSnip setup
		ls.config.set_config({
			history = true,
			updateevents = "TextChanged,TextChangedI",
			enable_autosnippets = true,
		})

		-- ## Console.log Snippets
		-- JavaScript console.log
		ls.add_snippets("javascript", {
			s("clg", {
				t("console.log("),
				i(1, ""),
				t(")"),
			}),
		})

		-- TypeScript console.log
		ls.add_snippets("typescript", {
			s("clg", {
				t("console.log("),
				i(1, ""),
				t(")"),
			}),
		})

		-- JSX/React console.log
		ls.add_snippets("javascriptreact", {
			s("clg", {
				t("console.log("),
				i(1, ""),
				t(")"),
			}),
		})

		-- TSX/React TypeScript console.log
		ls.add_snippets("typescriptreact", {
			s("clg", {
				t("console.log("),
				i(1, ""),
				t(")"),
			}),
		})

		-- You could add additional snippets for other languages here
		-- For example, Python print snippets
		ls.add_snippets("python", {
			s("pr", {
				t("print("),
				i(1, ""),
				t(")"),
			}),
		})

		-- ## Class Snippets
		-- Html class
		ls.add_snippets("html", {
			s("cl", {
				t('class="'),
				i(1, ""),
				t('"'),
			}),
		})

		-- HtmlAngular class
		ls.add_snippets("htmlangular", {
			s("cl", {
				t('class="'),
				i(1, ""),
				t('"'),
			}),
		})

		-- Set up keybindings for jumping between snippet placeholders
		vim.keymap.set({ "i", "s" }, "<Tab>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			else
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
			end
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			else
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
			end
		end, { silent = true })

		-- Optional: key to select within a list of choices for choice nodes
		vim.keymap.set({ "i", "s" }, "<C-l>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end)

		return ls -- Return the module if using with require
	end,
}
