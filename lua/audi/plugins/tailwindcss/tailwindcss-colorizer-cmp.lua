return {
"roobert/tailwindcss-colorizer-cmp.nvim",
dependencies = {
  "hrsh7th/nvim-cmp",
},
config = function()
  vim.schedule(function()
    -- Check if the plugin is available
    local status_ok, colorizer_cmp = pcall(require, "tailwindcss-colorizer-cmp")
    if not status_ok then
      vim.notify("Failed to load tailwindcss-colorizer-cmp plugin", vim.log.levels.ERROR)
      return
    end
    
    -- Define options
    local opts = {
      color_square_width = 2, -- Width of the color square in the completion menu
    }
    
    -- Try to setup the plugin with the options
    local setup_ok, setup_error = pcall(function()
      colorizer_cmp.setup(opts)
    end)
    
    -- Handle any errors during setup
    if not setup_ok then
      vim.notify("Error setting up tailwindcss-colorizer-cmp: " .. tostring(setup_error), vim.log.levels.ERROR)
      return
    end
    
    -- Check if cmp is available
    local cmp_ok, cmp = pcall(require, "cmp")
    if not cmp_ok then
      vim.notify("Failed to load nvim-cmp plugin (required for tailwindcss-colorizer-cmp)", vim.log.levels.ERROR)
      return
    end
    
    -- Try to update cmp configuration
    local cmp_setup_ok, cmp_error = pcall(function()
      -- Get existing configuration first
      local existing_config = cmp.get_config()
      local existing_formatting = existing_config.formatting or {}
      
      -- Update only the formatter function, preserving other formatting options
      cmp.setup({
        formatting = vim.tbl_deep_extend("force", existing_formatting, {
          format = colorizer_cmp.formatter
        })
      })
    end)
    
    -- Handle any errors during cmp setup
    if not cmp_setup_ok then
      vim.notify("Error integrating tailwindcss-colorizer-cmp with nvim-cmp: " .. tostring(cmp_error), vim.log.levels.ERROR)
    end
  end)
end,
}
