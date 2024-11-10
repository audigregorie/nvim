return {
  "hrsh7th/nvim-cmp",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    "windwp/nvim-ts-autotag",
    "windwp/nvim-autopairs",
    {
      "L3MON4D3/LuaSnip",
      -- version = "v2.3",
    },
  },
  config = function(_, opts)
    -- Safely load required plugins to avoid runtime errors
    local cmp_ok, cmp = pcall(require, "cmp")
    if not cmp_ok then
      vim.notify("nvim-cmp not found!", vim.log.levels.ERROR)
      return
    end

    local luasnip_ok, luasnip = pcall(require, "luasnip")
    if not luasnip_ok then
      vim.notify("LuaSnip not found!", vim.log.levels.ERROR)
      return
    end

    local lspkind_ok, lspkind = pcall(require, "lspkind")
    if not lspkind_ok then
      vim.notify("lspkind not found!", vim.log.levels.ERROR)
      return
    end

    local cmp_autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
    if not cmp_autopairs_ok then
      vim.notify("nvim-autopairs not found!", vim.log.levels.ERROR)
      return
    end

    -- Setup nvim-autopairs and integrate with cmp
    require("nvim-autopairs").setup()
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    -- Load VSCode-like snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),           -- scroll up preview
        ["<C-d>"] = cmp.mapping.scroll_docs(4),            -- scroll down preview
        ["<C-Space>"] = cmp.mapping.complete({}),          -- show completion suggestions
        ["<C-c>"] = cmp.mapping.abort(),                   -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- select suggestion
      }),

      -- Sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" },                    -- LSP-based completions
        { name = "path",    max_item_count = 3 }, -- filesystem paths with a limit on the number of suggestions
        { name = "luasnip" },                     -- snippets
        -- { name = "supermaven" },               -- Autocompletion copilot
        -- {name = "codieum"},          -- Autocompletion copilot
      }),

      -- Formatting configuration with icons
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          symbol_map = { Copilot = "" }, -- Customize icons for copilot or other sources
          before = require("tailwind-tools.cmp").lspkind_format,
        }),
      },

      experimental = { ghost_text = true }, -- Display ghost text for inline completion
    })
  end,
}
