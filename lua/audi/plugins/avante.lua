return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- Always pull the latest version
  opts = {},
  -- Build command depending on the platform (default is `make`)
  build = vim.fn.has("win32") == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or
      "make",

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    -- Optional dependencies
    "nvim-tree/nvim-web-devicons", -- Icon support, can switch to mini.icons if needed
    {
      "zbirenbaum/copilot.lua",    -- Optional Copilot integration for providers
      opts = {
        -- Copilot-specific options here if needed
      },
    },

    {
      -- Image pasting support (Optional)
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- Recommended settings for img-clip
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = { insert_mode = true },
          -- Windows users: use absolute paths
          use_absolute_path = vim.fn.has("win32") == 1,
        },
      },
    },

    {
      -- Markdown rendering for Avante
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" }, -- Enable for markdown and Avante file types
      },
      ft = { "markdown", "Avante" },           -- Lazy load for these file types
    },
  },
}

