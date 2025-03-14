return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
      vim.notify("Failed to load nvim-treesitter.configs", vim.log.levels.ERROR)
      return
    end

    -- Setup TreeSitter for highlighting, indentation, etc.
    treesitter_configs.setup({
      ensure_installed = {
        "html", "css", "scss", "javascript", "typescript", "tsx", "lua",
        "git_rebase", "gitcommit", "angular", "json", "markdown",
        "markdown_inline", "vim"
      },
      highlight = {
        enable = true,
        -- Only enable additional vim regex highlighting for markdown
        additional_vim_regex_highlighting = { "markdown" },
      },
      indent = { enable = true },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      modules = {},
    })

    -- Ensure TreeSitter is enabled for all files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        -- Enable TreeSitter highlighting for the current buffer
        vim.cmd("TSBufEnable highlight")
      end
    })

    -- Disable semantic token support in LSP clients globally (once at init)
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = true,
            virtual_text = true,
            signs = true,
            update_in_insert = false,
          }
        )
      end,
      once = true
    })
  end,
}
