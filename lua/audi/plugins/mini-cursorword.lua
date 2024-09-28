-- <> Mini Cursorword
return {
  "echasnovski/mini.cursorword",
  lazy = true,
  event = "CursorMoved",
  config = function()
    require("mini.cursorword").setup()
  end,
}
