-- VSCode-like breadcrumbs
return {
  "SmiteshP/nvim-navic",
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    local vim = vim

    -- Set background color for the winbar
    vim.api.nvim_set_hl(0, "WinBar", { bg = "#111112" })
    -- vim.api.nvim_set_hl(0, "WinBar", { bg = "#0d1014" })


    local navic = require("nvim-navic")
    navic.setup({
      icons = {
        File          = "󰈙 ",
        Module        = " ",
        Namespace     = "󰌗 ",
        Package       = " ",
        Class         = "󰌗 ",
        Method        = "󰆧 ",
        Property      = " ",
        Field         = " ",
        Constructor   = " ",
        Enum          = "󰕘",
        Interface     = "󰕘",
        Function      = "󰊕 ",
        Variable      = "󰆧 ",
        Constant      = "󰏿 ",
        String        = "󰀬 ",
        Number        = "󰎠 ",
        Boolean       = "◩ ",
        Array         = "󰅪 ",
        Object        = "󰅩 ",
        Key           = "󰌋 ",
        Null          = "󰟢 ",
        EnumMember    = " ",
        Struct        = "󰌗 ",
        Event         = " ",
        Operator      = "󰆕 ",
        TypeParameter = "󰊄 ",
      },
      highlight = true,
      separator = " > ",
      depth_limit = 0,
      depth_limit_indicator = "..",
      safe_output = true,
    })

    -- Create a winbar with breadcrumbs
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

    -- Create a reusable on_attach function for LSP that includes navic attachment
    local on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end

    -- Attach to TypeScript/JavaScript server
    local lspconfig = require('lspconfig')

    -- TypeScript server
    lspconfig.ts_ls.setup({
      on_attach = on_attach,
      -- Add any other TypeScript-specific settings here
    })

    -- Angular Language Service
    lspconfig.angularls.setup({
      on_attach = on_attach,
      -- Add any other Angular-specific settings here
    })

    -- CSS Language Server
    lspconfig.cssls.setup({
      on_attach = on_attach,
      -- Add any other CSS-specific settings here
    })

    -- Lua Language Server
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      -- Add any other Lua-specific settings here
    })
  end,
}
