return {
  'windwp/nvim-ts-autotag',
  event = { "InsertEnter", "BufRead", "BufNewFile" }, -- Load only when necessary to improve startup time
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function(_, opts)
    require('nvim-ts-autotag').setup(opts)
  end,
}

