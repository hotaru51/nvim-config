return {
  -- インデントガイドを表示
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },

  -- ブラウザでのMarkdownプレビュー
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown', 'pandoc.markdown', 'rmd' },
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
    "hedyhli/outline.nvim",
    opts = {
      outline_window = {
        width = 15,
      },
    },
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
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
          'html',
          'css',
          'styled',
          'bash',
          'hcl',
          'terraform',
          'toml',
          'json',
          'jsonc',
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

  -- treesitterでtext objectを拡張する
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require('nvim-treesitter.configs').setup({})
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },

  -- Vim上からバッファ内のソースコード実行
  {
    'thinca/vim-quickrun',
    keys = {
      { 'Q', '<Cmd>QuickRun<CR>', mode = 'n', { noremap = true, silent = true } }
    },
  },

  -- 検索位置(検索ヒット数)を表示
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require("scrollbar.handlers.search").setup()
    end,
    dependencies = {
      'petertriho/nvim-scrollbar',
    },
  },

  -- ()や'の変更等を行う
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },

  -- プロジェクトローカルの設定を反映
  {
    "klen/nvim-config-local",
    opts = {
      config_files = { ".nvim/nvim.lua" },
      lookup_parents = true,
    },
  },
}
