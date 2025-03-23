-- Mason for managing LSP servers, formatters, and linters
-- The base for package management
return {
  "williamboman/mason.nvim",
  config = function()
    local ok, mason = pcall(require, "mason")
    if not ok then
      vim.notify("Failed to load mason.nvim: " .. tostring(mason), vim.log.levels.ERROR)
      return
    end

    local setup_ok, setup_err = pcall(function()
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          },
          border = "rounded",
          width = 0.8,
          height = 0.8,
        },
        max_concurrent_installers = 4,
        registries = {
          "github:mason-org/mason-registry",
        },
        providers = {
          "mason.providers.registry-api",
          "mason.providers.client",
        },
        log_level = vim.log.levels.INFO,
      })
    end)

    if not setup_ok then
      vim.notify("Failed to setup mason.nvim: " .. tostring(setup_err), vim.log.levels.ERROR)
      return
    end

    -- Optional: Add keymaps for Mason
    local keymap_ok, keymap_err = pcall(function()
      local default_opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>pm", ":Mason<CR>",
        vim.tbl_extend("force", default_opts, { desc = "Open Mason" }))
    end)

    if not keymap_ok then
      vim.notify("Failed to setup mason.nvim keymaps: " .. tostring(keymap_err), vim.log.levels.WARN)
    end
  end,
}
