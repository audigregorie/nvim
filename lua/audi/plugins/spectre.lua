return {
  "nvim-pack/nvim-spectre",
  lazy = true,
  cmd = { "Spectre" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "catppuccin/nvim",
  },
  config = function()
    local ok, catppuccin = pcall(require, "catppuccin.palettes")
    if not ok then
      vim.notify("Failed to load catppuccin palette for Spectre", vim.log.levels.ERROR)
      return
    end

    local theme = catppuccin.get_palette("macchiato")

    -- Set custom highlight groups for Spectre
    vim.api.nvim_set_hl(0, "SpectreSearch", { bg = theme.red, fg = theme.base })
    vim.api.nvim_set_hl(0, "SpectreReplace", { bg = theme.green, fg = theme.base })

    require("spectre").setup({
      highlight = {
        search = "SpectreSearch",
        replace = "SpectreReplace",
      },
      mapping = {
        ["send_to_qf"] = {
          map = "<C-q>",
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "Send all items to quickfix",
        },
      },
      replace_engine = {
        sed = {
          cmd = "sed",
        },
      },
    })

    -- Keymaps for opening and using Spectre
    vim.keymap.set("n", "<leader>S", function()
      require("spectre").toggle()
    end, { desc = "Toggle Spectre", noremap = true, silent = true })

    vim.keymap.set("n", "<leader>sw", function()
      require("spectre").open_visual({ select_word = true })
    end, { desc = "Search current word", noremap = true, silent = true })
  end,
}

