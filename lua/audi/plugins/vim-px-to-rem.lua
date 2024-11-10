return {
  -- Plugin to convert between px and rem units
  "Oldenborg/vim-px-to-rem",

  config = function()
    -- Key mappings for converting units
    -- Converts px to rem
    vim.api.nvim_set_keymap("n", "<leader>pr", ":Rem<CR>", { noremap = true, silent = true, desc = "Convert px to rem" })

    -- Converts rem to px
    vim.api.nvim_set_keymap("n", "<leader>rp", ":Px<CR>", { noremap = true, silent = true, desc = "Convert rem to px" })
  end,

  -- Usage:
  -- :Rem - Converts px values in a line to rem
  -- :Px  - Converts rem values in a line to px
}

