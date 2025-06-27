return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = "Oil",
  keys = {
    {
      '-',
      function()
        require('oil').open()
      end,
      desc = 'Open parent directory',
    },
    {
      '<leader>e',
      function()
        require('oil').toggle_float()
      end,
      desc = 'Toggle Oil Explorer',
    },
  },
  config = function()
    require('oil').setup {
      columns = {
        -- 'size',
        'icon',
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name)
          return name == '..' or name == '.git'
        end,
      },
    }
  end,
}
