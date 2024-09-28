-- <> Null-ls
return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

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
          extra_args = {
            "--arrow-parens", "always",
            "--bracket-spacing", "true",
            "--bracket-same-line", "true",
            "--print-width", "160",
            "--semi", "true",
            "--single-quote", "true",
            "--tab-width", "2",
            "--trailing-comma", "none",
            "--use-tabs", "false",
            -- "--embedded-language-formatting", "auto",
            -- "--end-of-line", "lf",
            -- "--html-whitespace-sensitivity", "css",
            -- "--jsx-single-quote", "false",
            -- "--prose-wrap", "preserve",
            -- "--quote-props", "as-needed",
            -- "--single-attribute-per-line", "true",
            -- "--vue-indent-script-and-style", "false",
          },
        }),

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
