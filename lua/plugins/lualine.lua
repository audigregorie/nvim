return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- For icons
  event = "VimEnter",
  config = function()
    -- Function to get a custom message with error handling
    local getShitDone = function()
      return "Get Shit Done"
    end

    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'auto', -- or 'vscode'
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_last_session = true,
        display_component_numbers = false,
        globalstatus = false,
      },
      sections = {
        lualine_a = { '' },
        lualine_b = { 'branch', 'diagnostics' },
        lualine_c = { { 'filename', path = 1, color = { fg = '#aaaaaa' } } },
        lualine_x = { { 'diff', }, { getShitDone, color = { fg = '#aaaaaa' } } },
        lualine_y = { '' },
        lualine_z = { '' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = { '' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {}
    })
  end
}
