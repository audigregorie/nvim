return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-\\>"] = "actions.select_split",
      ["<C-enter>"] = "actions.select_vsplit", -- Used to navigate left
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-r>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
    },
    view_options = {
      show_hidden = true,
      natural_order = true,
    },
    lsp_file_methods = {
      autosave_changes = true,
    },
  },
  config = function(_, opts)
    require("oil").setup(opts)

    -- Toggle oil with <leader>e
    vim.keymap.set("n", "<leader>e", function()
      require("oil").toggle_float()
    end, { noremap = true, silent = true, desc = "Toggle Oil Explorer" })

    -- Auto-command to set color column for oil buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function()
        vim.opt_local.colorcolumn = "" -- Disable color column in oil buffers
      end,
    })

    -- Set background for floating windows used by oil.nvim
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0A0F14" })
  end,
}

