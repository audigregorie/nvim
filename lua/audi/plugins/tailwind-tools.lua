return {
  "luckasRanarison/tailwind-tools.nvim",
  name = "tailwind-tools",
  build = ":UpdateRemotePlugins",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- optional
    "neovim/nvim-lspconfig",         -- optional
  },
  config = function()
    -- Safely load tailwind-tools to avoid runtime errors
    local status, tailwind_tools = pcall(require, "tailwind-tools")
    if not status then
      vim.notify("tailwind-tools.nvim failed to load", vim.log.levels.ERROR)
      return
    end

    tailwind_tools.setup({})

    -- Keymap to toggle Tailwind Conceal
    vim.keymap.set("n", "<leader>tc", ":TailwindConcealToggle<CR>",
      { noremap = true, silent = true, desc = "Toggle Tailwind Conceal" })
  end,
}

