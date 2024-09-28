-- <> Treesitter
return {
  -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",

  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "go",
        "graphql",
        "html",
        "http",
        "javascript",
        "json",
        "lua",
        "markdown",
        "python",
        "rust",
        "tsx",
        "typescript",
        "vim",
        "xml",
        "yaml",
      },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = false,
      -- List of parsers to ignore installing (or "all")
      ignore_install = {},
      modules = {},
      highlight = { enable = true
      },
      indent = { enable = true
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<M-space>",
        },
      },
      -- autotag = {
      --   enable = true,
      --   enable_rename = true,
      --   enable_close = true,
      --   enable_close_on_slash = true,
      --   filetypes = {
      --     "html",
      --     "xml",
      --     "tsx"
      --   },
      -- },
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          -- whether to set jumps in the jumplist
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
    })

    -- -- Diagnostic keymaps
    -- vim.keymap.set("n",
    -- "[d", vim.diagnostic.goto_prev,
    -- { desc = "Go to previous diagnostic message"
    -- })
    -- vim.keymap.set("n",
    -- "]d", vim.diagnostic.goto_next,
    -- { desc = "Go to next diagnostic message"
    -- })
    -- vim.keymap.set("n",
    -- "<leader>r", vim.diagnostic.open_float,
    -- { desc = "Open floating diagnostic message"
    -- })
    -- vim.keymap.set("n",
    -- "<leader>q", vim.diagnostic.setloclist,
    -- { desc = "Open diagnostics list"
    -- })
  end,
}
