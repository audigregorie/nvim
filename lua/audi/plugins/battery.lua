return {
  "justinhj/battery.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim", -- Required for async operations
  },

  config = function()
    -- Safely load the battery plugin
    local ok, battery = pcall(require, "battery")
    if not ok then
      vim.notify("battery.nvim not found", vim.log.levels.ERROR)
      return
    end

    battery.setup({})
  end,
}

