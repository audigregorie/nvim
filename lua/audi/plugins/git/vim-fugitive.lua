-- <> Vim Fugitive
-- Git wrapper for vim
return {
  "tpope/vim-fugitive",
  config = function()
    -- Set the "diffAdded" highlight group with green text
    vim.api.nvim_set_hl(0, "diffAdded", { fg = "#00ff00", ctermfg = "green" })

    -- Set the "diffRemoved" highlight group with red text
    vim.api.nvim_set_hl(0, "diffRemoved", { fg = "#ff0000", ctermfg = "red" })
  end,

  opts = {
    -- Configuration options for git signs
    signs = {
      add = { text = "+"
      }, -- Sign for added lines
      change = { text = "~"
      }, -- Sign for changed lines
      delete = { text = "_"
      }, -- Sign for deleted lines
      topdelete = { text = "‾"
      }, -- Sign for top-deleted lines
      changedelete = { text = "~"
      }, -- Sign for changed/deleted lines
    },
    -- Function to attach gitsigns key mappings
    on_attach = function(bufnr)
      -- Key mapping to go to previous hunk
      vim.keymap.set(
        "n",
        "<leader>fp",
        require("gitsigns").prev_hunk,
        { buffer = bufnr, desc = "[G]o to [P]revious Hunk"
        }
      )
      -- Key mapping to go to next hunk
      vim.keymap.set(
        "n",
        "<leader>fn",
        require("gitsigns").next_hunk,
        { buffer = bufnr, desc = "[G]o to [N]ext Hunk"
        }
      )
    end,
  },
}
