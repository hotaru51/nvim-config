return {
  -- インデントガイドを表示
  {
    'nathanaelkane/vim-indent-guides',
    init = function()
      vim.g.indent_guides_enable_on_vim_startup = 1
      vim.g.indent_guides_guide_size = 1
      vim.g.indent_guides_start_level = 2
      vim.g.indent_guides_auto_colors = 0
    end,
    config = function()
      local event = {'VimEnter', 'Colorscheme'}
      vim.api.nvim_create_autocmd(event, {pattern = {'*'}, command = 'hi IndentGuidesOdd  ctermbg=238 guibg=#3b4261'})
      vim.api.nvim_create_autocmd(event, {pattern = {'*'}, command = 'hi IndentGuidesEven ctermbg=236 guibg=#2b3047'})
    end,
  },

  -- 括弧の補完
  'cohama/lexima.vim',

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
