local function installable_tools()
  local tools_by_installer = {
    node = {
      'prettier',
      'sql-formatter'
    },
    python = {
      'flake8',
      'black',
      'isort',
      'cfn-lint'
    },
  }

  local tools = {}

  for installer, names in pairs(tools_by_installer) do
    if vim.fn.executable(installer) == 1 then
      vim.list_extend(tools, names)
    end
  end

  return tools
end

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
          null_ls.builtins.completion.luasnip,
          null_ls.builtins.formatting.prettier,
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
        ensure_installed = installable_tools(),
        automatic_installation = true,
        handlers = {},
      })

      -- SQLCompleteのエラー回避
      vim.g.omni_sql_default_compl_type = 'syntax'
    end,
    dependencies = {
      'mason-org/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
  },
}
