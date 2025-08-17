return {
  -- Language Serverのインストール
  {
    'mason-org/mason.nvim',
    config = true,
  },

  -- nvim-lspconfigとmasonを連携させるプラグイン
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      -- 自動インストールするLanguage Server
      ensure_installed = {
        'pyright',
        'solargraph',
        'gopls',
        'jsonls',
        'ts_ls',
        'html',
        'cssls',
        'eslint',
        'yamlls',
        'terraformls',
        'tflint',
        'bashls',
        'dockerls',
        'docker_compose_language_service',
        'lua_ls',
        'vimls',
      },
      automatic_enable = true
    },
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
  },

  -- JSON、YAMLのschema情報
  'b0o/schemastore.nvim',

  -- Diagnostics用のUI
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      { '<leader>a', '<cmd>Trouble diagnostics open focus=true auto_preview=false filter.buf=0<CR>', desc = 'Current Buffer Diagnostics (Trouble)' },
      { '<leader>A', '<cmd>Trouble diagnostics open focus=true auto_preview=false<CR>',              desc = 'All Buffer Diagnostics (Trouble)' },
    },
  },

  -- signature helpの表示
  {
    'ray-x/lsp_signature.nvim',
    opts = {
      bind = true,
      handler_opts = {
        border = 'rounded',
      },
      hint_prefix = ' ',
    },
    dependencies = {
      'neovim/nvim-lspconfig',
    },
  },

  -- LSP関連のUI
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    opts = {
      definition = {
        keys = {
          edit = '<C-o>',
          split = '<C-x>',
          vsplit = '<C-v>',
          tabe = '<C-t>',
        },
      },
      finder = {
        keys = {
          toggle_or_open = '<CR>',
          split = '<C-x>',
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
    },
    keys = {
      -- hover
      { mode = 'n', '<Leader>hh', '<CMD>Lspsaga hover_doc<CR>',       { noremap = true, silent = true } },
      -- 定義元ジャンプ
      { mode = 'n', 'gd',         '<CMD>Lspsaga peek_definition<CR>', { noremap = true, silent = true } },
      -- 参照元ジャンプ
      { mode = 'n', 'gr',         '<CMD>Lspsaga finder ref<CR>',      { noremap = true, silent = true } },
      -- リネーム
      { mode = 'n', '<Leader>rn', '<CMD>Lspsaga rename<CR>',          { noremap = true, silent = true } },
    },
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

  -- diagnosticsのインライン表示
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup({
        preset = "powerline",
        options = {
          multilines = {
            enabled = true,
          },
        },
      })
      vim.diagnostic.config({ virtual_text = false })
    end
  },
}
