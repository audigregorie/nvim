return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency

  config = function()
    local diffview_ok, diffview = pcall(require, "diffview")
    if not diffview_ok then
      vim.notify("diffview not found!", vim.log.levels.ERROR)
      return
    end

    -- Basic configuration
    diffview.setup({
      enhanced_diff_hl = true, -- Highlight differences with better colorization
      use_icons = true,        -- Use file-type icons (requires nvim-web-devicons)
      signs = {
        fold_closed = "",
        fold_open = "",
      },
    })

    -- Optional keybindings for Diffview
    local keymap_opts = { noremap = true, silent = true, desc = "Diffview" }
    vim.keymap.set("n", "<leader>dv", ":DiffviewOpen<CR>", keymap_opts)        -- Open Diffview
    vim.keymap.set("n", "<leader>dx", ":DiffviewClose<CR>", keymap_opts)       -- Close Diffview
    vim.keymap.set("n", "<leader>dh", ":DiffviewFileHistory<CR>", keymap_opts) -- View file history
  end,
}
