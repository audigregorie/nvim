-- <> Mini Indentscope
return {
  "echasnovski/mini.indentscope",
  event = "BufEnter",
  opts = {
    symbol = "│",
    options = { try_as_border = true
    },
  },
  init = function()
    local macchiato = require("catppuccin.palettes").get_palette("macchiato")
    vim.api.nvim_create_autocmd("FileType",
      {
        pattern = {
          "help",
          "lazy",
          "mason",
          "notify",
          "oil",
          "Oil",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })

    vim.api.nvim_set_hl(0,
      "MiniIndentscopeSymbol",
      { fg = macchiato.mauve
      })
  end,
}
