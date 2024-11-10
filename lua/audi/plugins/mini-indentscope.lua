return {
  "echasnovski/mini.indentscope",
  event = "BufEnter", -- Load when entering a buffer
  opts = {
    symbol = "│", -- Character used for indentation guide
    options = { try_as_border = true },
  },

  init = function()
    -- Safely load the Catppuccin palette for theming
    local ok, catppuccin = pcall(require, "catppuccin.palettes")
    if not ok then
      vim.notify("Catppuccin palette not found!", vim.log.levels.ERROR)
      return
    end

    -- Get the color palette for 'macchiato' flavor
    local macchiato = catppuccin.get_palette("macchiato")

    -- Disable MiniIndentscope for certain filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "help", "lazy", "mason", "notify", "oil", "Oil" },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })

    -- Set custom highlight for MiniIndentscopeSymbol
    vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = macchiato.mauve })
  end,
}

