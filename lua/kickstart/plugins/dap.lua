return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'nvim-neotest/nvim-nio',
    {
      'mfussenegger/nvim-dap',
      config = function(self, opts)
        -- Debug settings if you're using nvim-dap
        local dap = require 'dap'
        require('dapui').setup()

        dap.adapters.codelldb = {
          type = 'server',
          port = '${port}',
          executable = {
            -- Change this to your path!
            command = vim.fn.expand '$HOME/.local/bin/codelldb/extension/adapter/codelldb',
            args = { '--port', '${port}' },
          },
        }

        dap.configurations.rust = {
          {
            name = 'Launch file',
            type = 'codelldb',
            request = 'launch',
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
          },
        }

        dap.configurations.scala = {
          {
            type = 'scala',
            request = 'launch',
            name = 'RunOrTest',
            metals = {
              runType = 'runOrTestFile',
              --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
            },
          },
          {
            type = 'scala',
            request = 'launch',
            name = 'Test File',
            metals = {
              runType = 'testFile',
            },
          },
          {
            type = 'scala',
            request = 'launch',
            name = 'Test Target',
            metals = {
              runType = 'testTarget',
            },
          },
        }
      end,
      keys = {
        { '<leader>rr', '<cmd>DapNew<cr>', desc = 'DAP [R]un or test' },
        { '<leader>rt', '<cmd>DapTerminate<cr>', desc = 'DAP [T]Terminate' },
        { '<leader>re', '<cmd>DapToggleRepl<cr>', desc = 'DAP Toggle R[E]PL' },
        { '<leader>rB', '<cmd>DapSetBreakpoint<cr>', desc = 'DAP Set [B]reakpoint' },
        { '<leader>rC', '<cmd>DapClearBreakpoints<cr>', desc = 'DAP [Clear] Breakpoints' },
        { '<F9>', '<cmd>DapToggleBreakpoint<cr>', desc = 'DAP Toggle [B]reakpoint' },
        { '<F5>', '<cmd>DapContinue<cr>', desc = 'DAP [C]ontinue' },
        { '<F10>', '<cmd>DapStepOver<cr>', desc = 'DAP [S]tep Over' },
        { '<F11>', '<cmd>DapStepInto<cr>', desc = 'DAP Step [I]nto' },
        { '<F12>', '<cmd>DapStepOut<cr>', desc = 'DAP Step [O]out' },
        {
          '<leader>rl',
          function()
            require('dap').run_last()
          end,
          desc = 'DAP Run [L]ast Configuration',
        },
        {
          '<leader>rK',
          function()
            require('dap.ui.widgets').hover()
          end,
          desc = 'DAP Hover widget',
        },
        {
          '<leader>rw',
          function()
            require('dapui').toggle()
          end,
          desc = 'DAP UI [W]idget',
        },
      },
    },
  },
}
