return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    -- Safely load the supermaven-nvim plugin to avoid runtime errors
    local status, supermaven = pcall(require, "supermaven-nvim")
    if not status then
      vim.notify("Failed to load supermaven-nvim", vim.log.levels.ERROR)
      return
    end

    -- Set up the supermaven-nvim plugin with keymap options
    supermaven.setup({
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
    })
  end,
}

