return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  cmd = { "Harpoon" },
  config = function()
    local harpoon = require("harpoon")
    local list = harpoon:list()

    harpoon:setup()
    require("telescope").load_extension("harpoon")

    -- Harpoon core actions
    vim.keymap.set("n", "<leader>ha", function()
      list:add()
    end, { desc = "Add file to Harpoon" })
    vim.keymap.set("n", "<leader>ho", function()
      harpoon.ui:toggle_quick_menu(list)
    end, { desc = "Toggle Harpoon quick menu" })
    vim.keymap.set("n", "<leader>hd", function()
      list:remove()
    end, { desc = "Remove current file from Harpoon" })

    -- Navigation
    for i = 1, 6 do
      vim.keymap.set("n", "<leader>" .. i, function()
        list:select(i)
      end, { desc = "Go to Harpoon file " .. i })
    end

    vim.keymap.set("n", "<leader>hn", function()
      list:next()
    end, { desc = "Next Harpoon file" })
    vim.keymap.set("n", "<leader>hp", function()
      list:prev()
    end, { desc = "Previous Harpoon file" })

    -- Telescope integration
    vim.keymap.set("n", "<leader>hf", function()
      require("telescope").extensions.harpoon.marks()
    end, { desc = "Find Harpoon mark with Telescope" })
  end,
}
