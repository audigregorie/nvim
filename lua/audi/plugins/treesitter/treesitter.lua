return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",

  config = function()
    -- Safely load nvim-treesitter
    local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
      vim.notify("nvim-treesitter not found!", vim.log.levels.ERROR)
      return
    end

    ts_configs.setup({
      ensure_installed = {
        "bash", "c", "cpp", "css", "go", "graphql", "html", "http", "javascript", "json",
        "lua", "markdown", "python", "rust", "tsx", "typescript", "vim", "xml", "yaml",
      },
      sync_install = false, -- Install parsers asynchronously
      auto_install = true,  -- Enable automatic installation
      ignore_install = {},  -- List of parsers to ignore during install
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false, -- Disable if causing conflicts
      },
      indent = { enable = true },                  -- Enable indentation
      rainbow = { enable = false },                -- Rainbow brackets
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<M-space>",
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj
          keymaps = {
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
  end,
}
