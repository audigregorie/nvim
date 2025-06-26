return {
  "mbbill/undotree",
  lazy = true,
  cmd = "UndotreeToggle",
  keys = {
    { "<leader>ut", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" },
  },
  config = function()
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_DiffpanelHeight = 10
    vim.g.undotree_SplitWidth = 40
    vim.g.undotree_HighlightSyntaxAdd = "DiffAdd"
    vim.g.undotree_HighlightSyntaxChange = "DiffChange"
    vim.g.undotree_HighlightSyntaxDel = "DiffDelete"

    -- Additional keymaps for navigating while in undotree
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "undotree",
      callback = function()
        vim.keymap.set("n", "J", "5j", { buffer = true, noremap = true, silent = true })
        vim.keymap.set("n", "K", "5k", { buffer = true, noremap = true, silent = true })
      end,
    })
  end,
}
