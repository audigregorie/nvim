-- LSP support
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- Check if LSP API is available
    local lsp_ok, _ = pcall(function() return vim.lsp end)
    if not lsp_ok then
      vim.notify("Failed to access vim.lsp API", vim.log.levels.ERROR)
      return
    end

    -- Create autogroup with error handling
    local augroup_ok, user_lsp_group = pcall(function()
      return vim.api.nvim_create_augroup("UserLspConfig", {})
    end)

    if not augroup_ok then
      vim.notify("Failed to create LSP autogroup: " .. tostring(user_lsp_group), vim.log.levels.ERROR)
      return
    end

    -- Create autocmd with error handling
    local autocmd_ok, autocmd_err = pcall(function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = user_lsp_group,
        callback = function(ev)
          -- Set up buffer-local keymaps
          local opts = { buffer = ev.buf, noremap = true, silent = true }

          -- Function to safely set keymaps with individual error handling
          local function safe_keymap_set(mode, lhs, rhs, options, description)
            options = vim.tbl_extend("force", options or {}, { desc = description })
            local keymap_ok, keymap_err = pcall(vim.keymap.set, mode, lhs, rhs, options)
            if not keymap_ok then
              vim.notify(
                "Failed to set LSP keymap (" .. mode .. " " .. lhs .. "): " .. tostring(keymap_err),
                vim.log.levels.WARN
              )
            end
          end

          -- Navigation keymaps
          safe_keymap_set("n", "gd", vim.lsp.buf.definition, opts, "Go to definition")
          safe_keymap_set("n", "gD", vim.lsp.buf.declaration, opts, "Go to declaration")
          safe_keymap_set("n", "gi", vim.lsp.buf.implementation, opts, "Go to implementation")
          safe_keymap_set("n", "gr", vim.lsp.buf.references, opts, "Show references")
          safe_keymap_set("n", "gt", vim.lsp.buf.type_definition, opts, "Go to type definition")

          -- Information keymaps
          safe_keymap_set("n", "K", vim.lsp.buf.hover, opts, "Show hover information")
          -- safe_keymap_set("n", "<C-k>", vim.lsp.buf.signature_help, opts, "Show signature help")

          -- Workspace keymaps
          safe_keymap_set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts, "Add workspace folder")
          safe_keymap_set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts, "Remove workspace folder")
          safe_keymap_set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts, "List workspace folders")

          -- Code action keymaps
          safe_keymap_set("n", "<leader>rn", vim.lsp.buf.rename, opts, "Rename symbol")
          safe_keymap_set("n", "<leader>ca", vim.lsp.buf.code_action, opts, "Code action")
          safe_keymap_set("n", "<leader>f", function()
            local format_ok, format_err = pcall(function()
              vim.lsp.buf.format({ async = true })
            end)
            if not format_ok then
              vim.notify("Format failed: " .. tostring(format_err), vim.log.levels.WARN)
            end
          end, opts, "Format code")

          -- Diagnostic keymaps
          safe_keymap_set("n", "[d", vim.diagnostic.goto_prev, opts, "Previous diagnostic")
          safe_keymap_set("n", "]d", vim.diagnostic.goto_next, opts, "Next diagnostic")
          safe_keymap_set("n", "<leader>q", vim.diagnostic.setloclist, opts, "Set location list")
          safe_keymap_set("n", "<leader>d", vim.diagnostic.open_float, opts, "Show diagnostics")
        end,
      })
    end)

    if not autocmd_ok then
      vim.notify("Failed to create LSP attach autocmd: " .. tostring(autocmd_err), vim.log.levels.ERROR)
      return
    end

    -- Configure diagnostics with error handling
    local diagnostic_ok, diagnostic_err = pcall(function()
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    end)

    if not diagnostic_ok then
      vim.notify("Failed to configure LSP diagnostics: " .. tostring(diagnostic_err), vim.log.levels.WARN)
    end
  end
}
