return {
  "tpope/vim-surround",
  event = { "BufReadPost", "BufNewFile" }, -- Lazy load on buffer operations
  keys = {
    { "ys", mode = "n", desc = "Add surrounding" },
    { "cs", mode = "n", desc = "Change surrounding" },
    { "ds", mode = "n", desc = "Delete surrounding" },
    { "S",  mode = "v", desc = "Surround visual selection" },
  },

  --[[
  # Vim-Surround Keymaps

  ## Normal Mode
  - `ysw'`   : Surround a word with single quotes
  - `ys3w{`  : Surround 3 words with { Hello World }
  - `ysiw"`  : Surround inner word with double quotes
  - `ysiw{`  : Surround inner word with { and space
  - `ysiw}`  : Surround inner word with } (no space)
  - `yss(`   : Surround entire line with ( )
  - `yss)`   : Surround entire line with () (no space)

  ## Change/Delete Surroundings
  - `cs"'`   : Change surrounding " to '
  - `cs({`   : Change surrounding ( to {
  - `ds"`    : Delete surrounding "

  ## Visual Mode
  - Select text + `S"` : Surround selection with "

  ## Common Use Cases
  - `ysiw<em>` : Wrap word with <em></em> tags
  - `dst`      : Delete surrounding HTML tags
  - `cs'"` + `cs")` + `ds)` : Chain operations

  ## React/JSX Workflow
  - `ysiw<C-}>` : Surround with {} (for JSX expressions)
  - `vS<div>` : Surround visual selection with <div></div>
  ]]
}
