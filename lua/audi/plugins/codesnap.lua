-- <> Codesnap (Code screenshot)
return {
  "mistricky/codesnap.nvim",
  lazy = true,
  build = "make",
  cmd = {
    "CodeSnap",
    "CodeSnapSave"
  },
  config = function()
    require("codesnap").setup({
      save_path = "~",
      watermark = "",
      -- bg_theme = "grape"
    })
  end,
}
