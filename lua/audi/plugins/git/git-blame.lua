return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  opts = {
    enabled = true,
    message_template = " <author> • <date> • <summary> ",
    -- message_template = " <author> • <date> • <<sha>>/<summary> ",
    -- message_template = " <summary> • <date> • <author> • <<sha>>",
    date_format = "%m-%d-%Y",
    -- date_format = "%m-%d-%Y %H:%M:%S",
    virtual_text_column = 1,
    -- Add highlight group configuration for soft gray text
    highlight_group = "GitBlameVirtualText", -- Define a custom highlight group name
  },
  config = function(_, opts)
    require("gitblame").setup(opts)
    -- Set the highlight color to a soft gray
    vim.api.nvim_set_hl(0, "GitBlameVirtualText", { fg = "#333334" })
    -- For an even softer gray, you could use something like "#AAAAAA"
  end,
}
