return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify", -- Optional: If nvim-notify is not available, Noice will use mini as fallback
  },
  config = function(_, opts)
    -- Safely load the Noice plugin
    local ok, noice = pcall(require, "noice")
    if not ok then
      vim.notify("Noice plugin not found!", vim.log.levels.ERROR)
      return
    end

    -- Configure Noice with defaults and passed options
    noice.setup(vim.tbl_deep_extend("force", {
      lsp = {
        -- Use Treesitter for markdown rendering
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- Requires nvim-cmp
        },
      },
      -- Enable presets for easier configuration
      presets = {
        bottom_search = true,         -- Classic bottom cmdline for search
        command_palette = true,       -- Position cmdline and popupmenu together
        long_message_to_split = true, -- Long messages sent to a split
        inc_rename = false,           -- Input dialog for inc-rename.nvim (if installed)
        lsp_doc_border = false,       -- Add a border to hover docs and signature help
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written", -- Suppress messages containing "written"
          },
          opts = { skip = true },
        },
      },
    }, opts or {})) -- Merge user-provided options if any
  end,
}

