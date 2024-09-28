-- Set the runtime path to include the lua directory
vim.opt.rtp:prepend(vim.fn.stdpath("config") .. "/lua")

-- Load core settings
require('audi.settings.options')
require('audi.settings.keymaps')
require('audi.settings.autocmds')

-- Load plugins
require('audi.plugins.lazy.lazy')
