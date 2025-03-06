return {
  'windwp/nvim-ts-autotag',
  event = { "InsertEnter", "BufRead", "BufNewFile" }, -- Load only when necessary to improve startup time
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    vim.schedule(function()
      -- Check if the plugin is available
      local status_ok, autotag = pcall(require, "nvim-ts-autotag")
      if not status_ok then
        vim.notify("Failed to load nvim-ts-autotag plugin", vim.log.levels.ERROR)
        return
      end

      -- Define options
      local opts = {
        filetypes = {
          'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact',
          'tsx', 'jsx', 'xml', 'markdown', 'svelte', 'vue', 'astro', 'php'
        },
        skip_tags = {
          'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img',
          'input', 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr'
        },
      }

      -- Try to setup the plugin with the options
      local setup_ok, error = pcall(function()
        autotag.setup(opts)
      end)

      -- Handle any errors during setup
      if not setup_ok then
        vim.notify("Error setting up nvim-ts-autotag: " .. tostring(error), vim.log.levels.ERROR)
      end
    end)
  end,
}
