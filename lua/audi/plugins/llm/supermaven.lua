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
          -- Accept the suggestion using <C-l> (often used for completion-related actions in Vim)
          -- accept_suggestion = "<C-]>",
          -- Clear suggestion with <C-e> (mimics clearing something or aborting a change in insert mode)
          -- clear_suggestion = "<C-w>",
          -- Accept the word suggestion with <C-f> (often used to move forward)
          -- accept_word = "<C-f>",
          -- Alternatively, accept whole suggestion with <C-Space> (common for suggestion-related actions)
          -- accept_suggestion_alternative = "<C-Space>",
        },
        -- Add additional configuration options as needed
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 100,
          show_suggestion_in_place = false,
        },
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
