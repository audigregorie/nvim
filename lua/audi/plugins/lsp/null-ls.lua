return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- Safely load null-ls to avoid runtime errors
    local null_ls_ok, null_ls = pcall(require, "null-ls")
    if not null_ls_ok then
      vim.notify("Null ls not found!", vim.log.levels.ERROR)
      return
    end

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    -- Setup null-ls with specific configurations
    null_ls.setup({
      debug = true,
      sources = {
        null_ls.builtins.formatting.prettier.with({
          -- -- Conditionally enable Prettier formatting based on the presence of .prettierrc file
          -- condition = function(utils)
          --   return utils.root_has_file({ ".prettierrc" })
          -- end,

          -- Apply prefer_local only for non-Lua files
          condition = function(utils)
            return vim.bo.filetype ~= "lua" and vim.bo.filetype ~= "markdown"
          end,
          prefer_local = "node_modules/.bin",
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "tsx", "json", "html", "css", "scss", "sass" },
          extra_args = {
            "--parser", "angular",
            "--arrow-parens", "always",
            "--bracket-spacing", "true",
            "--bracket-same-line", "true",
            "--print-width", "260",
            "--semi", "true",
            "--single-quote", "true",
            "--tab-width", "2",
            "--trailing-comma", "none",
            "--use-tabs", "false",
            -- "--jsx-single-quote", "false",
            -- "--quote-props", "as-needed",
            -- "--single-attribute-per-line", "true",
          },
        }),

        null_ls.builtins.formatting.standardrb,

        -- Prettier configuration specifically for Markdown files
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "markdown" },
          prefer_local = "node_modules/.bin",
          extra_args = {
            "--print-width", "120", -- Adjust this value as needed for Markdown files
            "--prose-wrap", "always",
          },
        }),

        -- Use .prettierrc specifically for Lua files
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "lua" },
          condition = function(utils)
            -- Ensure there's a .prettierrc file in the root for Lua files
            return utils.root_has_file({ ".prettierrc" })
          end,
          prefer_local = "node_modules/.bin",
        }),
      },

      -- Automatically format the buffer on save if supported
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
}
