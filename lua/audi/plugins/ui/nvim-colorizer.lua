return {
  "NvChad/nvim-colorizer.lua",
  config = function()
    -- Defer the setup to ensure all dependencies are loaded
    vim.schedule(function()
      -- Check if the plugin is available
      local status_ok, colorizer = pcall(require, "colorizer")
      if not status_ok then
        vim.notify("Failed to load nvim-colorizer.lua plugin", vim.log.levels.ERROR)
        return
      end

      -- Define options within the config function
      local opts = {
        mode = "virtualtext", -- Display color codes as virtual text
        filetypes = {
          "!jsx",           -- Exclude JSX files from being colorized
          "!html",          -- Exclude HTML files from being colorized
        },
        -- tailwind = true, -- Enable tailwind-specific color processing
      }

      -- Try to setup the plugin with the options
      local setup_ok, error = pcall(function()
        colorizer.setup(opts)
      end)

      -- Handle any errors during setup
      if not setup_ok then
        vim.notify("Error setting up nvim-colorizer: " .. tostring(error), vim.log.levels.ERROR)
      end
    end)
  end,
}
