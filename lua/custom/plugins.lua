local plugins = {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed={
        -- golang
        'gopls',
        -- python
        'black',
        'debugpy',
        'mypy',
        'ruff',
        'pyright',
      },
    },
  },
  {
    'mfussenegger/nvim-dap',
    init = function ()
      require('core.utils').load_mappings('dap')
    end
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --   dapui.close()
      -- end
    end
  },
  {
    'nvimtools/none-ls.nvim',
    opts = function ()
      return require 'custom.configs.null-ls'
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'nvimtools/none-ls.nvim',
        opts = function ()
          return require 'custom.configs.null-ls'
        end,
      },
    },
    config = function ()
      require 'plugins.configs.lspconfig'
      require 'custom.configs.lspconfig'
    end
  },
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function (_, opts)
      local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
      require('dap-python').setup(path)
      require('core.utils').load_mappings('dap_python')
    end,
  },
  {
    'leoluz/nvim-dap-go',
    ft = 'go',
    dependencies = 'mfussenegger/nvim-dap',
    config = function (_, opts)
      require('dap-go').setup(opts)
      require('core.utils').load_mappings('dap_go')
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
}

return plugins
