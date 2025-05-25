return {
  'scalameta/nvim-metals',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  ft = { 'scala', 'sbt', 'java' },
  keys = {
    {
      '<leader>mw',
      function()
        require('metals').hover_worksheet()
      end,
      desc = '[M]etals [W]orksheet',
    },
    {
      '<leader>ms',
      function()
        require('telescope').extensions.metals.commands()
      end,
      desc = '[M]etals [S]earch',
    },
  },
  opts = function()
    local metals_config = require('metals').bare_config()

    metals_config.settings = {
      showImplicitArguments = true,
      showImplicitConversionsAndClasses = true,
      showInferredType = true,
      superMethodLensesEnabled = true,
      testUserInterface = 'Test Explorer',
    }
    metals_config.init_options.statusBarProvider = 'on'
    metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()

    metals_config.on_attach = function(client, bufnr)
      require('metals').setup_dap()
    end

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = self.ft,
      callback = function()
        require('metals').initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
