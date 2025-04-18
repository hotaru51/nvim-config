return {
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
          -- lspkindの設定
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
          { name = 'nvim_lsp' },
          cmp_buffer_config,
          { name = 'path' },
          { name = 'omni' },
          { name = 'lazydev' },
          { name = 'luasnip' },
          { name = 'copilot' },
          { name = 'codeium' },
          { name = 'render-markdown' },
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
            { name = 'path' }
          }, {
            {
              name = 'cmdline',
              option = {
                ignore_cmds = { 'Man', '!' }
              }
            }
          })
        }),

        -- codecompanion向けの設定
        cmp.setup.filetype('codecompanion', {
          sources = {
            { name = 'codecompanion_models' },
            { name = 'codecompanion_slash_commands' },
            { name = 'codecompanion_tools' },
            { name = 'codecompanion_variables' },
          },
        }),

        -- UI設定
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
    dependencies = {
      'hrsh7th/cmp-buffer',
      'onsails/lspkind.nvim',
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-omni',
      'folke/lazydev.nvim',
      'zbirenbaum/copilot-cmp',
      'Exafunction/windsurf.nvim',
      'MeanderingProgrammer/render-markdown.nvim',
      'olimorris/codecompanion.nvim',
    },
  },

  -- nvim-cmpのバッファ補完ソース
  'hrsh7th/cmp-buffer',

  -- nvim-cmpのコマンドラインモードの補完ソース
  'hrsh7th/cmp-cmdline',

  -- nvim-cmpのLSP用補完ソース
  'hrsh7th/cmp-nvim-lsp',

  -- nvim-cmpのオムニ補完のソース
  'hrsh7th/cmp-omni',

  -- nvim-cmpのファイルパス補完ソース
  'hrsh7th/cmp-path',

  -- nvim-cmpのGitHub Copilotの補完ソース
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require("copilot_cmp").setup()
    end,
    cond = (vim.env.HTR_NVIM_AI == 'business'),
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

  -- NeoVim設定編集時のLua関連の補完ソース
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },

  -- 補完ウィンドウにアイコンを表示
  'onsails/lspkind.nvim',

  -- 括弧の補完
  'cohama/lexima.vim',
}
