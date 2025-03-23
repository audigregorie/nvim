return {
  "vhyrro/luarocks.nvim",
  priority = 1000,
  config = function(_, opts)
    local ok, luarocks = pcall(require, "luarocks")
    if not ok then
      vim.notify("Failed to load luarocks.nvim", vim.log.levels.ERROR)
      return
    end

    local setup_ok, setup_err = pcall(function()
      luarocks.setup(opts or {
        rocks = {
          enabled = true,
          hererocks = true, -- Enable hererocks to use Lua 5.1
          "lua-curl",       -- For HTTP requests
          "nvim-nio",       -- Async I/O
          "mimetypes",      -- For handling file types
          "xml2lua",        -- XML parsing in Lua
        }
      })
    end)
    if not setup_ok then
      vim.notify("Failed to setup luarocks.nvim: " .. setup_err, vim.log.levels.ERROR)
      return
    end
  end,
}
