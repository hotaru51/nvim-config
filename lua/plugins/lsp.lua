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

  -- NeoVimのLSP設定補助プラグイン
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- mason-lspconfigに渡すhandler
      local handlers = {
        -- デフォルト
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      }

      -- mason-lspconfigの設定
      require('mason-lspconfig').setup({
        -- 自動インストールするLanguage Server
        ensure_installed = {
          'pyright',
          'solargraph',
          'gopls',
          'jsonls',
          'eslint',
          'ts_ls',
          'yamlls',
          'terraformls',
        },
        automatic_installation = true,
        handlers = handlers,
      })

      -- hover時のwindowのborderの設定
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        {
          border = 'rounded',
        }
      )
    end,
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
  },

  -- 補完ウィンドウにアイコンを表示
  'onsails/lspkind.nvim',

  -- 入力補完
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')

      cmp.setup({
        formatting = {
          -- lspkingの設定
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = {
              menu = 50,
              abbr = 50,
            },
            ellipsis_char = '...',
            show_labelDetails = true,
          }),
        },

        -- 補完ソース
        sources = cmp.config.sources({
          {name = 'nvim_lsp'},
          {name = 'buffer'},
          {name = 'path'},
          {name = 'nvim_lsp_signature_help'},
        }),

        -- キーマッピング
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),

        -- UI設定
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
    dependencies = {
      'onsails/lspkind.nvim',
    },
  },

  -- nvim-cmpのLSP用補完ソース
  'hrsh7th/cmp-nvim-lsp',

  -- nvim-cmpのバッファ補完ソース
  'hrsh7th/cmp-buffer',

  -- nvim-cmpのファイルパス補完ソース
  'hrsh7th/cmp-path',

  -- nvim-cmpのシグニチャ補完ソース
  'hrsh7th/cmp-nvim-lsp-signature-help',

  -- Diagnostics用のUI
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
          {'<leader>aA', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Diagnostics (Trouble)'},
          {'<leader>aa', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Buffer Diagnostics (Trouble)'},
          -- TODO: splitさせたいが方法がわからない
          {'gd', '<cmd>Trouble lsp_definitions<CR>', desc = 'LSP Definitions'},
          {'gr', '<cmd>Trouble lsp_references<CR>', desc = 'LSP References'},
    },
  },
}
