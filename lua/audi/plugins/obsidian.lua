return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = function()
    return {
      workspaces = {
        {
          name = "personal",
          path = vim.fn.expand("~/vaults/personal"), -- Expand to handle '~'
        },
        {
          name = "work",
          path = vim.fn.expand("~/vaults/work"), -- Expand for better compatibility
        },
      },
    }
  end,
  config = function(_, opts)
    require("obsidian").setup(opts)

    -- Keymaps for quicker access (if desired)
    vim.keymap.set("n", "<leader>op", function() require("obsidian").open("personal") end,
      { desc = "[O]pen [P]ersonal Vault" })
    vim.keymap.set("n", "<leader>ow", function() require("obsidian").open("work") end, { desc = "[O]pen [W]ork Vault" })
  end,
}

