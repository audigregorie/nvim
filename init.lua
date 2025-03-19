-- Set the runtime path to include the lua directory
vim.opt.rtp:prepend(vim.fn.stdpath("config") .. "/lua")

-- Load core settings
require('audi.settings.options')
require('audi.settings.keymaps')

-- Load plugins
require('audi.plugins.lazy.lazy')

-- Load autocmds
-- Use a small delay before loading autocmds to ensure plugins are initialized
vim.defer_fn(function()
  require('audi.settings.autocmds')
end, 10)
