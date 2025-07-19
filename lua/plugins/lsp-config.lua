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

      -- 各言語共通設定
      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      })

      -- lua_ls
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              -- vimでWARNINGが出るのを抑止
              globals = {
                'vim',
              },
            },
          },
        }
      })

      -- yamlls
      vim.lsp.config('yamlls', {
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
        }
      })

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
      })

      -- lsp_signatureの設定
      require('lsp_signature').setup({
        bind = true,
        handler_opts = {
          border = 'rounded',
        },
        hint_prefix = ' ',
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
