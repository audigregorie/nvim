return {
  'folke/trouble.nvim',
  lazy = true,                                      -- Improve startup performance with lazy loading
  cmd = { "TroubleToggle", "Trouble" },             -- Load only when the Trouble command is used
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Ensure icons are available
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',              desc = 'Diagnostics (Trouble)' },
    { '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
  },
  config = function()
    require('trouble').setup()
  end,
}
