-- <> Rest http
return {
  "rest-nvim/rest.nvim",
  ft = "http",
  dependencies = {
    "luarocks.nvim"
  },
  config = function()
    local status, rest = pcall(require,
      "rest-nvim")
    if not status then
      vim.notify("Failed to load rest-nvim")
      return
    end

    rest.setup({})     -- Use default setup for debugging

    vim.api.nvim_set_keymap('n', '<leader>rr',
      ":Rest run<CR>",
      { noremap = true, silent = true
      })
    vim.api.nvim_set_keymap('n', '<leader>rl',
      ":Rest last<CR>",
      { noremap = true, silent = true
      })
  end,
}
