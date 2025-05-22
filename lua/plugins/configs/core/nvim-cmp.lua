return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    -- Check if cmp is available
    local cmp_ok, cmp = pcall(require, "cmp")
    if not cmp_ok then
      vim.notify("Failed to load nvim-cmp: " .. tostring(cmp), vim.log.levels.ERROR)
      return
    end

    -- Check if luasnip is available
    local luasnip_ok, luasnip = pcall(require, "luasnip")
    if not luasnip_ok then
      vim.notify("Failed to load LuaSnip: " .. tostring(luasnip), vim.log.levels.ERROR)
      return
    end

    -- Load friendly-snippets if available
    local friendly_snippets_ok, _ = pcall(require, "luasnip.loaders.from_vscode")
    if friendly_snippets_ok then
      pcall(function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end)
    else
      vim.notify("friendly-snippets not loaded", vim.log.levels.INFO)
    end

    -- Helper function for super tab (moving through completion items)
    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    -- Setup cmp with error handling
    local setup_ok, setup_err = pcall(function()
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          -- Basic mappings
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          -- ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),

          -- Super Tab functionality
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
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
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "supermaven" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(entry, vim_item)
            -- Set a max length for the completion item
            local max_width = 50
            if vim_item.abbr and #vim_item.abbr > max_width then
              vim_item.abbr = vim_item.abbr:sub(1, max_width) .. "..."
            end

            -- Source in square brackets at the right
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]

            return vim_item
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        experimental = {
          ghost_text = false,
        },
      })
    end)

    if not setup_ok then
      vim.notify("Failed to setup nvim-cmp: " .. tostring(setup_err), vim.log.levels.ERROR)
      return
    end

    -- Setup for / search completion with error handling
    local cmd_setup_ok, cmd_setup_err = pcall(function()
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })
    end)

    if not cmd_setup_ok then
      vim.notify("Failed to setup nvim-cmp cmdline /: " .. tostring(cmd_setup_err), vim.log.levels.WARN)
    end

    -- Setup for : command completion with error handling
    local cmd_colon_setup_ok, cmd_colon_setup_err = pcall(function()
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })
    end)

    if not cmd_colon_setup_ok then
      vim.notify("Failed to setup nvim-cmp cmdline :: " .. tostring(cmd_colon_setup_err), vim.log.levels.WARN)
    end

    -- Setup highlight groups if not already defined
    local highlight_ok, highlight_err = pcall(function()
      vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { strikethrough = true, fg = "#808080" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#569CD6" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#569CD6" })
      vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#9CDCFE" })
      vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#9CDCFE" })
      vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#9CDCFE" })
      vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#C586C0" })
      vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#C586C0" })
      vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#D4D4D4" })
      vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#D4D4D4" })
      vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#D4D4D4" })
    end)

    if not highlight_ok then
      vim.notify("Failed to setup nvim-cmp highlights: " .. tostring(highlight_err), vim.log.levels.WARN)
    end
  end,
}
