return {
  "lewis6991/gitsigns.nvim",

  opts = {
    signs = {
      add = { text = "+" }, -- Sign for added lines
      change = { text = "~" }, -- Sign for changed lines
      delete = { text = "_" }, -- Sign for deleted lines
      topdelete = { text = "‾" }, -- Sign for top-deleted lines
      changedelete = { text = "~" }, -- Sign for changed/deleted lines
    },

    on_attach = function(bufnr)
      -- Key mapping to go to previous hunk
      vim.keymap.set(
        "n",
        "<leader>fp",
        require("gitsigns").prev_hunk,
        { buffer = bufnr, desc = "[G]o to [P]revious Hunk" }
      )
      -- Key mapping to go to next hunk
      vim.keymap.set(
        "n",
        "<leader>fn",
        require("gitsigns").next_hunk,
        { buffer = bufnr, desc = "[G]o to [N]ext Hunk" }
      )
    end,
  },
}

