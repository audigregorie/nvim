-- Bridge Mason with LSP config
return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "b0o/schemastore.nvim", -- Added dependency for JSON schemas
  },
  config = function()
    -- Check for dependencies
    local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
    local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
    local lspconfig_util = require("lspconfig.util")

    -- Exit early if critical dependencies are missing
    if not (cmp_nvim_lsp_ok and mason_lspconfig_ok and lspconfig_ok) then
      vim.notify("Failed to load LSP dependencies. Check your plugins.", vim.log.levels.ERROR)
      return
    end

    -- Get LSP capabilities
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Setup mason-lspconfig
    mason_lspconfig.setup({
      ensure_installed = {
        "ts_ls", -- TypeScript server (corrected from ts_ls)
        "html",
        "cssls",
        "lua_ls",
        "angularls",
        "eslint",
        "emmet_ls",    -- Added from servers list
        "jsonls",      -- Added from servers list
        "tailwindcss", -- Added from servers list
        "vimls"        -- Added from servers list
      },
      automatic_installation = true,
    })

    -- Configure LSP servers
    mason_lspconfig.setup_handlers({
      -- Default handler
      function(server_name)
        -- Only apply default handler if there's no specific handler
        if server_name ~= "angularls" and
            server_name ~= "cssls" and
            server_name ~= "emmet_ls" and
            server_name ~= "eslint" and
            server_name ~= "html" and
            server_name ~= "jsonls" and
            server_name ~= "lua_ls" and
            server_name ~= "tailwindcss" and
            server_name ~= "vimls" then
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end
      end,

      -- Custom handler for angularls
      ["angularls"] = function()
        lspconfig.angularls.setup({
          capabilities = capabilities,
          cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" },
          filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
          root_dir = lspconfig_util.root_pattern(
            "angular.json",
            "project.json",
            ".angular-cli.json",
            "angular-cli.json"
          ),
          -- Angular-specific settings
          settings = {
            angular = {
              experimental = {
                -- Enable enhanced completions including Emmet
                completions = {
                  emmet = true,
                },
              },
              -- Trace the server communication (good for debugging)
              trace = {
                server = "messages",
              },
              -- Enable Angular template language service
              templateParser = {
                enabled = true,
              },
              -- Preferred imports configuration
              preferredImports = {
                fromNgImport = true,
              },
            },
          },
        })
      end,

      -- Custom handler for emmet_ls
      ["emmet_ls"] = function()
        lspconfig.emmet_ls.setup({
          capabilities = capabilities,
          filetypes = {
            'html',
            'css',
            'scss',
            'less',
            'typescript', -- Add typescript for Angular templates
            'typescriptreact',
            'javascriptreact',
            'jsx',
            'tsx',
            'xml',
            'svg',    -- Support for SVG
            'vue',    -- Support for Vue if needed
            'angular' -- Recognize Angular files specifically
          },
          init_options = {
            html = {
              options = {
                -- Angular and React attribute syntax support
                ["bem.enabled"] = true,
                ["jsx.enabled"] = true,
                ["markup.attributes"] = {
                  -- Angular attributes
                  ["["] = { attribute = true },
                  ["("] = { attribute = true },
                  ["*"] = { attribute = true },
                  ["@"] = { attribute = true },
                },
              },
            },
            -- Additional customizations for TypeScript/Angular
            typescript = {
              javascriptreact = true,
              typescriptreact = true
            },
            -- Enable Emmet for JSX/TSX inside TypeScript files
            javascript = {
              javascriptreact = true,
              jsx = true
            },
          },
        })
      end,

      -- Custom handler for eslint
      ["eslint"] = function()
        lspconfig.eslint.setup({
          capabilities = capabilities,
          settings = {
            packageManager = "npm",
            experimental = {
              useFlatConfig = false,
            },
          },
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
        })
      end,

      -- Custom handler for html
      ["html"] = function()
        lspconfig.html.setup({
          capabilities = capabilities,
          filetypes = { "html", "twig", "hbs", "jsx", "tsx" },
        })
      end,

      -- Custom handler for jsonls
      ["jsonls"] = function()
        -- Check if schemastore is available
        local schemastore_ok, schemastore = pcall(require, "schemastore")
        local schemas = schemastore_ok and schemastore.json.schemas() or {}

        lspconfig.jsonls.setup({
          capabilities = capabilities,
          filetypes = { "json", "jsonc" },
          settings = {
            json = {
              schemas = schemas,
              validate = { enable = true },
            },
          },
        })
      end,

      -- Custom handler for lua_ls
      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim" },
                disable = "missing-fields",
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        })
      end,

      -- Custom handler for tailwindcss
      ["tailwindcss"] = function()
        lspconfig.tailwindcss.setup({
          capabilities = capabilities,
          filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "cx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                },
              },
              includeLanguages = {
                typescriptreact = "typescriptreact",
                html = "html",
                javascript = "javascript",
                typescript = "typescript"
              },
              cssLanguages = { scss = { parser = "postcss-scss" } },
            },
          },
        })
      end,

      -- Custom handler for ts_ls
      ["ts_ls"] = function()
        lspconfig.ts_ls.setup({
          capabilities = capabilities,
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "angular"
          },
          root_dir = lspconfig_util.root_pattern("tsconfig.json", "jsconfig.json", "package.json"),
          -- TypeScript-specific settings
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
          -- This helps with Angular integration
          on_attach = function(client, bufnr)
            -- Disable ts_ls formatting if you're using prettier/eslint
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        })
      end,

      -- Custom handler for cssls
      ["cssls"] = function()
        lspconfig.cssls.setup({
          capabilities = capabilities,
          settings = {
            css = { validate = true, lint = { unknownAtRules = "ignore" } },
            scss = { validate = true, lint = { unknownAtRules = "ignore" } },
            less = { validate = true, lint = { unknownAtRules = "ignore" } },
          },
        })
      end,

      -- Custom handler for vimls
      ["vimls"] = function()
        lspconfig.vimls.setup({
          capabilities = capabilities,
          -- Your empty config in the servers list suggests no special settings needed
        })
      end,
    })
  end,
}
