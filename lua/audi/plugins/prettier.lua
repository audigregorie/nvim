-- <> Prettier (use neovim prettier instead of .prettierrc in project)
return {
  "MunifTanjim/prettier.nvim",
  config = function()
    require("prettier").setup({
      bin = 'prettier',     -- Use global Prettier installation
      filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        -- "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
      },
      cli_options = {
        arrow_parens = "always",
        bracket_spacing = true,
        bracket_same_line = true,
        embedded_language_formatting = "auto",
        end_of_line = "lf",
        html_whitespace_sensitivity = "css",
        -- jsx_bracket_same_line = false,
        jsx_single_quote = false,
        print_width = 160,
        prose_wrap = "preserve",
        quote_props = "as-needed",
        semi = true,
        single_attribute_per_line = true,
        single_quote = true,
        tab_width = 2,
        trailing_comma = "none",
        use_tabs = false,
        vue_indent_script_and_style = false,
      },
    })
  end,
}
