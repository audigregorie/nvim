return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  cmd = "Telescope",
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local fb_actions = require("telescope").extensions.file_browser.actions
    local sorters = require("telescope.sorters")

    -- local function get_git_root()
    -- 	local stdout = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")
    -- 	if #stdout > 0 and vim.fn.isdirectory(stdout[1]) == 1 then
    -- 		return stdout[1]
    -- 	end
    -- 	return vim.fn.cwd() -- Fallback to current working directory
    -- end

    telescope.setup({
      -- Your Telescope options here
      defaults = {
        initial_mode = "insert",
        path_display = { "smart" },
        file_sorter = sorters.get_fuzzy_file,
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
          },
          vertical = {
            prompt_position = "top",
          },
        },
        file_ignore_patterns = {
          "^.git/",
          "^node_modules/",
          "^dist/",
          "package-lock.json",
        },
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<C-x>"] = actions.delete_buffer,
            ["<C-p>"] = function()
              vim.cmd("wincmd l")
            end, -- Focus preview window
          },
          n = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
      pickers = {
        find_files = {
          sort_mru = true,
          find_command = {
            "fd",
            "--type",
            "f",
            "--hidden",
            "--exclude",
            "node_modules",
            "--strip-cwd-prefix",
          },
          sorter = sorters.get_fuzzy_file(),
          file_sorter = function(a, b)
            local a_ext = a:match("%.([^.]+)$") or ""
            local b_ext = b:match("%.([^.]+)$") or ""

            -- Prioritize TypeScript files over HTML files
            local priority = { ts = 1, tsx = 1, html = 2, scss = 3 }

            return (priority[a_ext] or 99) < (priority[b_ext] or 99)
          end,
        },
        buffer = { sort_mru = true },
        grep_string = { word_match = "-w" },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        file_browser = {
          -- Extension-specific options (if any)
          hidden = true,
          mappings = {
            ["i"] = {
              ["<C-h>"] = fb_actions.goto_parent_dir,
            },
          },
        },
      },
    })
    -- Load the extension
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")

    -- Keymap to open file browser in the folder of the current file
    vim.keymap.set("n", "<leader>fb", function()
      telescope.extensions.file_browser.file_browser({
        path = vim.fn.expand("%:p:h"),
        select_buffer = true,
      })
    end, { desc = "File Browser (current file dir)" })

    vim.keymap.set("n", "<leader>ff", function()
      require("telescope.builtin").find_files({
        -- cwd = get_git_root(), -- Use the helper function defined above
      })
    end, { desc = "Find Files (Git Project Root)" })
  end,
}
