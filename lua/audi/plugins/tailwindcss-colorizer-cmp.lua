return {
  "roobert/tailwindcss-colorizer-cmp.nvim",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    -- Safely load the plugin to avoid runtime errors
    local ok, colorizer_cmp = pcall(require, "tailwindcss-colorizer-cmp")
    if not ok then
      vim.notify("Failed to load tailwindcss-colorizer-cmp", vim.log.levels.ERROR)
      return
    end

    -- Integrate tailwindcss-colorizer with nvim-cmp
    colorizer_cmp.setup({
      -- Add any specific configuration here if needed
      color_square_width = 2, -- Example option: sets the width of the color square in the completion menu
    })

    -- Attach the colorizer to nvim-cmp
    local cmp = require("cmp")
    cmp.setup({
      formatting = {
        format = colorizer_cmp.formatter,
      },
    })
  end,
}

