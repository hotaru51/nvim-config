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
    build = "cd app && yarn install",
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
      {
        "<leader>o",
        function()
          local outline = require('outline')
          if outline.has_focus() then
            outline.close_outline()
          else
            outline.open_outline()
          end
        end,
        desc = "Toggle outline"
      },
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
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      local nvim_treesitter = require('nvim-treesitter')
      nvim_treesitter.setup()
      nvim_treesitter.install({
        'python',
        'ruby',
        'go',
        'dockerfile',
        'javascript',
        'typescript',
        'tsx',
        'html',
        'css',
        'styled',
        'bash',
        'hcl',
        'terraform',
        'toml',
        'json',
        'json5',
        'jsonnet',
        'yaml',
        'lua',
        'vim',
        'vimdoc',
        'markdown',
        'markdown_inline',
      })

      -- 機能の有効化
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
        callback = function(ctx)
          -- 特定のファイルタイプでは有効化させない
          local exclude_filetype = { 'terraform', 'bash' }
          if vim.tbl_contains(exclude_filetype, vim.bo.filetype) then
            return
          end

          local sts = pcall(vim.treesitter.start) -- ハイライト有効化
          if sts then
            -- 折りたたみ有効化
            vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo[0][0].foldmethod = 'expr'
            vim.wo[0][0].foldenable = false

            -- インデントの有効化
            -- 特定のファイルタイプは有効化させない
            local exclude_indent_filetype = { 'typescript', 'json', 'jsonc' }
            if not vim.tbl_contains(exclude_indent_filetype, vim.bo.filetype) then
              vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
          end
        end
      })
    end,
  },

  -- treesitterでtext objectを拡張する
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    config = true,
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
      require('hlslens').setup()
      require("scrollbar.handlers.search").setup()

      local kopts = { noremap = true, silent = true }
      vim.keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.keymap.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.keymap.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.keymap.set('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.keymap.set('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
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
