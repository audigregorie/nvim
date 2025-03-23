return {
  "folke/trouble.nvim",
  lazy = true,                                      -- Improve startup performance with lazy loading
  cmd = "Trouble",                                  -- Load only when the Trouble command is used
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Ensure icons are available

  config = function()
    -- Safe require
    local status_ok, trouble = pcall(require, "trouble")
    if not status_ok then
      vim.notify("trouble.nvim not found! Please make sure it's installed.", vim.log.levels.ERROR)
      return
    end


    -- Safe setup
    local setup_ok, err = pcall(function()
      trouble.setup()
    end)

    if not setup_ok then
      vim.notify("Error setting up trouble.nvim: " .. (err or "unknown error"), vim.log.levels.ERROR)
      return
    end
  end,

  -- Key mappings
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
    -- Additional useful keybindings
    { "gR",         "<cmd>Trouble lsp_references<cr>",                            desc = "LSP References (Trouble)" },
    { "gD",         "<cmd>Trouble lsp_definitions<cr>",                           desc = "LSP Definitions (Trouble)" },
    { "gI",         "<cmd>Trouble lsp_implementations<cr>",                       desc = "LSP Implementations (Trouble)" },
    { "gt",         "<cmd>Trouble lsp_type_definitions<cr>",                      desc = "LSP Type Definitions (Trouble)" },
  },
}
