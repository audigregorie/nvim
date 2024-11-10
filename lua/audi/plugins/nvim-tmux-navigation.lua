return {
  "alexghergh/nvim-tmux-navigation",
  config = function(_, opts)
    -- Safely load the plugin to avoid runtime errors
    local ok, tmux_nav = pcall(require, "nvim-tmux-navigation")
    if not ok then
      vim.notify("nvim-tmux-navigation plugin not found!", vim.log.levels.ERROR)
      return
    end

    -- Setup the plugin with default or user-defined options
    tmux_nav.setup(vim.tbl_deep_extend("force", {
      disable_when_zoomed = true, -- Disable navigation when tmux is zoomed
    }, opts or {}))
  end,
}

