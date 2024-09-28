-- <> Md Headers
return {
  -- View markdown headers
  "AntonVanAssche/md-headers.nvim",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
  config = function()
    require("md-headers").setup({
      width = 90,
      height = 30,
      borderchars = {
        "─",
        "│",
        "─",
        "│",
        "╭",
        "╮",
        "╯",
        "╰"
      },
      popup_auto_close = true,
    })

    -- Shorten function name.
    local keymap = vim.keymap.set

    -- Silent keymap option.
    local opts = { silent = true
    }

    -- Set keymap.
    keymap("n",
      "<leader>mh",
      "<cmd>MarkdownHeaders<CR>", opts)
  end,
}
