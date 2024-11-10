return {
  'preservim/vim-markdown',
  config = function()
    -- Disable folding in vim-markdown
    vim.g.vim_markdown_folding_disabled = 1
  end,
}
