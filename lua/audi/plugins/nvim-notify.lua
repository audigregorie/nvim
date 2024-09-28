-- <> Nvim notify
return {
  "rcarriga/nvim-notify",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local notify = require("notify")
    -- Set up notify
    notify.setup({
      background_colour = "#000000",
      fps = 30,
      icons = {
        DEBUG = "", -- Adjust icons as per preference
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
      level = 2,
      minimum_width = 50,
      render = "default",
      stages = "fade_in_slide_out",
      timeout = 3000,
      top_down = false,
    })
    -- Set notify as the default notification handler
    vim.notify = notify

    -- Function to demonstrate the complex notification chain
    local function demo_complex_notification()
      local plugin = "My Awesome Plugin"
      notify("This is an error message.\nSomething went wrong!", "error", {
        title = plugin,
        on_open = function()
          notify("Attempting recovery.", vim.log.levels.WARN, {
            title = plugin,
          })
          vim.defer_fn(function()
            notify({ "Fixing problem.", "Please wait..." }, "info", {
              title = plugin,
              timeout = 3000,
              on_close = function()
                notify("Problem solved", nil, { title = plugin })
                notify("Error code 0x0395AF", vim.log.levels.INFO, { title = plugin })
              end,
            })
          end, 2000)
        end,
      })
    end

    -- Command to trigger the demo
    vim.api.nvim_create_user_command("NotifyDemo", demo_complex_notification, {})

    -- Key mapping to dismiss all notifications
    vim.keymap.set("n", "<leader>nd", function()
      require("notify").dismiss({ silent = true, pending = true })
    end, { desc = "Dismiss all Notifications" })
  end,
}
