-- <> Harpoon
return {
  "ThePrimeagen/harpoon",
  lazy = true,
  config = function()
    local harpoon_ui = require("harpoon.ui")
    local harpoon_mark = require("harpoon.mark")

    -- Open harpoon ui
    vim.keymap.set("n", "<leader>ho", function() harpoon_ui.toggle_quick_menu() end, { noremap = true, silent = true })

    -- Add current file to harpoon
    vim.keymap.set("n", "<leader>ha", function() harpoon_mark.add_file() end,
      { desc = "[H]arpoon [A]dd", noremap = true, silent = true })

    -- Remove current file from harpoon
    vim.keymap.set("n", "<leader>hr", function() harpoon_mark.rm_file() end, { noremap = true, silent = true })

    -- Clear all files from harpoon
    vim.keymap.set("n", "<leader>hc", function() harpoon_mark.clear_all() end,
      { desc = "[H]arpoon [C]lear", noremap = true, silent = true })

    -- Quickly jump to harpooned files
    vim.keymap.set("n", "<leader>1", function() harpoon_ui.nav_file(1) end, { noremap = true, silent = true })

    vim.keymap.set("n", "<leader>2", function() harpoon_ui.nav_file(2) end, { noremap = true, silent = true })

    vim.keymap.set("n", "<leader>3", function() harpoon_ui.nav_file(3) end, { noremap = true, silent = true })

    vim.keymap.set("n", "<leader>4", function() harpoon_ui.nav_file(4) end, { noremap = true, silent = true })
  end,
}
