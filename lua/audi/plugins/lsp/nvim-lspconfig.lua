-- <> Lspconfig
return {
  "neovim/nvim-lspconfig",

  dependencies = {
    {
      "williamboman/mason.nvim",
      config = true
    },
    "williamboman/mason-lspconfig.nvim",
    {
      "j-hui/fidget.nvim",
      tag = "legacy",
      opts = {}
    },
    "folke/neodev.nvim",
  },

  config = function()
    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then desc = "LSP: " .. desc end
        vim.keymap.set("n", keys, func,
          { buffer = bufnr, desc = desc
          })
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

      -- Local command for formatting
      vim.api.nvim_buf_create_user_command(bufnr,
        "Format", function(_)
          vim.lsp.buf.format()
        end,
        { desc = "Format current buffer with LSP"
        })
    end

    -- Custom diagnostic symbols
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " "
    }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl,
        { text = icon, texthl = hl, numhl = ""
        })
    end

    local servers = {
      angularls = {
        cmd = {
          "ngserver",
          "--stdio",
          "--tsProbeLocations",
          "",
          "--ngProbeLocations",
          ""
        },
        filetypes = {
          "typescript",
          "html",
          "typescriptreact",
          "typescript.tsx"
        },
      },
      cssls = {
        settings = {
          css = {
            validate = true,
            lint = { unknownAtRules = "ignore"
            }
          },
          scss = {
            validate = true,
            lint = { unknownAtRules = "ignore"
            }
          },
          less = {
            validate = true,
            lint = { unknownAtRules = "ignore"
            }
          },
        },
      },
      emmet_ls = {
        filetypes = { 'html', 'css', 'typescriptreact', 'javascriptreact', 'jsx', 'tsx' }
      },
      html = {
        filetypes = {
          "html",
          "twig",
          "hbs"
        }
      },
      jsonls = {
        filetypes = { "json", "jsonc" },
      },
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          diagnostics = { disable = "missing-fields", enable = false },
        },
      },
      pyright = {},
      tailwindcss = {
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        settings = {
          tailwindCSS = {
            includeLanguages = {
              typescriptreact = "typescriptreact",
              html = "html",
            },
            cssLanguages = {
              scss = { parser = "postcss-scss" },
            },
          },
        },
      },
      -- tsserver = {
      ts_ls = {
        cmd = {
          "typescript-language-server",
          "--stdio"
        },
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
      },
      vimls = {},
    }

    require("neodev").setup()

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name
            ].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name
          ],
          filetypes = (servers[server_name
          ] or {}).filetypes,
        })
      end,
    })
  end,
}
