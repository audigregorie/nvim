return {
  "vhyrro/luarocks.nvim",
  priority = 1000,
  config = true,
  opts = {
    rocks = {
      enabled = true,
      hererocks = true, -- Enable hererocks to use Lua 5.1

      "lua-curl",       -- For HTTP requests
      "nvim-nio",       -- Async I/O
      "mimetypes",      -- For handling file types
      "xml2lua",        -- XML parsing in Lua
    }
  },
}
