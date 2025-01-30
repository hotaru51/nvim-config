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
          'eslint',
          'cfn-lint',
          'sql-formatter',
        },
        automatic_installation = true,
        handlers = {},
      })
    end,
  },

  -- NeoVimのLSP設定補助プラグイン
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- snippet supportの有効化
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- mason-lspconfigに渡すhandler
      local handlers = {
        -- デフォルト
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities
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
      local luasnip = require('luasnip')

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

        -- スニペット
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },

        -- 補完ソース
        sources = cmp.config.sources({
          {name = 'nvim_lsp'},
          {name = 'buffer'},
          {name = 'path'},
          {name = 'omni'},
          {name = 'nvim_lsp_signature_help'},
          {name = 'luasnip'},
        }),

        -- キーマッピング
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),

          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                if luasnip.expandable() then
                  luasnip.expand()
                else
                  cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                end
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
          }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        -- / の補完
        cmp.setup.cmdline('/', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            {name = 'buffer'}
          }
        }),

        -- : の補完
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            {name = 'path'}
          }, {
            {
              name = 'cmdline',
              option = {
                ignore_cmds = {'Man', '!'}
              }
            }
          })
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

  -- nvim-cmpのオムニ補完のソース
  'hrsh7th/cmp-omni',

  -- nvim-cmpのコマンドラインモードの補完ソース
  'hrsh7th/cmp-cmdline',

  -- nvim-cmpのシグニチャ補完ソース
  'hrsh7th/cmp-nvim-lsp-signature-help',

  -- nvim-cmpのGitHub Copilotの補完ソース
  {
    'zbirenbaum/copilot-cmp',
    config = function ()
      require("copilot_cmp").setup()
    end,
    cond = (vim.env.HTR_GH_COPILOT == 'enabled'),
    dependencies = {
      'zbirenbaum/copilot.lua',
    },
  },

  -- スニペット集
  "rafamadriz/friendly-snippets",

  -- スニペットエンジン
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
  },

  -- nvim-cmpのLuaSnip補完ソース
  'saadparwaiz1/cmp_luasnip',

  -- Diagnostics用のUI
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
          {'<leader>a', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Buffer Diagnostics (Trouble)'},
          {'gr', '<cmd>Trouble lsp_references<CR>', desc = 'LSP References'},
    },
  },
}
