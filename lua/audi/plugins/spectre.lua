-- <> Spectre
return {
  "nvim-pack/nvim-spectre",
  lazy = true,
  cmd = {
    "Spectre"
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "catppuccin/nvim",
  },
  config = function()
    local theme = require("catppuccin.palettes").get_palette("macchiato")

    vim.api.nvim_set_hl(0,
      "SpectreSearch",
      { bg = theme.red, fg = theme.base
      })
    vim.api.nvim_set_hl(0,
      "SpectreReplace",
      { bg = theme.green, fg = theme.base
      })

    require("spectre").setup({
      highlight = {
        search = "SpectreSearch",
        replace = "SpectreReplace",
      },
      mapping = {
        [
        "send_to_qf"
        ] = {
          map = "<C-q>",
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "send all items to quickfix",
        },
      },
      replace_engine = {
        sed = {
          cmd = "sed",
        },
      },
    })

    -- Open Spectre for global find/replace
    vim.keymap.set("n",
      "<leader>S", function()
        require("spectre").toggle()
      end,
      { noremap = true, silent = true
      })

    -- Open Spectre for global find/replace for the word under the cursor in normal mode
    vim.keymap.set("n",
      "<leader>sw", function()
        require("spectre").open_visual({ select_word = true
        })
      end,
      { desc = "Search current word", noremap = true, silent = true
      })
  end,
}
