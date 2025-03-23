return {
  "rcarriga/nvim-notify",

  config = function()
    -- Safely load telescope and nvim-notify
    local telescope_ok, telescope = pcall(require, "telescope")
    if telescope_ok then
      telescope.load_extension("notify")
    else
      vim.notify("Telescope not found. Unable to load notify extension.", vim.log.levels.ERROR)
    end

    local notify_ok, notify = pcall(require, "notify")
    if not notify_ok then
      vim.notify("nvim-notify not found.", vim.log.levels.ERROR)
      return
    end

    notify.setup({
      background_colour = "#000000", -- Black background for better visibility
      fps = 30, -- Set FPS for smoother transitions
      icons = {
        DEBUG = "", -- Customize icons
        ERROR = "", -- Error icon
        INFO = "", -- Info icon
        TRACE = "✎", -- Trace icon
        WARN = "", -- Warning icon
      },
      level = vim.log.levels.INFO, -- Set default level to INFO
      minimum_width = 50,
      render = "default",
      stages = "fade_in_slide_out", -- Define animation stages
      timeout = 3000,               -- 3-second timeout
      top_down = false,             -- Display notifications from bottom up
    })

    -- Set nvim-notify as the default notification handler
    vim.notify = notify

    -- Keybinding for opening the Telescope notify
    vim.keymap.set("n", "<leader>nt", ":Telescope notify<CR>",
      { silent = true, noremap = true, desc = "Show Notifications" })

    -- Keybinding for dismissing notify messages
    vim.keymap.set("n", "<leader>nd", function() notify.dismiss({ silent = true, pending = true }) end,
      { desc = "Dismiss all Notifications" })

    -- Function to demonstrate a complex notification chain
    local function demo_complex_notification()
      local plugin = "My Awesome Plugin"
      notify("This is an error message.\nSomething went wrong!", "error", {
        title = plugin,
        on_open = function()
          notify("Attempting recovery.", vim.log.levels.WARN, { title = plugin })
          vim.defer_fn(function()
            notify({ "Fixing problem.", "Please wait..." }, "info", {
              title = plugin,
              timeout = 3000,
              on_close = function()
                notify("Problem solved", "info", { title = plugin })
                notify("Error code 0x0395AF", vim.log.levels.INFO, { title = plugin })
              end,
            })
          end, 2000)
        end,
      })
    end

    -- Command to trigger the demo
    vim.api.nvim_create_user_command("NotifyDemo", demo_complex_notification, {})
  end,
}
