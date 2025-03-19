-- Status line (minimal)
return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- Optional dependency for icons
	},
	config = function()
		-- Check if lualine is available
		local lualine_ok, lualine = pcall(require, "lualine")
		if not lualine_ok then
			vim.notify("Failed to load lualine: " .. tostring(lualine), vim.log.levels.ERROR)
			return
		end

		-- Define colors with error handling
		local colors_ok, colors = pcall(function()
			return {
				bg = "#111112",
				fg = "#bbc2cf",
				yellow = "#ECBE7B",
				cyan = "#008080",
				darkblue = "#081633",
				green = "#98be65",
				orange = "#FF8800",
				violet = "#a9a1e1",
				magenta = "#c678dd",
				blue = "#51afef",
				red = "#ec5f67",
				comment = "#AAAAAA",
			}
		end)

		if not colors_ok then
			vim.notify("Failed to define lualine colors: " .. tostring(colors), vim.log.levels.WARN)
			-- Fallback to basic colors if custom colors fail
			colors = {
				bg = "#000000",
				fg = "#ffffff",
				yellow = "#ffff00",
				cyan = "#00ffff",
				green = "#00ff00",
				orange = "#ff8800",
				violet = "#ff00ff",
				magenta = "#ff00ff",
				blue = "#0000ff",
				red = "#ff0000",
				comment = "#888888",
			}
		end

		-- Define conditions with error handling
		local conditions_ok, conditions = pcall(function()
			return {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}
		end)

		if not conditions_ok then
			vim.notify("Failed to define lualine conditions: " .. tostring(conditions), vim.log.levels.WARN)
			-- Fallback to basic conditions
			conditions = {
				buffer_not_empty = function()
					return true
				end,
				hide_in_width = function()
					return true
				end,
				check_git_workspace = function()
					return true
				end,
			}
		end

		-- Function to get a custom message with error handling
		local getShitDone_ok, getShitDone = pcall(function()
			return function()
				return "Get Shit Done"
			end
		end)

		if not getShitDone_ok then
			vim.notify("Failed to define custom message function: " .. tostring(getShitDone), vim.log.levels.WARN)
			getShitDone = function()
				return "Focus"
			end
		end

		-- Setup lualine with error handling
		local setup_ok, setup_err = pcall(function()
			lualine.setup({
				options = {
					icons_enabled = true,
					theme = {
						normal = {
							a = { fg = colors.fg, bg = colors.bg },
							b = { fg = colors.comment, bg = colors.bg },
							c = { fg = colors.fg, bg = colors.bg },
						},
						inactive = {
							a = { fg = colors.fg, bg = colors.bg },
							b = { fg = colors.fg, bg = colors.bg },
							c = { fg = colors.fg, bg = colors.bg },
						},
					},
					component_separators = "",
					section_separators = "",
				},
				sections = {
					lualine_a = {
						{
							"mode",
							color = function()
								-- auto change color according to neovims mode
								local mode_color = {
									n = colors.orange,
									i = colors.green,
									v = colors.violet,
									V = colors.violet,
									c = colors.magenta,
									no = colors.red,
									s = colors.orange,
									S = colors.orange,
									[""] = colors.orange,
									ic = colors.yellow,
									R = colors.red,
									Rv = colors.red,
									cv = colors.red,
									ce = colors.red,
									r = colors.cyan,
									rm = colors.cyan,
									["r?"] = colors.cyan,
									["!"] = colors.red,
									t = colors.red,
								}
								return {
									fg = mode_color[vim.fn.mode()] or colors.fg,
								}
							end,
						},
					},
					lualine_b = {
						{
							"branch",
							icon = "",
							color = { fg = colors.blue },
						},
						{
							"diff",
							symbols = { added = "󰝤 ", modified = "󰝤 ", removed = "󰝤 " },
							diff_color = {
								added = { fg = colors.green },
								modified = { fg = colors.orange },
								removed = { fg = colors.red },
							},
							cond = conditions.hide_in_width,
						},
					},
					lualine_c = {
						{
							"filename",
							path = 1,
							file_status = true,
							cond = conditions.buffer_not_empty,
						},
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " " },
							diagnostics_color = {
								error = { fg = colors.red },
								warn = { fg = colors.yellow },
								info = { fg = colors.cyan },
							},
						},
					},
					lualine_x = {},
					lualine_y = { getShitDone },
					lualine_z = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						{
							"filename",
							path = 1,
							file_status = true,
							cond = conditions.buffer_not_empty,
						},
					},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = {},
			})
		end)

		if not setup_ok then
			vim.notify("Failed to setup lualine: " .. tostring(setup_err), vim.log.levels.ERROR)
		end
	end,
}
