-- <> Battery
return {
  "justinhj/battery.nvim",
  requires = {
    { 'nvim-tree/nvim-web-devicons'
    },
    { 'nvim-lua/plenary.nvim'
    }
  },
  config = function()
    require("battery").setup({})
  end,
}
