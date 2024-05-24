return {
  -- インデントガイドを表示
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },

  -- 括弧の補完
  {
    'cohama/lexima.vim',
    init = function()
      -- coc.nvimの<CR>のキーマップと競合するため、coc.nvim側でキーマップを設定する
      vim.g.lexima_no_default_rules = 1
    end,
  },

  -- Markdownプレビュー
  {
    'iamcco/markdown-preview.nvim',
    cmd = {'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop'},
    ft = {'markdown', 'pandoc.markdown', 'rmd'},
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    init = function()
      vim.g.mkdp_auto_close = 0
    end,
  },

  -- 選択範囲内のMarkdownのテーブルを整形
  'mattn/vim-maketable',

  -- LSPを利用してシンボル等をサイドバーで表示
  {
    'liuchengxu/vista.vim',
    init = function()
      vim.g.vista_icon_indent = {'╰─▸ ', '├─▸ '}
      vim.g.vista_default_executive = 'coc'
    end,
    keys = {
      {'<Leader>o', '<Cmd>Vista!!<CR>', mode = 'n', {noremap = true, silent = true}}
    },
    dependencies = {
      'neoclide/coc.nvim',
    },
  },

  -- vim-precious依存プラグイン
  'Shougo/context_filetype.vim',

  -- コードブロック内の言語に応じてfiletypeを変更する
  {
    'osyo-manga/vim-precious',
    dependencies = {
      'Shougo/context_filetype.vim',
    },
  },

  -- Terraformのsyntax highlightなど
  {
    'hashivim/vim-terraform',
    init = function()
      vim.g.terraform_fmt_on_save = 1
    end,
  },

  -- Tree sitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require('nvim-treesitter.configs')

      configs.setup({
        ensure_installed = {
          'python',
          'ruby',
          'go',
          'dockerfile',
          'javascript',
          'typescript',
          'bash',
          'hcl',
          'terraform',
          'toml',
          'json',
          'yaml',
          'lua',
          'vim',
          'vimdoc',
        },
        highlight = {
          enable = true,
          disable = {
            'bash',
            'terraform',
          },
        },
      })

      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldenable = false
    end,
  },

  -- Vim上からバッファ内のソースコード実行
  {
    'thinca/vim-quickrun',
    keys = {
      {'Q', '<Cmd>QuickRun<CR>', mode = 'n', {noremap = true, silent = true}}
    },
  },

  -- 検索位置(検索ヒット数)を表示
  {
    'osyo-manga/vim-anzu',
    keys = {
      {'n', '<Plug>(anzu-n-with-echo)', mode = 'n'},
      {'N', '<Plug>(anzu-N-with-echo)', mode = 'n'},
      {'*', '<Plug>(anzu-star-with-echo)', mode = 'n'},
      {'#', '<Plug>(anzu-sharp-with-echo)', mode = 'n'},
      {'<Esc><Esc>', '<Plug>(anzu-clear-search-status)', mode = 'n'},
    },
  },

  -- 日本語の文節単位で移動できるようにする
  'deton/jasegment.vim',
}
