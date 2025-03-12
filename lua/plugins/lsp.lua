return {
  -- Language Serverのインストール
  {
    'williamboman/mason.nvim',
    config = true,
  },

  -- nvim-lspconfigとmasonを連携させるプラグイン
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
  },

  -- none-lsの追加ソース
  'nvimtools/none-ls-extras.nvim',

  -- Linter、Formatterを扱うプラグイン
  {
    'nvimtools/none-ls.nvim',
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          require("none-ls.diagnostics.flake8"),
          require("none-ls.diagnostics.eslint_d"),
          require("none-ls.formatting.eslint_d"),
          require("none-ls.code_actions.eslint_d"),
          null_ls.builtins.completion.luasnip,
          null_ls.builtins.formatting.isort.with({
            extra_args = { '--profile', 'black' },
          }),
        },
      })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvimtools/none-ls-extras.nvim',
    },
  },

  -- masonとnone-lsを連携させるプラグイン
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
    config = function()
      require('mason-null-ls').setup({
        ensure_installed = {
          'flake8',
          'black',
          'isort',
          'eslint_d',
          'cfn-lint',
          'sql-formatter',
        },
        automatic_installation = true,
        handlers = {},
      })

      -- SQLCompleteのエラー回避
      vim.g.omni_sql_default_compl_type = 'syntax'
    end,
  },

  -- Rubyでbundlerを考慮してLanguage Serverを起動してくれる
  'mihyaeru21/nvim-lspconfig-bundler',

  -- プロジェクト個別の設定を反映させる
  'folke/neoconf.nvim',

  -- Diagnostics用のUI
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      { '<leader>a', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Buffer Diagnostics (Trouble)' },
    },
  },

  -- signature helpの表示
  'ray-x/lsp_signature.nvim',

  -- LSP関連のUI
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({
        definition = {
          keys = {
            edit = '<C-o>',
            split = '<C-s>',
            vsplit = '<C-v>',
            tabe = '<C-t>',
          },
        },
        finder = {
          keys = {
            edit = '<C-o>',
            split = '<C-s>',
            vsplit = '<C-v>',
            tabe = '<C-t>',
          },
        },
        lightbulb = {
          sign = false,
        },
        ui = {
          code_action = '',
        },
      })

      -- 定義元ジャンプ
      vim.keymap.set('n', 'gd', '<CMD>Lspsaga peek_definition<CR>', { noremap = true, silent = true })

      -- 参照元ジャンプ
      vim.keymap.set('n', 'gr', '<CMD>Lspsaga finder ref<CR>', { noremap = true, silent = true })

      -- リネーム
      vim.keymap.set('n', '<Leader>rn', '<CMD>Lspsaga rename<CR>', { noremap = true, silent = true })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },

  -- カーソル下の単語のハイライト
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({
        delay = 300,
        -- 全部ハイライトされて鬱陶しいので
        -- lspとtreesitterのみに絞る
        providers = {
          'lsp',
          'treesitter',
        },
      })
    end,
  },
}
