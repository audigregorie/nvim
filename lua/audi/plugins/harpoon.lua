return {
  "ThePrimeagen/harpoon",
  lazy = true,
  event = "BufReadPost", -- Load when a buffer is read
  config = function()
    -- Safely load harpoon to avoid runtime errors
    local ok_ui, harpoon_ui = pcall(require, "harpoon.ui")
    local ok_mark, harpoon_mark = pcall(require, "harpoon.mark")

    if not ok_ui or not ok_mark then
      vim.notify("Harpoon plugin not found!", vim.log.levels.ERROR)
      return
    end

    require('harpoon').setup({})

    -- Open harpoon UI
    vim.keymap.set("n", "<leader>ho", function()
      harpoon_ui.toggle_quick_menu()
      vim.notify("Harpoon UI opened", vim.log.levels.INFO)
    end, { noremap = true, silent = true, desc = "[H]arpoon [O]pen UI" })

    -- Add current file to harpoon
    vim.keymap.set("n", "<leader>ha", function()
      harpoon_mark.add_file()
      vim.notify("File added to Harpoon", vim.log.levels.INFO)
    end, { noremap = true, silent = true, desc = "[H]arpoon [A]dd file" })

    -- Remove current file from harpoon
    vim.keymap.set("n", "<leader>hr", function()
      harpoon_mark.rm_file()
      vim.notify("File removed from Harpoon", vim.log.levels.INFO)
    end, { noremap = true, silent = true, desc = "[H]arpoon [R]emove file" })

    -- Clear all files from harpoon
    vim.keymap.set("n", "<leader>hc", function()
      harpoon_mark.clear_all()
      vim.notify("All files cleared from Harpoon", vim.log.levels.INFO)
    end, { noremap = true, silent = true, desc = "[H]arpoon [C]lear all files" })

    -- Quickly jump to harpooned files
    for i = 1, 4 do
      vim.keymap.set("n", "<leader>h" .. i, function()
        harpoon_ui.nav_file(i)
      end, { noremap = true, silent = true, desc = "[H]arpoon go to file " .. i })
    end
  end,
}
