return {
  "zbirenbaum/copilot.lua",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 50,
        trigger_on_accept = true,
        keymap = {
          accept = "<Tab>",
          accept_word = "<leader>j",
          accept_line = "<leader>l",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
    })
  end,
}
