return {
  "windwp/nvim-autopairs",
  config = function()
    local ok, autopairs = pcall(require, "nvim-autopairs")
    if not ok then
      vim.notify("Failed to load nvim-autopairs: " .. tostring(autopairs), vim.log.levels.ERROR)
      return
    end

    local setup_ok, setup_err = pcall(function()
      autopairs.setup({
        disable_filetype = { "TelescopePrompt", "vim" },
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
        },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })
    end)

    if not setup_ok then
      vim.notify("Failed to setup nvim-autopairs: " .. tostring(setup_err), vim.log.levels.ERROR)
      return
    end

    -- Optional: Integration with treesitter if available
    local ts_ok, _ = pcall(require, "nvim-treesitter.configs")
    if ts_ok then
      local cmp_ok, cmp = pcall(require, "cmp")
      if cmp_ok then
        local cmp_autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
        if cmp_autopairs_ok then
          local cmp_setup_ok, cmp_setup_err = pcall(function()
            cmp.event:on(
              'confirm_done',
              cmp_autopairs.on_confirm_done()
            )
          end)
          if not cmp_setup_ok then
            vim.notify("Failed to setup nvim-autopairs cmp integration: " .. tostring(cmp_setup_err), vim.log.levels
              .WARN)
          end
        else
          vim.notify("nvim-cmp is available but autopairs completion module could not be loaded", vim.log.levels.INFO)
        end
      end
    end
  end,
}
