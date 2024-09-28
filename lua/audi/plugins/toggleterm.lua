-- <> Toggleterm
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    size = 40,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
    close_on_exit = true,
    float_opts = {
      border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' |
    },
  },
}
