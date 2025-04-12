-- return {
--   "mbbill/undotree",
--   lazy = true,          -- Lazy load for better startup performance
--   cmd = "UndotreeToggle", -- Only load when the command is used

--   config = function()
--     -- Safe setup for undotree
--     local function setup_undotree()
--       -- Customize undo tree appearance with better defaults
--       vim.g.undotree_WindowLayout = 1 -- Layout for undo tree
--       vim.g.undotree_ShortIndicators = 1 -- Short indicators for undo tree entries
--       vim.g.undotree_SetFocusWhenToggle = 1 -- Automatically focus on the undo tree window when opened
--       vim.g.undotree_DiffpanelHeight = 10 -- Set height of the diff panel
--       vim.g.undotree_HelpLine = 0 -- Disable the help line at the bottom of the undo tree
--       vim.g.undotree_SplitWidth = 40 -- Width of the undo tree window
--       vim.g.undotree_DiffAutoOpen = 1 -- Auto open diff panel
--       vim.g.undotree_TreeNodeShape = '●' -- Use a more visible node shape
--       vim.g.undotree_HighlightChangedText = 1 -- Highlight changed text in diff panel
--       vim.g.undotree_HighlightChangedWithSign = 1 -- Show signs for changed lines
--       vim.g.undotree_HighlightSyntaxAdd = "DiffAdd" -- Highlight group for additions
--       vim.g.undotree_HighlightSyntaxChange = "DiffChange" -- Highlight group for changes
--       vim.g.undotree_HighlightSyntaxDel = "DiffDelete" -- Highlight group for deletions
--     end

--     -- Set up undo persistence with error handling
--     local function setup_undo_persistence()
--       -- Enable persistent undo
--       vim.o.undofile = true

--       -- Determine appropriate undo directory path
--       local undodir

--       -- Use XDG config if available (more modern approach)
--       if vim.env.XDG_DATA_HOME then
--         undodir = vim.env.XDG_DATA_HOME .. "/nvim/undodir"
--       else
--         -- Fallback to standard location
--         undodir = vim.fn.expand("~/.local/share/nvim/undodir")
--       end

--       -- Set the undo directory
--       vim.o.undodir = undodir

--       -- Create the undo directory if it doesn't exist with error handling
--       local mkdir_ok, mkdir_err = pcall(vim.fn.mkdir, undodir, "p")
--       if not mkdir_ok then
--         vim.notify(
--           "Failed to create undo directory: " .. (mkdir_err or "unknown error") ..
--           "\nUndo persistence might not work correctly.",
--           vim.log.levels.WARN
--         )
--       end
--     end

--     -- Set up keymaps with better Neovim API
--     local function setup_keymaps()
--       vim.keymap.set("n", "<leader>u", function()
--         -- Check if undotree is already open
--         local undotree_visible = false
--         for _, win in pairs(vim.api.nvim_list_wins()) do
--           local buf = vim.api.nvim_win_get_buf(win)
--           local buf_name = vim.api.nvim_buf_get_name(buf)
--           if buf_name:match("undotree_") then
--             undotree_visible = true
--             break
--           end
--         end

--         -- Toggle undotree
--         vim.cmd("UndotreeToggle")

--         -- If opening undotree, also close other temporary windows like NvimTree
--         if not undotree_visible then
--           -- Close other potential UI elements for a cleaner view
--           -- Uncomment if needed:
--           -- pcall(vim.cmd, "NvimTreeClose")
--           -- pcall(vim.cmd, "TroubleClose")
--         end
--       end, { noremap = true, silent = true, desc = "Toggle UndoTree" })

--       -- Additional keymaps for navigating while in undotree
--       vim.api.nvim_create_autocmd("FileType", {
--         pattern = "undotree",
--         callback = function()
--           -- Add convenient keymaps for navigating undo history when in undotree window
--           vim.keymap.set("n", "J", "5j", { buffer = true, noremap = true, silent = true })
--           vim.keymap.set("n", "K", "5k", { buffer = true, noremap = true, silent = true })
--         end
--       })
--     end

--     -- Execute all setup functions
--     setup_undotree()
--     setup_undo_persistence()
--     setup_keymaps()

--     -- Create commands for quick saving of undo state with comments
--     vim.api.nvim_create_user_command("UndoSave", function()
--       -- Force a new undo state to be created
--       vim.cmd("normal! i \b")
--       vim.notify("Undo state saved", vim.log.levels.INFO)
--     end, { desc = "Save current state in undo history" })

--     -- Custom highlighting for undotree
--     vim.api.nvim_create_autocmd("ColorScheme", {
--       pattern = "*",
--       callback = function()
--         -- Custom highlights for undotree elements can be set here
--         -- vim.cmd("highlight UndotreeBranch guifg=#7FBBB3")
--         -- vim.cmd("highlight UndotreeNode guifg=#A7C080")
--       end
--     })
--   end,
-- }

return {
	"mbbill/undotree",
	lazy = true,
	cmd = "UndotreeToggle",
	keys = {
		{ "<leader>ut", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" },
	},
	config = function()
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.g.undotree_DiffpanelHeight = 10
		vim.g.undotree_SplitWidth = 40
		vim.g.undotree_HighlightSyntaxAdd = "DiffAdd"
		vim.g.undotree_HighlightSyntaxChange = "DiffChange"
		vim.g.undotree_HighlightSyntaxDel = "DiffDelete"

		-- Additional keymaps for navigating while in undotree
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "undotree",
			callback = function()
				vim.keymap.set("n", "J", "5j", { buffer = true, noremap = true, silent = true })
				vim.keymap.set("n", "K", "5k", { buffer = true, noremap = true, silent = true })
			end,
		})
	end,
}
