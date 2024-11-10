return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',            -- Optional UI for DAP
    'theHamsta/nvim-dap-virtual-text', -- Optional virtual text for variables
  },

  config = function()
    -- Safely load necessary modules
    local dap_ok, dap = pcall(require, 'dap')
    if not dap_ok then
      vim.notify("nvim-dap not found!", vim.log.levels.ERROR)
      return
    end

    local dapui_ok, dapui = pcall(require, 'dapui')
    if not dapui_ok then
      vim.notify("nvim-dap-ui not found!", vim.log.levels.ERROR)
      return
    end

    local dap_virtual_text_ok, dap_virtual_text = pcall(require, 'nvim-dap-virtual-text')
    if not dap_virtual_text_ok then
      vim.notify("nvim-dap-virtual-text not found!", vim.log.levels.ERROR)
      return
    end

    -- Configure the node adapter
    dap.adapters.node2 = {
      type = 'executable',
      command = 'node',
      args = { os.getenv('HOME') .. '/.config/nvim/debuggers/vscode-node-debug2/out/src/nodeDebug.js' },
    }

    -- Configuration for debugging JavaScript and TypeScript files
    dap.configurations.javascript = {
      {
        type = 'node2',
        request = 'launch',
        name = 'Launch file',
        program = '${file}', -- Debug the currently open file
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
      },
      {
        type = 'node2',
        request = 'attach',
        name = 'Attach to process',
        processId = require('dap.utils').pick_process,
        cwd = vim.fn.getcwd(),
      },
    }

    -- Chrome adapter for debugging JavaScript React and TypeScript React
    dap.adapters.chrome = {
      type = 'executable',
      command = 'node',
      args = { os.getenv('HOME') .. '/.config/nvim/debuggers/vscode-chrome-debug/out/src/chromeDebug.js' },
    }

    -- Debug configurations for JavaScript React and TypeScript React
    local chrome_config = {
      {
        type = 'chrome',
        request = 'launch',
        name = 'Launch Chrome',
        url = 'http://localhost:3000', -- Dev server URL
        webRoot = '${workspaceFolder}',
        sourceMaps = true,
        protocol = 'inspector',
        port = 9222, -- Chrome debugging port (must be enabled)
      },
    }

    dap.configurations.javascriptreact = chrome_config
    dap.configurations.typescriptreact = chrome_config
    dap.configurations.typescript = dap.configurations.javascript

    -- Setup dap-ui and virtual text
    dapui.setup()
    dap_virtual_text.setup()

    -- Auto-open and close DAP UI when debugging starts/stops
    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

    -- Key mappings for DAP
    vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>lua require"dap".continue()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>lua require"dap".step_over()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<F11>', '<Cmd>lua require"dap".step_into()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<F12>', '<Cmd>lua require"dap".step_out()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>b', '<Cmd>lua require"dap".toggle_breakpoint()<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>B',
      '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>dr', '<Cmd>lua require"dap".repl.open()<CR>', { noremap = true, silent = true })
  end,
}

