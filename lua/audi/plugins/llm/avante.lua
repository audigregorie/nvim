return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    -- add any opts here
    -- for example
    -- provider = "openai",
    -- openai = {
    --   -- endpoint = "https://api.openai.com/v1",
    --   model = "gpt-4o-mini", -- your desired model (or use gpt-4o, etc.)
    --   timeout = 30000,       -- timeout in milliseconds
    --   temperature = 0,       -- adjust if needed
    --   max_tokens = 4096,
    -- },
    provider = "claude",
    auto_suggestions_provider = "claude",
    claude = {
      endpoint = "https://api.anthropic.com",
      -- model = "claude-3-5-sonnet-20241022",
      model = "claude-3-7-sonnet-20250219",
      temperature = 0,
      max_tokens = 4096,
    },
    windows = {
      position = "right",
      width = 50,
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick",         -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua",              -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",        -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },

    vim.keymap.set('n', '<Leader>ac', '<cmd>AvanteAskClear<CR>', { desc = 'Clear Avante ask window' })
  },

  -- Leaderaa	show sidebar
  -- Leaderat	toggle sidebar visibility
  -- Leaderar	refresh sidebar
  -- Leaderaf	switch sidebar focus
  -- Leadera?	select model
  -- Leaderae	edit selected blocks
  -- co	choose ours
  -- ct	choose theirs
  -- ca	choose all theirs
  -- c0	choose none
  -- cb	choose both
  -- cc	choose cursor
  -- ]x	move to previous conflict
  -- [x	move to next conflict
  -- [[	jump to previous codeblocks (results window)
  -- ]]	jump to next codeblocks (results windows)
}
