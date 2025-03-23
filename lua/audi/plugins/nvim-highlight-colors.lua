-- nvim-colorizer.lua setup (for in-buffer colorization)
-- return {
--   "NvChad/nvim-colorizer.lua",
--   event = { "BufReadPost", "BufNewFile" }, -- Lazy load on buffer read/new
--   config = function()
--     -- Safe requiring with error handling
--     local status_ok, colorizer = pcall(require, "colorizer")
--     if not status_ok then
--       vim.notify("Failed to load nvim-colorizer.lua plugin", vim.log.levels.ERROR)
--       return
--     end

--     -- Wrap setup in pcall for error handling
--     local setup_ok, error_msg = pcall(function()
--       -- Fix: Ensure proper configuration structure
--       colorizer.setup({
--         -- Default options for all filetypes
--         "*", -- Enable for all filetypes

--         -- File type specific options can be set like this:
--         -- css = { rgb_fn = true, hsl_fn = true },
--         -- scss = { rgb_fn = true, hsl_fn = true },
--       }, {
--         -- Default options for all filetypes (this is the correct format)
--         tailwind = true,      -- Enable tailwind colors
--         css = true,           -- Enable CSS color features
--         mode = "foreground",  -- Use background highlighting for better visibility
--         rgb_fn = true,        -- Enable rgb/rgba() functions
--         hsl_fn = true,        -- Enable hsl/hsla() functions
--         names = false,        -- Disable named colors for performance
--         always_update = true, -- Update colors in real-time
--       })
--     end)

--     if not setup_ok then
--       vim.notify("Error setting up nvim-colorizer: " .. tostring(error_msg), vim.log.levels.ERROR)
--     else
--       vim.notify("nvim-colorizer.lua successfully loaded", vim.log.levels.INFO)
--     end
--   end,
-- }

return {
  'brenoprata10/nvim-highlight-colors',
  config = function()
    require("nvim-highlight-colors").setup({
      ---Render style
      ---@usage 'background'|'foreground'|'virtual'
      render = 'virtual',

      ---Set virtual symbol (requires render to be set to 'virtual')
      virtual_symbol = '■',

      ---Set virtual symbol position()
      ---@usage 'inline'|'eol'|'eow'
      ---inline mimics VS Code style
      ---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
      ---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
      virtual_symbol_position = 'inline',
    })
  end
}
