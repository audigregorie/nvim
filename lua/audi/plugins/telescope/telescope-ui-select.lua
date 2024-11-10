return {
  "nvim-telescope/telescope-ui-select.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },

  config = function()
    -- Safely load telescope
    local telescope_ok, telescope = pcall(require, "telescope")
    if not telescope_ok then
      vim.notify("Telescope not found!", vim.log.levels.ERROR)
      return
    end

    -- Configure telescope with ui-select settings
    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            winblend = 15,  -- Transparency for the dropdown menu
            layout_config = {
              width = 0.8,  -- Adjust width
              height = 0.4, -- Adjust height
            },
          }),
        },
      },
    })

    -- Load the ui-select extension
    local ui_select_ok = pcall(telescope.load_extension, "ui-select")
    if not ui_select_ok then
      vim.notify("Failed to load Telescope UI Select extension", vim.log.levels.ERROR)
    end
  end,
}
