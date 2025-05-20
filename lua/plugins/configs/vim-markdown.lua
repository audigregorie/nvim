return {
  'preservim/vim-markdown',
  config = function()
    -- Disable folding in vim-markdown
    vim.g.vim_markdown_folding_disabled = 1

    -- Ensure markdown detection is properly set up
    vim.g.vim_markdown_auto_extension_ext = 'md'

    -- Uncomment your autocmd section for better markdown settings
    local markdown_group = vim.api.nvim_create_augroup("MarkdownConfig", { clear = true })

    -- Add an explicit filetype detection for .md files
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      group = markdown_group,
      pattern = { "*.md", "*.markdown" },
      callback = function()
        vim.bo.filetype = "markdown"
        -- Debug output to confirm filetype is set
        print("Setting filetype to markdown for " .. vim.fn.expand("%:p"))
      end
    })

    -- Re-enable your other markdown settings
    vim.api.nvim_create_autocmd("FileType", {
      group = markdown_group,
      pattern = { "markdown", "md" },
      callback = function()
        -- Better line wrapping
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        -- Spell checking
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
      end,
    })
  end,
}
