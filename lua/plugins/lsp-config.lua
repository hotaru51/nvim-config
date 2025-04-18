return {
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

      -- lsp_signatureの設定
      local lsp_signature_opts = {
        bind = true,
        handler_opts = {
          border = 'rounded',
        },
        hint_prefix = ' ',
      }

      -- mason-lspconfigに渡すhandler
      local handlers = {
        -- デフォルト
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities
          })

          require('lsp_signature').setup(lsp_signature_opts)
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

          require('lsp_signature').setup(lsp_signature_opts)
        end,

        yamlls = function()
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

          require('lsp_signature').setup(lsp_signature_opts)
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
          'ts_ls',
          'html',
          'cssls',
          'yamlls',
          'terraformls',
          'tflint',
          'bashls',
          'dockerls',
          'docker_compose_language_service',
          'lua_ls',
          'vimls',
        },
        automatic_installation = true,
        handlers = handlers,
      })

      -- <Leader>he でdiagnosticをfloatで表示
      vim.keymap.set('n', '<Leader>he', '<CMD>lua vim.diagnostic.open_float(nil, {focus=false})<CR>',
        { noremap = true, silent = true })

      -- diagnosticsのfloatのborderの設定
      vim.diagnostic.config({
        float = { border = "rounded" },
      })

      -- :Formatでフォーマットを実行
      vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({ async = true }) end, {})

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
      'folke/neoconf.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'mihyaeru21/nvim-lspconfig-bundler',
      'ray-x/lsp_signature.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  },
}
