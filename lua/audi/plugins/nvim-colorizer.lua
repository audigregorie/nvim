-- <> Colorizer
return {
  "NvChad/nvim-colorizer.lua",
  opts = {
    user_default_options = {
      -- tailwind = true,
      -- mode = "foreground",
      -- mode = "background",
      mode = "virtualtext",
      filetypes = {
        "!jsx",  -- Exclude JSX
        "!html", -- Exclude HTML
      }
    },
  },
}