return {
  "folke/twilight.nvim",
  opts = {
    dimming = {
      alpha = 0.25,                    -- Amount of dimming, lower is more dim (default: 0.25)
      color = { "Normal", "#ffffff" }, -- Dimming color (default: normal foreground)
      inactive = true,                 -- Dims only inactive windows
    },
    context = 10,                      -- Number of lines to display around the focused code
    treesitter = true,                 -- Use treesitter for better dimming (if available)
    expand = {                         -- Expand these filetypes
      "function",
      "method",
      "table",
      "if_statement",
    },
  },

  config = function(_, opts)
    require("twilight").setup(opts)

    -- Optional keymap to toggle Twilight
    vim.api.nvim_set_keymap("n", "<leader>tl", ":Twilight<CR>", { noremap = true, silent = true })
  end,
}

