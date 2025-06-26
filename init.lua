-- This allows `require("configs.filename")` to correctly find files
-- in `lua/configs/filename.lua`.
vim.opt.runtimepath:append(vim.fn.stdpath("config") .. "/lua")

require("configs.options")
require("configs.keymaps")
require("configs.autocmds")
require("configs.highlights")

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
  -- Enhanced Lua development for Neovim config
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    "Mofiqul/vscode.nvim",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require("vscode").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
          comments = { italic = false }, -- Disable italics in comments
        },
        -- Optional: enables terminal colors matching the theme
        terminal_colors = true,
        italic_comments = true,
        underline_links = true,
        -- Transparent backgrounds and borders for various UI elements
        group_overrides = {
          NormalFloat = { bg = "NONE" },
          VertSplit = { fg = "#000000" },
          FloatBorder = { fg = "#252525" },
          Pmenu = { bg = "NONE" },
          -- StatusLine = { bg = "NONE" },
          -- StatusLineNC = { bg = "NONE" },
          -- PmenuSel = { bg = "NONE" },
          -- NormalNC = { bg = "NONE" },
          -- LineNr = { bg = "NONE" },
          -- SignColumn = { bg = "NONE" },
          -- EndOfBuffer = { bg = "NONE" },
          -- TelescopeBorder = { fg = "#252525" },
        },
      })
      -- Load the colorscheme here.
      vim.cmd.colorscheme("vscode")
    end,
  },

  -- Angular-specific enhancements
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "angular",
          "typescript",
          "javascript",
          "html",
          "css",
          "scss",
          "json",
          "yaml",
          "lua",
          "vim",
        },
        auto_install = true,
        sync_install = false,
        ignore_install = {},
        modules = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
            },
          },
        },
      })
    end,
  },

  -- Null-ls for formatting and diagnostics
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls-extras.nvim", -- Needed for eslint_d
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")
      local formatting = require("none-ls.formatting.eslint_d")
      local diagnostics = require("none-ls.diagnostics.eslint_d")

      null_ls.setup({
        sources = {
          -- Only register eslint_d diagnostics if .eslintrc* is present
          diagnostics.with({
            condition = function(utils)
              return utils.root_has_file({
                ".eslintrc",
                ".eslintrc.js",
                ".eslintrc.cjs",
                ".eslintrc.json",
                ".eslintrc.yaml",
                ".eslintrc.yml",
              })
            end,
            filetypes = { "javascript", "typescript", },
          }),

          -- Only register eslint_d formatting if .eslintrc* is present
          formatting.with({
            condition = function(utils)
              return utils.root_has_file({
                ".eslintrc",
                ".eslintrc.js",
                ".eslintrc.cjs",
                ".eslintrc.json",
                ".eslintrc.yaml",
                ".eslintrc.yml",
              })
            end,
            filetypes = { "javascript", "typescript", },
          }),

          -- Prettier (conditionally enabled by presence of Prettier config)
          null_ls.builtins.formatting.prettierd.with({
            condition = function(utils)
              return utils.root_has_file({
                ".prettierrc",
                ".prettierrc.js",
                ".prettierrc.json",
                ".prettierrc.yaml",
                ".prettierrc.yml",
                "prettier.config.js",
                "prettier.config.cjs",
              })
            end,
          }),
        },

        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, async = false })
              end,
            })
          end
        end,
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "b0o/schemastore.nvim", lazy = true },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Enable inline diagnostics
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 2,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      local lspconfig = require("lspconfig")

      -- Common on_attach function for format-on-save
      local function common_on_attach(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
        -- LSP Keymaps
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local keymap = vim.keymap.set
        keymap("n", "gd", require("telescope.builtin").lsp_definitions,
          vim.tbl_extend("force", opts, { desc = "[G]oto [D]efinition" }))
        keymap("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "[G]oto [D]eclaration" }))
        keymap("n", "gr", require("telescope.builtin").lsp_references,
          vim.tbl_extend("force", opts, { desc = "[G]oto [R]eferences" }))
        keymap("n", "gi", require("telescope.builtin").lsp_implementations,
          vim.tbl_extend("force", opts, { desc = "[G]oto [I]mplementation" }))
        keymap("n", "gt", require("telescope.builtin").lsp_type_definitions,
          vim.tbl_extend("force", opts, { desc = "[G]oto [T]ype Definition" }))
        keymap("n", "ds", require("telescope.builtin").lsp_document_symbols,
          vim.tbl_extend("force", opts, { desc = "[D]ocument [S]ymbols" }))
        keymap("n", "ws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
          vim.tbl_extend("force", opts, { desc = "[W]orkspace [S]ymbols" }))
        keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
        keymap("i", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature Help" }))
        keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "[R]e[n]ame" }))
        keymap({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action,
          vim.tbl_extend("force", opts, { desc = "[C]ode [A]ction" }))
        keymap("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, vim.tbl_extend("force", opts, { desc = "Format Buffer" }))
        keymap("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show Diagnostics" }))
        keymap("n", "<leader>wd", require("telescope.builtin").diagnostics,
          vim.tbl_extend("force", opts, { desc = "[W]orkspace [D]iagnostics" }))
        keymap("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end,
          vim.tbl_extend("force", opts, { desc = "Previous Diagnostic" }))
        keymap("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end,
          vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))

        -- Inlay hints toggle keymap (available for all LSP clients that support it)
        if client.server_capabilities.inlayHintProvider then
          keymap("n", "<leader>ih", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
          end, vim.tbl_extend("force", opts, { desc = "Toggle [I]nlay [H]ints" }))
        end
      end


      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      -- Angular Language Server
      lspconfig.angularls.setup({
        on_attach = common_on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("angular.json", "tsconfig.json", ".git"),
      })

      -- TypeScript Server
      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
          common_on_attach(client, bufnr)

          -- Enable inlay hints if supported
          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
          end
        end,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      -- CSS Language Server
      lspconfig.cssls.setup({
        on_attach = common_on_attach,
        capabilities = capabilities,
      })

      -- JSON Language Server
      lspconfig.jsonls.setup({
        on_attach = common_on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(), -- optional
            validate = { enable = true },
          },
        },
      })

      -- Tailwind CSS Language Server
      lspconfig.tailwindcss.setup({
        on_attach = common_on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern(
          "tailwind.config.js",
          "tailwind.config.ts",
          "postcss.config.js",
          "package.json",
          ".git"
        ),
      })

      -- Lua Language Server
      lspconfig.lua_ls.setup({
        on_attach = common_on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      })
    end,
  },

  -- Fidget (LSP Progress UI)
  {
    "j-hui/fidget.nvim",
    tag = "legacy", -- Optional: remove if you're using the latest version
    event = "LspAttach",
    config = function()
      require("fidget").setup({})
    end,
  },

  -- Lspsaga (LSP UI Enhancements)
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        lightbulb = {
          enable = true,
          enable_in_insert = false,
          sign = true,
          virtual_text = false,
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional but improves UI
      "nvim-tree/nvim-web-devicons",     -- optional for icons
    },
  },

  -- lspkind (VSCode-like pictograms)
  {
    "onsails/lspkind.nvim",
    lazy = true,
  },

  -- mason.nvim (LSP/DAP/Tool installer)
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },

  -- mason-lspconfig (bridge between mason and lspconfig)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "angularls",
          "cssls",
          "jsonls",
          "tailwindcss",
          "lua_ls",
          "eslint",
        },
        automatic_installation = true,
        automatic_enable = true
      })
    end,
  },

  -- nvim-cmp (main completion engine)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  -- LuaSnip (Snippet engine)
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp", -- optional if using regex-based snippets
    event = "InsertEnter",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip").config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })
    end,
  },


  -- Require plugins into the config
  require("plugins.autopairs"),
  require("plugins.avante"),
  require("plugins.claudecode"),
  require("plugins.codesnap"),
  require("plugins.copilot"),
  require("plugins.diffview"),
  require("plugins.gitsigns"),
  require("plugins.guess-indent"),
  require("plugins.harpoon"),
  require("plugins.lualine"),
  require("plugins.mini"),
  require("plugins.oil"),
  require("plugins.telescope"),
  require("plugins.trouble"),
  require("plugins.undotree"),
  require("plugins.vim-fugitive"),

  -- Unused plugins
  -- require 'plugins.avante',
  -- require 'plugins.codecompanion',
  -- require 'plugins.debug',
  -- require 'plugins.dressing',
  -- require 'plugins.indent_line',
  -- require 'plugins.neo-tree',
  -- require 'plugins.nvim-navic',
  -- require 'plugins.nvim-notify',
  -- require 'plugins.rainbow-delimiters',
  -- require 'plugins.render-markdown',
  -- require 'plugins.supermaven',
  -- require 'plugins.tailwindcss-colorizer-cmp',
  -- require 'plugins.todo-comments',
  -- require 'plugins.transparent',
  -- require 'plugins.ts-error-translator',
  -- require 'plugins.vim-commentary',
  -- require 'plugins.which-key',

  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  ---@diagnostic disable-next-line: missing-fields
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
