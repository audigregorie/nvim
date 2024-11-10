return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufEnter", -- Load plugin when a buffer is entered
  config = function(_, opts)
    -- Safely load indent-blankline to avoid runtime errors
    local ok, indent_blankline = pcall(require, "indent_blankline")
    if not ok then
      vim.notify("Indent-Blankline plugin not found!", vim.log.levels.ERROR)
      return
    end

    -- Set up the plugin with custom options
    indent_blankline.setup(vim.tbl_extend("force", {
      char = "│", -- Set the character for indents
      show_trailing_blankline_indent = false,
      show_first_indent_level = true,
      use_treesitter = true, -- Enable Treesitter integration
      show_current_context = true,
      show_current_context_start = true,
      filetype_exclude = {
        "help",
        "lazy",
        "mason",
        "notify",
        "oil",
        "jsx",
        "html"
      },
    }, opts or {})) -- Merge user-defined options with default ones
  end,
}

