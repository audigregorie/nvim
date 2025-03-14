-- Automatically install lazy.nvim if it doesn't exist
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use lazy.nvim to manage plugins
require("lazy").setup({
  spec = {
    { import = "audi.plugins.colorscheme.colorscheme" },
    { import = "audi.plugins.comment.vim-commentary" },
    { import = "audi.plugins.completion.nvim-cmp" },
    { import = "audi.plugins.convert.vim-px-to-rem" },
    { import = "audi.plugins.cursor-word.mini-cursorword" },
    { import = "audi.plugins.error.nvim-notify" },
    { import = "audi.plugins.error.nvim-scrollbar" },
    { import = "audi.plugins.error.trouble" },
    { import = "audi.plugins.error.ts-error-translator" },
    { import = "audi.plugins.file-explorer.nvim-tree" },
    { import = "audi.plugins.file-explorer.oil" },
    { import = "audi.plugins.git.diffview" },
    { import = "audi.plugins.git.git-blame" },
    { import = "audi.plugins.git.gitsigns" },
    { import = "audi.plugins.git.lazygit" },
    { import = "audi.plugins.git.neogit" },
    { import = "audi.plugins.indent.mini-indentscope" },
    { import = "audi.plugins.indent.vim-sleuth" },
    { import = "audi.plugins.llm.avante" },
    { import = "audi.plugins.llm.supermaven" },
    -- { import = "audi.plugins.lsp.luarocks" },
    { import = "audi.plugins.lsp.mason" },
    { import = "audi.plugins.lsp.mason-lspconfig" },
    { import = "audi.plugins.lsp.mason-null-ls" },
    -- { import = "audi.plugins.lsp.null-ls-alt" },     -- ask claude
    { import = "audi.plugins.lsp.null-ls" },
    { import = "audi.plugins.lsp.nvim-code-action-menu" },
    { import = "audi.plugins.lsp.nvim-lspconfig" },
    { import = "audi.plugins.markdown.vim-markdown" },
    { import = "audi.plugins.markdown.md-headers" },
    { import = "audi.plugins.navigation.nvim-navic" },
    { import = "audi.plugins.navigation.nvim-tmux-navigation" },
    { import = "audi.plugins.pairs.nvim-auto-pairs" },
    { import = "audi.plugins.pairs.vim-surround" },
    { import = "audi.plugins.rest-http.rest" },
    { import = "audi.plugins.scroll.neoscroll" },
    { import = "audi.plugins.snippets.luasnip" },
    { import = "audi.plugins.statusline.lualine" },
    { import = "audi.plugins.tag.nvim-ts-autotag" },
    { import = "audi.plugins.tailwindcss.tailwindcss-colorizer-cmp" },
    { import = "audi.plugins.telescope.telescope" },
    { import = "audi.plugins.terminal.toggleterm" },
    { import = "audi.plugins.treesitter.treesitter" },
    { import = "audi.plugins.ui.dressing" },
    { import = "audi.plugins.ui.noice" },
    { import = "audi.plugins.ui.nvim-colorizer" },
    { import = "audi.plugins.ui.transparent" },
    { import = "audi.plugins.undotree.undotree" },
  }
}, {})
