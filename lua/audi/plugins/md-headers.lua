return {
  -- View markdown headers
  "AntonVanAssche/md-headers.nvim",
  version = "*",
  lazy = false,                        -- Load the plugin immediately
  dependencies = {
    "nvim-lua/plenary.nvim",           -- Required by md-headers
    "nvim-treesitter/nvim-treesitter", -- Syntax parsing support
    "plasticboy/vim-markdown",         -- Markdown syntax highlighting
  },
  config = function()
    -- Safely load md-headers to avoid runtime errors
    local ok, md_headers = pcall(require, "md-headers")
    if not ok then
      vim.notify("md-headers plugin not found!", vim.log.levels.ERROR)
      return
    end

    -- Setup md-headers with custom options
    md_headers.setup({
      width = 90,
      height = 30,
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      popup_auto_close = true,
    })

    -- Define keymap for opening Markdown headers
    vim.keymap.set(
      "n",
      "<leader>mh",
      "<cmd>MarkdownHeaders<CR>",
      { noremap = true, silent = true, desc = "View Markdown Headers" }
    )

    -- Ensure compatibility with vim-markdown
    vim.g.vim_markdown_folding_disabled = 1 -- Disable folding if conflicts arise
    vim.g.vim_markdown_conceal = 0          -- Disable conceal if MarkdownHeaders needs clear visibility
    vim.g.vim_markdown_frontmatter = 1      -- Enable YAML frontmatter for better parsing
  end,
}

