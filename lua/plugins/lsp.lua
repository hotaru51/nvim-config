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

  -- 補完ウィンドウにアイコンを表示
  'onsails/lspkind.nvim',

  -- 入力補完
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      local luasnip = require('luasnip')
      -- cmp-bufferの設定
      local cmp_buffer_config = {
        name = 'buffer',
        option = {
          get_bufnrs = function()
            local bufs = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              bufs[vim.api.nvim_win_get_buf(win)] = true
            end
            return vim.tbl_keys(bufs)
          end
        }
      }

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
          cmp_buffer_config,
          {name = 'path'},
          {name = 'omni'},
          {name = 'lazydev'},
          {name = 'luasnip'},
          {name = 'copilot'},
          {name = 'render-markdown'},
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
          sources = { cmp_buffer_config },
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

  -- NeoVim設定編集時のLua関連の補完ソース
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      {path = "${3rd}/luv/library", words = {"vim%.uv"}},
    },
  },

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

  -- スニペットエンジン
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
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
