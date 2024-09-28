-- <> Typescript Error Translator
return {
  'dmmulroy/ts-error-translator.nvim',
  config = function()
    require("ts-error-translator").setup()
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" } -- Load plugin only for TypeScript/JS files
}
