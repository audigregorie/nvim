return {
  'rest-nvim/rest.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    vim.schedule(function()
      -- Check if the plugin is available
      local status_ok, _ = pcall(require, "rest-nvim")
      if not status_ok then
        vim.notify("Failed to load rest-nvim plugin", vim.log.levels.ERROR)
        return
      end

      -- Configure rest.nvim using the recommended vim.g.rest_nvim approach
      vim.g.rest_nvim = {
        -- Client configuration
        client = {
          skip_ssl_verification = false, -- Enable SSL verification for secure requests
          encode_url = true,             -- Automatically encode URLs
          logs = {
            save = true,                 -- Save logs to file
            save_path = vim.fn.stdpath("cache") .. "/rest_nvim_logs.json"
          }
        },

        -- Result display settings
        result = {
          split = {
            horizontal = false, -- Open results in a vertical split
            in_place = false,   -- Keeps the focus on the HTTP file
          },
          behavior = {
            decode_url = true,         -- Decode URLs in the results for readability
            show_headers = true,       -- Display response headers
            show_http_info = true,     -- Show HTTP request/response details
            show_curl_command = false, -- Hide curl commands unless debugging
            show_statistics = true,    -- Show response time statistics
          },
          formatters = {
            json = "jq", -- Use jq for JSON formatting if available
            html = function(body)
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end,
          },
        },

        -- Highlighting settings
        highlight = {
          enabled = true, -- Enables highlighting
          timeout = 150,  -- Duration of the highlight in ms
        },

        -- Jump settings
        jump_to_request = false, -- Keep the cursor in place

        -- Environment variables
        env_file = '.env',

        -- Lua rocks options
        rocks = {
          hererocks = true, -- Enable hererocks
        },
      }

      -- Keybindings for Better Workflow
      local keymap_opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>rr', '<Cmd>lua require("rest-nvim").run()<CR>', keymap_opts)
      vim.keymap.set('n', '<leader>rp', '<Cmd>lua require("rest-nvim").run(true)<CR>', keymap_opts) -- Preview request
      vim.keymap.set('n', '<leader>rl', '<Cmd>lua require("rest-nvim").last()<CR>', keymap_opts)    -- Re-run last request

      -- Auto-enable Relative Line Numbers in Results
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "httpResult",
        callback = function()
          vim.wo.relativenumber = true
        end,
      })
    end)
  end,
}
