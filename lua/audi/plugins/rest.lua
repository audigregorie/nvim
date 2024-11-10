return {
  'rest-nvim/rest.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    rocks = {
      hererocks = true, -- Enable hererocks
    },
  },
  config = function()
    -- Ensure rest-nvim is loaded
    local ok = pcall(require, "rest-nvim")
    if not ok then
      vim.notify("rest-nvim failed to load", vim.log.levels.ERROR)
      return
    end

    -- Move global options to vim.g.rest_nvim
    vim.g.rest_nvim = {
      result_split_horizontal = false, -- Open results in a vertical split
      result_split_in_place = false,   -- Keeps the focus on the HTTP file
      skip_ssl_verification = false,   -- Enable SSL verification for secure requests
      encode_url = true,               -- Automatically encode URLs

      highlight = {
        enabled = true, -- Enables highlighting
        timeout = 150,  -- Duration of the highlight
      },

      result = {
        show_headers = true,       -- Display response headers
        show_http_info = true,     -- Show HTTP request/response details
        show_curl_command = false, -- Hide curl commands unless debugging
      },

      jump_to_request = false, -- Keep the cursor in place
    }

    -- Initialize rest-nvim
    -- vim.g.rest_nvim.setup()

    -- Keybindings for Better Workflow
    vim.api.nvim_set_keymap('n', '<leader>rr', '<cmd>lua require("rest-nvim").run()<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>rp', '<cmd>lua require("rest-nvim").run(true)<CR>',
      { noremap = true, silent = true }) -- Preview request
    vim.api.nvim_set_keymap('n', '<leader>rl', '<cmd>lua require("rest-nvim").last()<CR>',
      { noremap = true, silent = true }) -- Re-run last request

    -- Auto-enable Relative Line Numbers in Results
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "rest_nvim_results",
      callback = function()
        vim.wo.relativenumber = true
      end,
    })
  end,
}
