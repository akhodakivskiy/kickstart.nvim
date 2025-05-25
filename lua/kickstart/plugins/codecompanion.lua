return {
  'olimorris/codecompanion.nvim',
  config = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    log_level = 'debug',
    strategies = {
      inline = {
        adapter = 'anthropic',
      },
      chat = {
        adapter = 'anthropic',
      },
      agent = {
        adapter = 'anthropic',
      },
    },
    adapters = {
      anthropic = function()
        return require('codecompanion.adapters').extend('anthropic', {
          env = {
            api_key = os.getenv("ANTHROPIC_KEY"),
          },
        })
      end,
      ollama = function()
        return require('codecompanion.adapters').extend('ollama', {
          schema = {
            model = {
              default = 'qwen3:14b',
            },
          },
          env = {
            url = 'http://ai.kdkvsk.com:11435',
            api_key = 'e6674e8879f9473e8429631dfa7edec8',
          },
          headers = {
            ['Content-Type'] = 'application/json',
            ['Authorization'] = 'Bearer ${api_key}',
          },
          parameters = {
            sync = true,
          },
        })
      end,
    },
  },
  keys = {
    { '<leader>ao', '<cmd>CodeCompanion<cr>', mode = { 'n', 'v' }, desc = 'C[o]deCompanion Prompt' },
    { '<leader>ac', '<cmd>CodeCompanionChat<cr>', mode = { 'n', 'v' }, desc = 'CodeCompanion [C]hat' },
    { '<leader>aa', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, desc = 'CodeCompanion [A]ction' },
  },
}
