return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
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
  },

  config = function(_, opts)
    require("toggleterm").setup(opts)

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

    -- Example key mapping to open lazygit in a terminal
    keymap("n", "<leader>tg", "<Cmd>lua _lazygit_toggle()<CR>", options)

    -- Custom function for launching lazygit inside a floating terminal
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

    function _lazygit_toggle()
      lazygit:toggle()
    end
  end,
}

