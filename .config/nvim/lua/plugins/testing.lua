return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    { 'nvim-neotest/neotest-jest', commit = 'c211844' },
  },
  config = function()
    local neotest = require 'neotest'
    neotest.setup {
      adapters = {
        require 'neotest-jest' {
          jestCommand = 'npm test',
          jest_test_discovery = true,
          env = {
            NODE_ENV = 'test',
          },
          cwd = function(file)
            if string.find(file, 'cyera') then
              local foundPackage = string.match(file, '(.-/[^/]+/)src')
              print(foundPackage)
              return foundPackage
            end
            return vim.fn.getcwd()
          end,
        },
      },
      log_level = vim.log.levels.DEBUG,
      discovery = {
        filter_dir = function(name, rel_path, root)
          return name ~= 'dist'
        end,
      },
    }
  end,
  keys = {
    { '<leader>t', '', desc = '+test' },
    {
      '<leader>tt',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'Run File',
    },
    {
      '<leader>tT',
      function()
        require('neotest').run.run(vim.uv.cwd())
      end,
      desc = 'Run All Test Files',
    },
    {
      '<leader>tr',
      function()
        require('neotest').run.run()
      end,
      desc = 'Run Nearest',
    },
    {
      '<leader>tl',
      function()
        require('neotest').run.run_last()
      end,
      desc = 'Run Last',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Toggle Summary',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open { enter = true, auto_close = true }
      end,
      desc = 'Show Output',
    },
    {
      '<leader>tO',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = 'Toggle Output Panel',
    },
    {
      '<leader>tS',
      function()
        require('neotest').run.stop()
      end,
      desc = 'Stop',
    },
    {
      '<leader>tw',
      function()
        require('neotest').watch.toggle(vim.fn.expand '%')
      end,
      desc = 'Toggle Watch',
    },
  },
}
