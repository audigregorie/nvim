return {
  'preservim/vim-markdown',
  config = function()
    -- Disable folding in vim-markdown
    vim.g.vim_markdown_folding_disabled = 1

    -- -- Setup auto commands for markdown files
    -- local markdown_group = vim.api.nvim_create_augroup("MarkdownConfig", { clear = true })

    -- -- Set better text wrapping for markdown files
    -- vim.api.nvim_create_autocmd("FileType", {
    --   group = markdown_group,
    --   pattern = { "markdown", "md" },
    --   callback = function()
    --     -- Better line wrapping
    --     vim.opt_local.wrap = true
    --     vim.opt_local.linebreak = true
    --     vim.opt_local.breakindent = true

    --     -- Spell checking
    --     vim.opt_local.spell = true
    --     vim.opt_local.spelllang = "en_us"
    --   end,
    -- })
  end,
}
