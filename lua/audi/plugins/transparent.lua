return {
  "xiyaowong/transparent.nvim",
  lazy = true,      -- Load only when needed for better startup performance
  event = "VimEnter", -- Load after Vim UI has initialized
  config = function()
    local status_ok, transparent = pcall(require, "transparent")
    if not status_ok then
      vim.notify("transparent.nvim not found!", vim.log.levels.ERROR)
      return
    end

    -- Default configuration
    local config = {
      enable = true,
      extra_groups = {
        -- UI components
        "NormalFloat",
        "FloatBorder",
        "NvimTreeNormal",
        "NvimTreeNormalNC",
        "NvimTreeEndOfBuffer",

        -- Telescope
        "TelescopeNormal",
        "TelescopeBorder",
        "TelescopePrompt",
        "TelescopeResults",
        "TelescopePreview",

        -- LSP UI
        "LspFloatWinNormal",
        "LspFloatWinBorder",

        -- CMP (completion)
        "CmpDocumentation",
        "CmpDocumentationBorder",

        -- Diagnostics
        "DiagnosticFloatingError",
        "DiagnosticFloatingWarn",
        "DiagnosticFloatingInfo",
        "DiagnosticFloatingHint",
      },
      exclude = {
        "NormalNC",
        "StatusLine",
        "StatusLineNC",
        "CursorLine",
        "TabLineFill",
        "WinSeparator",
      },
      -- Optimize performance by ignoring specific filetypes
      exclude_filetypes = {
        "dashboard",
        "lazy",
        "mason",
        "notify",
      },
    }

    -- Performance tuning
    vim.g.transparent_debounce_time = 50 -- Reduce debounce time for faster updates

    -- Safe setup with error handling
    local setup_ok, err = pcall(function()
      transparent.setup(config)
    end)

    if not setup_ok then
      vim.notify("Error setting up transparent.nvim: " .. (err or "unknown error"), vim.log.levels.ERROR)
      return
    end

    -- Create user commands for toggling transparency
    vim.api.nvim_create_user_command("TransparencyEnable", function()
      pcall(transparent.enable, true)
    end, { desc = "Enable transparency" })

    vim.api.nvim_create_user_command("TransparencyDisable", function()
      pcall(transparent.enable, false)
    end, { desc = "Disable transparency" })

    vim.api.nvim_create_user_command("TransparencyToggle", function()
      pcall(transparent.toggle)
    end, { desc = "Toggle transparency" })
  end,
  -- Disable on specific systems where transparency might cause issues
  cond = function()
    -- Skip on certain terminals or OS configurations
    local skip_on = {
      remote_sessions = vim.env.SSH_CLIENT ~= nil,
      tty = (vim.env.TERM or ""):match("linux"),
    }

    -- Return false to skip loading on problematic setups
    return not (skip_on.remote_sessions or skip_on.tty)
  end,
}
