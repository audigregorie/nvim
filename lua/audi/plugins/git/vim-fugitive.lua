return {
  "tpope/vim-fugitive",

  config = function()
    -- Set highlights for diff changes
    vim.api.nvim_set_hl(0, "diffAdded", { fg = "#00ff00", ctermfg = "green" }) -- Green for added lines
    vim.api.nvim_set_hl(0, "diffRemoved", { fg = "#ff0000", ctermfg = "red" }) -- Red for removed lines
  end,
}
