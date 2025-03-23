return {
  "karb94/neoscroll.nvim",
  config = function()
    local ok, neoscroll = pcall(require, "neoscroll")
    if not ok then
      vim.notify("Failed to load neoscroll.nvim: " .. tostring(neoscroll), vim.log.levels.ERROR)
      return
    end

    local setup_ok, setup_err = pcall(function()
      neoscroll.setup({
        mappings = {
          '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb'
        },
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing_function = "cubic",
        pre_hook = nil,
        post_hook = nil,
      })
    end)

    if not setup_ok then
      vim.notify("Failed to setup neoscroll.nvim: " .. tostring(setup_err), vim.log.levels.ERROR)
      return
    end
  end
}
