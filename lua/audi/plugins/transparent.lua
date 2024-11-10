return {
  "xiyaowong/transparent.nvim",
  config = function()
    require("transparent").setup({
      enable = true,       -- Enable transparency
      extra_groups = {     -- Extra groups that should also be cleared
        "NormalFloat",     -- Floating windows
        "NvimTreeNormal",  -- NvimTree
        "TelescopeNormal", -- Telescope
        -- Add more groups if needed
      },
      exclude = {   -- Groups to exclude from clearing (keep them opaque)
        "NormalNC", -- Non-current windows
        -- Add more groups if needed
      },
    })
  end,
}
