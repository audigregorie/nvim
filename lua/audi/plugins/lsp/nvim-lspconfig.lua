-- <> Lspconfig
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true, },
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim",       tag = "legacy", opts = {}, },
    "folke/neodev.nvim",
  },

  config = function()
    local ok, lspconfig = pcall(require, "lspconfig")
    if not ok then
      vim.notify("Failed to load lspconfig module", vim.log.levels.ERROR)
      return
    end

    local ok, lspconfig_util = pcall(require, "lspconfig.util")
    if not ok then
      vim.notify("Failed to load lspconfig.util module", vim.log.levels.ERROR)
      return
    end

    local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not ok then
      vim.notify("Failed to load mason-lspconfig module", vim.log.levels.ERROR)
      return
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- On-attach function for LSP-related keybindings
    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc and "LSP: " .. desc })
      end

      -- LSP-related keybindings
      nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
      nmap("<leader>gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
      nmap("<leader>gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
      nmap("<leader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      nmap("<leader>td", vim.lsp.buf.type_definition, "Type [D]efinition")
      nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
      nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
      nmap("<leader>sd", vim.lsp.buf.signature_help, "Signature Documentation")
      nmap("<leader>hd", vim.lsp.buf.hover, "Hover Documentation")
      nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      nmap("<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        "[W]orkspace [L]ist Folders")

      -- Formatting command
      vim.api.nvim_buf_create_user_command(bufnr,
        "Format", function(_)
          vim.lsp.buf.format()
        end,
        { desc = "Format current buffer with LSP"
        })
    end

    -- Custom diagnostic symbols
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Server configuration
    local servers = {
      angularls = {
        cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" },
        filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
      },
      cssls = {
        settings = {
          css = { validate = true, lint = { unknownAtRules = "ignore" } },
          scss = { validate = true, lint = { unknownAtRules = "ignore" } },
          less = { validate = true, lint = { unknownAtRules = "ignore" } },
        },
      },
      emmet_ls = { filetypes = { 'html', 'css', 'typescriptreact', 'javascriptreact', 'jsx', 'tsx' } },
      html = { filetypes = { "html", "twig", "hbs" } },
      jsonls = { filetypes = { "json", "jsonc" } },
      lua_ls = {
        Lua = {
          -- workspace = { checkThirdParty = false },
          -- telemetry = { enable = false },
          -- diagnostics = { disable = "missing-fields", enable = false },
          runtime = {
            -- Tell the language server which version of Lua you're using
            version = "LuaJIT",
          },
          diagnostics = {
            -- Enable recognition of `vim` global variable for Neovim configs
            globals = { "vim" },
            disable = "missing-fields",
            -- enable = false
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,      -- Disable third-party checks if you don't need them
          },
          telemetry = { enable = false }, -- Disable telemetry to avoid sending data
        },
      },
      pyright = {},
      tailwindcss = {
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        settings = {
          tailwindCSS = {
            includeLanguages = { typescriptreact = "typescriptreact", html = "html" },
            cssLanguages = { scss = { parser = "postcss-scss" } },
          },
        },
      },
      ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        settings = {
          typescript = {
            -- inlayHints = {
            --   includeInlayParameterNameHints = 'all',
            --   includeInlayFunctionParameterTypeHints = true,
            --   includeInlayVariableTypeHints = true,
            --   includeInlayFunctionLikeReturnTypeHints = true,
            --   includeInlayEnumMemberValueHints = true,
            -- },
          },
          javascript = {
            -- inlayHints = {
            --   includeInlayParameterNameHints = 'all',
            --   includeInlayFunctionParameterTypeHints = true,
            --   includeInlayVariableTypeHints = true,
            --   includeInlayFunctionLikeReturnTypeHints = true,
            --   includeInlayEnumMemberValueHints = true,
            -- },
          },
        },
      },
      vimls = {},
    }

    -- Setup neodev for better Lua support
    require("neodev").setup()

    -- Setup Mason LSPconfig and ensure required servers are installed
    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    -- Attach LSP configuration to each server
    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        })
      end,
    })
  end,
}
