-- tailwindcss-colorizer-cmp.nvim setup (for completion menu colorization)
return {
  "roobert/tailwindcss-colorizer-cmp.nvim",
  event = "InsertEnter", -- Lazy load on insert mode only
  dependencies = {
    "hrsh7th/nvim-cmp",  -- Ensure cmp is loaded first
  },
  config = function()
    -- Safe requiring with error handling
    local tw_status, tailwind_colorizer = pcall(require, "tailwindcss-colorizer-cmp")
    if not tw_status then
      vim.notify("Failed to load tailwindcss-colorizer-cmp plugin", vim.log.levels.ERROR)
      return
    end

    local cmp_status, cmp = pcall(require, "cmp")
    if not cmp_status then
      vim.notify("Failed to load nvim-cmp plugin (required dependency)", vim.log.levels.ERROR)
      return
    end

    -- Configure tailwind colorizer with error handling
    local setup_ok, setup_error = pcall(function()
      tailwind_colorizer.setup({
        color_square_width = 2,
        -- Use a more efficient rendering method
        render = "template_string",
      })
    end)

    if not setup_ok then
      vim.notify("Error setting up tailwindcss-colorizer: " .. tostring(setup_error), vim.log.levels.ERROR)
      return
    end

    -- Only modify the formatter, keeping other cmp settings intact
    local cmp_config_ok, cmp_config = pcall(cmp.get_config)
    if not cmp_config_ok then
      vim.notify("Error getting cmp configuration", vim.log.levels.ERROR)
      return
    end

    local existing_formatting = cmp_config.formatting or {}

    local cmp_setup_ok, cmp_setup_error = pcall(function()
      cmp.setup({
        formatting = vim.tbl_extend("force", existing_formatting, {
          format = tailwind_colorizer.formatter
        })
      })
    end)

    if not cmp_setup_ok then
      vim.notify("Error configuring cmp with tailwind formatter: " .. tostring(cmp_setup_error), vim.log.levels.ERROR)
      return
    end
  end,
}
