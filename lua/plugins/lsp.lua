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

  -- none-ls.nvimが依存
  'nvim-lua/plenary.nvim',

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
    event = {'BufReadPre', 'BufNewFile'},
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

  -- NeoVimのLSP設定補助プラグイン
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- neoconf呼び出し
      require('neoconf').setup({
        local_settings = '.vim/neoconf.json',
      })

      -- lspconfig-bundler呼び出し
      require('lspconfig-bundler').setup()

      -- cmp-nvim-lsp向けの設定
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- mason-lspconfigに渡すhandler
      local handlers = {
        -- デフォルト
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities
          })

          -- lsp_signatureの設定
          require('lsp_signature').setup({
            bind = true,
            handler_opts = {
              border = 'rounded',
            },
            hint_prefix = ' ',
          })
        end,

        lua_ls = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  -- vimでWARNINGが出るのを抑止
                  globals = {
                    'vim',
                  },
                },
              },
            },
          })
        end,

        yamlls = function ()
          require('lspconfig').yamlls.setup({
            capabilities = capabilities,
            settings = {
              yaml = {
                customTags = {
                  '!And',
                  '!And sequence',
                  '!Base64',
                  '!Base64 mapping',
                  '!Cidr',
                  '!Cidr sequence',
                  '!Condition',
                  '!Equals',
                  '!Equals sequence',
                  '!FindInMap sequence',
                  '!GetAZs',
                  '!GetAtt',
                  '!GetAtt sequence',
                  '!If',
                  '!If sequence',
                  '!ImportValue',
                  '!Join sequence',
                  '!Not',
                  '!Not sequence',
                  '!Or',
                  '!Or sequence',
                  '!Ref',
                  '!Select',
                  '!Select sequence',
                  '!Split',
                  '!Split sequence',
                  '!Sub',
                  '!Sub sequence'
                },
              },
            },
          })
        end
      }

      -- mason-lspconfigの設定
      require('mason-lspconfig').setup({
        -- 自動インストールするLanguage Server
        ensure_installed = {
          'pyright',
          'solargraph',
          'gopls',
          'jsonls',
          'ts_ls',
          'html',
          'cssls',
          'yamlls',
          'terraformls',
          'bashls',
          'dockerls',
          'docker_compose_language_service',
          'lua_ls',
          'vimls',
        },
        automatic_installation = true,
        handlers = handlers,
      })

      -- <Leader>hh でhoverするように設定
      vim.keymap.set('n', '<Leader>hh', '<CMD>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})
      -- <Leader>he でdiagnosticをfloatで表示
      vim.keymap.set('n', '<Leader>he', '<CMD>lua vim.diagnostic.open_float(nil, {focus=false})<CR>', {noremap = true, silent = true})

      -- diagnosticsのfloatのborderの設定
      vim.diagnostic.config({
        float = { border = "rounded" },
      })

      -- hover時のwindowのborderの設定
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        {
          border = 'rounded',
        }
      )

      -- :Formatでフォーマットを実行
      vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({async = true}) end, {})

      -- Diagnosticsのアイコン指定
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
          },
        },
      })
    end,
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'folke/neoconf.nvim',
    },
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
      {'<leader>a', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Buffer Diagnostics (Trouble)'},
    },
  },

  -- signature helpの表示
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
  },

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
      vim.keymap.set('n', 'gd', '<CMD>Lspsaga peek_definition<CR>', {noremap = true, silent = true})

      -- 参照元ジャンプ
      vim.keymap.set('n', 'gr', '<CMD>Lspsaga finder ref<CR>', {noremap = true, silent = true})

      -- リネーム
      vim.keymap.set('n', '<Leader>rn', '<CMD>Lspsaga rename<CR>', {noremap = true, silent = true})
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
