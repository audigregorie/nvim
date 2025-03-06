return {
  "echasnovski/mini.indentscope",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local ok, mini_indentscope = pcall(require, "mini.indentscope")
    if not ok then
      vim.notify("Failed to load mini.indentscope", vim.log.levels.ERROR)
      return
    end

    local setup_ok, setup_err = pcall(function()
      mini_indentscope.setup({
        -- Default settings
        symbol = "│",
        options = {
          try_as_border = true,
        },
        draw = {
          animation = mini_indentscope.gen_animation.none(),
        },
      })
    end)
    if not setup_ok then
      vim.notify("Failed to setup mini.indentscope: " .. setup_err, vim.log.levels.ERROR)
      return
    end
  end,
}
