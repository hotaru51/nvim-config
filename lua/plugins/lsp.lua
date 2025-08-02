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
}
