-- <> Dap debugger
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',            -- Optional UI for DAP
    'theHamsta/nvim-dap-virtual-text', -- Optional virtual text for variables
  },

  config = function()
    local dap = require('dap')

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
        program = '${file}', -- This will debug the currently open file
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
      },
      {
        type = 'node2',
        request = 'attach',
        name = 'Attach to process',
        processId = require 'dap.utils'.pick_process,
        cwd = vim.fn.getcwd(),
      },
    }

    -- local dap = require('dap')

    dap.adapters.chrome = {
      type = "executable",
      command = "node",
      args = { os.getenv("HOME") .. "/.config/nvim/debuggers/vscode-chrome-debug/out/src/chromeDebug.js" },
    }

    dap.configurations.javascriptreact = {
      {
        type = "chrome",
        request = "launch",
        name = "Launch Chrome",
        url = "http://localhost:3000", -- or whatever your dev server URL is
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
        protocol = "inspector",
        port = 9222, -- Chrome debugging port (must be enabled)
      },
    }

    dap.configurations.typescriptreact = dap.configurations.javascriptreact


    dap.configurations.typescript = dap.configurations.javascript

    require("dapui").setup()

    -- Auto-open DAP UI when debugging starts
    dap.listeners.after.event_initialized["dapui_config"] = function()
      require("dapui").open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      require("dapui").close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      require("dapui").close()
    end

    require("nvim-dap-virtual-text").setup()

    vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>lua require"dap".continue()<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>lua require"dap".step_over()<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<F11>', '<Cmd>lua require"dap".step_into()<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<F12>', '<Cmd>lua require"dap".step_out()<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>b', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>B',
      '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>dr', '<Cmd>lua require"dap".repl.open()<CR>', { noremap = true })

    dap.adapters.chrome = {
      type = "executable",
      command = "node",
      args = { os.getenv("HOME") .. "/.config/nvim/debuggers/vscode-chrome-debug/out/src/chromeDebug.js" },
    }

    dap.configurations.javascriptreact = {
      {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222, -- Port of the debugging session
        webRoot = "${workspaceFolder}",
      },
    }
  end
}
