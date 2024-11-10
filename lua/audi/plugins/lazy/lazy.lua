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
    { import = "audi.plugins.colorschemes.colorschemes" },
    { import = "audi.plugins.completion.nvim-cmp" },
    { import = "audi.plugins.git.diffview" },
    { import = "audi.plugins.git.gitsigns" },
    { import = "audi.plugins.git.neogit" },
    { import = "audi.plugins.git.vim-fugitive" },
    { import = "audi.plugins.git.vim-rhubarb" },
    { import = "audi.plugins.git.git-worktree" },
    { import = "audi.plugins.lsp.fidget" },
    { import = "audi.plugins.lsp.nvim-lspconfig" },
    { import = "audi.plugins.lsp.mason-null-ls" },
    { import = "audi.plugins.lsp.null-ls" },
    { import = "audi.plugins.telescope.nvim-notify" },
    { import = "audi.plugins.telescope.telescope" },
    { import = "audi.plugins.telescope.telescope-file-browser" },
    { import = "audi.plugins.telescope.telescope-fzf-native" },
    { import = "audi.plugins.telescope.telescope-ui-select" },
    { import = "audi.plugins.telescope.tailiscope" },
    { import = "audi.plugins.telescope.cheatsheet" },
    { import = "audi.plugins.treesitter.treesitter" },

    -- Other plugins
    -- { import = "audi.plugins.avante" },
    { import = "audi.plugins.battery" },
    { import = "audi.plugins.conform" },
    { import = "audi.plugins.dressing" },
    { import = "audi.plugins.harpoon" },
    { import = "audi.plugins.headlines" },
    { import = "audi.plugins.lazygit" },
    { import = "audi.plugins.lorem" },
    { import = "audi.plugins.lualine" },
    { import = "audi.plugins.luarocks" },
    { import = "audi.plugins.md-headers" },
    { import = "audi.plugins.mini-cursorword" },
    { import = "audi.plugins.mini-indentscope" },
    { import = "audi.plugins.nvim-colorizer" },
    { import = "audi.plugins.nvim-tmux-navigation" },
    { import = "audi.plugins.nvim-tree" },
    { import = "audi.plugins.nvim-ts-autotag" },
    { import = "audi.plugins.nvim-ts-context-commentstring" },
    { import = "audi.plugins.oil" },
    { import = "audi.plugins.rest" },
    { import = "audi.plugins.spectre" },
    { import = "audi.plugins.symbols-outline" },
    { import = "audi.plugins.tailwind-tools" },
    { import = "audi.plugins.toggleterm" },
    { import = "audi.plugins.transparent" },
    { import = "audi.plugins.trouble" },
    { import = "audi.plugins.twilight" },
    { import = "audi.plugins.ts-error-translator" },
    { import = "audi.plugins.undotree" },
    { import = "audi.plugins.vim-commentary" },
    { import = "audi.plugins.vim-markdown" },
    { import = "audi.plugins.vim-maximizer" },
    { import = "audi.plugins.vim-px-to-rem" },
    { import = "audi.plugins.vim-sleuth" },
    { import = "audi.plugins.vim-surround" },
    { import = "audi.plugins.wilder" },

    -- Unused plugins
    -- { import = "audi.plugins.codeium" },
    -- { import = "audi.plugins.chatgpt" },
    -- { import = "audi.plugins.codesnap" },
    -- { import = "audi.plugins.nvim-dap" },
    -- { import = "audi.plugins.indent-blankline" },
    -- { import = "audi.plugins.noice" },
    -- { import = "audi.plugins.obsidian" },
    -- { import = "audi.plugins.prettier" },
    -- { import = "audi.plugins.rainbow-delimiters" },
    -- { import = "audi.plugins.supermaven-nvim" },
    -- { import = "audi.plugins.tailwindcss-colorizer-cmp" },
  }
}, {})
