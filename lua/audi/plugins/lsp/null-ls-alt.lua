-- Null-ls using .prettier files to format code and ESLint
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
          -- Look for .prettierrc file in the project root
          condition = function(utils)
            return utils.root_has_file({
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.js",
              "prettier.config.js",
              ".prettierrc.toml"
            })
          end,
          prefer_local = "node_modules/.bin",
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "tsx",
            "json",
            "html",
            "css",
            "scss",
            "sass",
            "lua",
            "markdown"
          },
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
