-- <> Headlines for Markdown
return {
  "lukas-reineke/headlines.nvim",
  config = function()
    vim.cmd([[highlight Headline1 guifg=#d78700 ]])
    vim.cmd([[highlight Headline2 guifg=#87afff ]])
    vim.cmd([[highlight Headline3 guifg=#d75f87 ]])
    vim.cmd([[highlight CodeBlock guibg=#202020 ]])

    require("headlines").setup({
      markdown = {
        headline_highlights = {
          "Headline1",
          "Headline2",
          "Headline3"
        },
        fat_headlines = false,
        bullets = "",
      },
    })
  end,
}
