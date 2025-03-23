return {
"alexghergh/nvim-tmux-navigation",
config = function()
  vim.schedule(function()
    -- Check if the plugin is available
    local status_ok, tmux_nav = pcall(require, "nvim-tmux-navigation")
    if not status_ok then
      vim.notify("Failed to load nvim-tmux-navigation plugin", vim.log.levels.ERROR)
      return
    end
    
    -- Define options
    local opts = {
      disable_when_zoomed = true, -- Disable navigation when tmux is zoomed
      keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        last_active = "<C-\\>",
        next = "<C-Space>",
      },
    }
    
    -- Try to setup the plugin with the options
    local setup_ok, error = pcall(function()
      tmux_nav.setup(opts)
    end)
    
    -- Handle any errors during setup
    if not setup_ok then
      vim.notify("Error setting up nvim-tmux-navigation: " .. tostring(error), vim.log.levels.ERROR)
    end
  end)
end,
}
