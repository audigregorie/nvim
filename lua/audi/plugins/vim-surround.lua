return {
  "tpope/vim-surround",
  -- Keymaps :
  -- [ ysw' ]  Surround a word with single quotes
  -- [ ys3w{ ]  Surround 3 word with { Hello-World }
  -- [ ds" ]  Delete surrounding double quotes "
  -- [ cs"' ]  Change surrounding double quotes " to single quotes '
  -- [ cs"' ]  "Hello" -> 'Hello'
  -- [ ds" ]  "Hello" -> Hello
  -- [ ysiw' ]  Hello -> 'Hello'
  -- [ ysiw{ ]  Hello -> { Hello } World
  -- [ yss( ]  Hello World -> ( Hello World )
  -- [ ysiw } ]  Hello -> {Hello } World
  -- [ yss) ]  Hello World -> (Hello World)
  -- [ vfec{} + Esc p ]  props.name -> {} -> {props.name }
}
