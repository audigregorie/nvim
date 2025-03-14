return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    vim.schedule(function()
      -- Check if the plugin is available
      local status_ok, supermaven = pcall(require, "supermaven-nvim")
      if not status_ok then
        vim.notify("Failed to load supermaven-nvim plugin", vim.log.levels.ERROR)
        return
      end

      -- Define options
      local opts = {
        keymaps = {
          accept_suggestion = "<leader>j",
          clear_suggestion = "<C-w>",
          accept_word = "<leader>l",
          -- Alternatively, accept whole suggestion with <C-Space> (common for suggestion-related actions)
          accept_suggestion_alternative = "<C-Space>",
          -- accept_suggestion = "<C-]>",
          -- accept_suggestion = "<C-Space>",
          -- accept_word = "<C-f>",
        },
        -- Add additional configuration options as needed
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 100,
          show_suggestion_in_place = false,
        },
        --       color = {
        --         suggestion_color = "#ffffff",
        --         cterm = 244,
        --       },
        --       log_level = "info",            -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false,           -- disables built in keymaps for more manual control

      }

      -- Try to setup the plugin with the options
      local setup_ok, error = pcall(function()
        supermaven.setup(opts)
      end)

      -- Handle any errors during setup
      if not setup_ok then
        vim.notify("Error setting up supermaven-nvim: " .. tostring(error), vim.log.levels.ERROR)
      end
    end)
  end,
}

-- return {
--   config = function()
--     require("supermaven-nvim").setup({
--       keymaps = {
--         accept_suggestion = "<Tab>",
--         clear_suggestion = "<C-]>",
--         accept_word = "<C-j>",
--       },
--       ignore_filetypes = { cpp = true }, -- or { "cpp", }
--       color = {
--         suggestion_color = "#ffffff",
--         cterm = 244,
--       },
--       log_level = "info",            -- set to "off" to disable logging completely
--       disable_inline_completion = false, -- disables inline completion for use with cmp
--       disable_keymaps = false,       -- disables built in keymaps for more manual control
--       condition = function()
--         return false
--       end -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
--     })
--   end,
-- }
