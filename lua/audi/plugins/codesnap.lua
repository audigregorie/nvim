return {
  "mistricky/codesnap.nvim",
  lazy = true,      -- Load the plugin lazily
  build = "make",   -- Ensure any necessary build steps are completed
  cmd = {
    "CodeSnap",     -- Command to capture code screenshot
    "CodeSnapSave", -- Command to capture and save the screenshot
  },

  config = function()
    -- Safely load the codesnap plugin to avoid runtime errors
    local ok, codesnap = pcall(require, "codesnap")
    if not ok then
      vim.notify("Codesnap plugin not found!", vim.log.levels.ERROR)
      return
    end

    codesnap.setup({
      save_path = "~", -- Default save path for screenshots
      watermark = "",  -- Optional watermark (leave empty if not needed)
      -- bg_theme = "grape", -- Uncomment and customize the background theme
    })
  end,
}

