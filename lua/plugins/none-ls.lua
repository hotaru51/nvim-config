return {
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
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
  },
}
