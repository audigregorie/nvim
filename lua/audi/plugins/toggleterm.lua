return {
"akinsho/toggleterm.nvim",
version = "*",
config = function()
  vim.schedule(function()
    -- Check if the plugin is available
    local status_ok, toggleterm = pcall(require, "toggleterm")
    if not status_ok then
      vim.notify("Failed to load toggleterm.nvim plugin", vim.log.levels.ERROR)
      return
    end
    
    -- Define options
    local opts = {
      size = 40,
      open_mapping = [[<c-\>]], -- Toggle terminal using Ctrl + \
      hide_numbers = true,      -- Hide line numbers inside terminal buffers
      shade_filetypes = {},     -- Set which filetypes should have shading
      shade_terminals = true,   -- Apply shading to terminal windows for better visibility
      shading_factor = 2,       -- Set the degree of shading applied to terminals
      start_in_insert = true,   -- Automatically start terminals in insert mode
      insert_mappings = true,   -- Use terminal mappings in insert mode
      terminal_mappings = true, -- Use mappings in terminal mode
      persist_size = true,      -- Preserve the terminal size across sessions
      direction = "float",      -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = true,     -- Automatically close terminal when the process exits
      float_opts = {
        border = "curved",      -- 'single' | 'double' | 'shadow' | 'curved' for floating terminals
        winblend = 3,           -- Transparency level for the floating window
      },
    }
    
    -- Try to setup the plugin with the options
    local setup_ok, setup_error = pcall(function()
      toggleterm.setup(opts)
    end)
    
    -- Handle any errors during setup
    if not setup_ok then
      vim.notify("Error setting up toggleterm.nvim: " .. tostring(setup_error), vim.log.levels.ERROR)
      return
    end
    
    -- Key mappings for managing terminals
    local keymap = vim.keymap.set
    local options = { noremap = true, silent = true }
    
    -- Toggle floating terminal with <C-\>
    keymap("n", "<C-\\>", "<Cmd>ToggleTerm<CR>", options)
    
    -- Open a vertical terminal
    keymap("n", "<leader>tv", "<Cmd>ToggleTerm size=80 direction=vertical<CR>", options)
    
    -- Open a horizontal terminal
    keymap("n", "<leader>th", "<Cmd>ToggleTerm size=20 direction=horizontal<CR>", options)
    
    -- Toggle terminal in terminal mode
    keymap("t", "<C-\\>", [[<C-\><C-n><Cmd>ToggleTerm<CR>]], options)
    
    -- Check if Terminal module is available
    local term_ok, Terminal = pcall(require, "toggleterm.terminal")
    if not term_ok then
      vim.notify("Failed to load toggleterm.terminal module", vim.log.levels.ERROR)
      return
    end
    
    -- Custom function for launching lazygit inside a floating terminal
    local lazygit = Terminal.Terminal:new({ 
      cmd = "lazygit", 
      hidden = true, 
      direction = "float",
      float_opts = {
        border = "curved",
      },
      on_open = function(_)
        vim.cmd("startinsert!")
      end,
    })
    
    -- Define the lazygit toggle function
    _G.lazygit_toggle = function()
      lazygit:toggle()
    end
    
    -- Example key mapping to open lazygit in a terminal
    keymap("n", "<leader>tg", "<Cmd>lua lazygit_toggle()<CR>", options)
  end)
end,
}
