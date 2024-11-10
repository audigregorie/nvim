return {
  "NvChad/nvim-colorizer.lua",
  opts = {
    user_default_options = {
      mode = "virtualtext", -- Display color codes as virtual text
      filetypes = {
        "!jsx",             -- Exclude JSX files from being colorized
        "!html",            -- Exclude HTML files from being colorized
      },
      -- tailwind = true, -- Enable tailwind-specific color processing
    },
  },
  config = function(_, opts)
    -- Safely load the colorizer plugin to avoid runtime errors
    local ok, colorizer = pcall(require, "colorizer")
    if not ok then
      vim.notify("nvim-colorizer.lua plugin not found!", vim.log.levels.ERROR)
      return
    end

    -- Apply the setup for colorizer with provided options
    colorizer.setup(opts.user_default_options)
  end,
}
