return {
  -- カラースキーム
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },

  -- ステータスラインカスタマイズ
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'tokyonight',
      },
      sections = {
        lualine_x = {
          'encoding',
          {
            'fileformat',
            icons_enabled = false,
          },
          'filetype',
        },
      },
    },
    dependencies = {
      'folke/tokyonight.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },

  -- ウィンドウ操作
  {
    'simeji/winresizer',
    init = function()
      vim.g.winresizer_start_key = '<Leader>w'
      vim.g.winresizer_gui_start_key = '<Leader>W'
    end,
  },

  -- ターミナル表示
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      open_mapping = [[<leader>tf]],
      direction = 'float',
      insert_mappings = false,
      terminal_mappings = false,
      auto_scroll = false,
    },
  },

  -- バッファ操作
  {
    'jeetsukumaran/vim-buffergator',
    init = function()
      --画面下に表示
      vim.g.buffergator_viewport_split_policy = 'B'
      -- デフォルトのグローバルキーマップを削除
      vim.g.buffergator_suppress_keymaps = 1
    end,
    keys = {
      { '<Leader>bb', '<Cmd>BuffergatorToggle<CR>',     mode = 'n', { noremap = true, silent = true } },
      { '<Leader>bt', '<Cmd>BuffergatorTabsToggle<CR>', mode = 'n', { noremap = true, silent = true } },
    },
  },

  -- スクロールバー
  {
    'petertriho/nvim-scrollbar',
    config = function()
      local colors = require("tokyonight.colors").setup()

      require("scrollbar").setup({
        handle = {
          color = colors.bg_highlight,
        },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
        handlers = {
          cursor = false,
        },
      })
    end,
  },

  -- FuzzyFinder
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    config = function()
      require('telescope').setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'ignore_case',
          },
        },
      })

      require('telescope').load_extension('fzf')
      require("telescope").load_extension("fidget")

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Telescope resume' })
      vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = 'Telescope jumplist' })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      'j-hui/fidget.nvim',
    },
  },

  -- telescopeのsorter
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },

  -- Language Serverのステータス表示
  {
    'j-hui/fidget.nvim',
    config = true,
  },

  -- 起動時の画面のカスタマイズ
  {
    'goolord/alpha-nvim',
    config = function()
      local dashboard = require('alpha.themes.dashboard')
      dashboard.section.header.val = {
        '  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⣄⡀ ⠀',
        '  ⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⣤⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠤⠤⠤⠄⠤⠤⢀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⠶⠿⢿⣿⣿⣿⡇ ⠀',
        '  ⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠠⠐⠊⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠒⠢⢄⡀⢀⠔⠊⠁⠀⠀⠀⠀⣻⣿⣿⠇ ⠀',
        '  ⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⠈⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠤⡀⠀⠀⠀⠀⢀⣿⣿⠏⠀ ⠀',
        '  ⠀⠀⠀⢠⣿⣿⣿⡿⠿⠃⠀⠘⠿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢄⠀⠀⠀⣼⣿⡟⠀⠀ ⠀',
        '  ⠀⠀⠀⠸⣿⣿⣷⣶⣶⡄⠀⣠⣶⣶⣾⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠄⣼⣿⠏⠀⠀⠀ ⠀',
        '  ⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣠⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⡿⠋⠀⠀⠀⠀ ⠀',
        '  ⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⡟⠁⠘⡄⠀⠀⠀ ⠀',
        '  ⠀⠀⠀⠀⠀⢠⠁⠈⠉⠛⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⡿⠋⠀⠀⠀⠐⡄⠀⠀ ⠀',
        '  ⠀⠀⠀⠀⢀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⠟⠁⠀⠀⠀⠀⠀⠰⠀⠀ ⠀',
        '  ⠀⠀⠀⠀⡸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀ ⠀',
        '  ⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠀ ⠀',
        '  ⠀⠀⠀⠀⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀ ⠀',
        '  ⠀⠀⠀⠀⡅⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀ ⠀',
        '  ⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡈⠀ ⠀',
        '  ⠀⠀⠀⠀⠸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠇⠀ ⠀',
        '  ⠀⠀⠀⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⡟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⠀⠀ ⠀',
        '  ⠀⠀⠀⠀⠀⠈⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠄⠐⠂⠁⠒⠒⠤⡐⠀⠀⠀ ⠀',
        '  ⠀⠀⠀⠀⠀⠀⡠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠊⠀⠀⠀⠀⡄⠀⠀⠀⠈⠢⡀⠀ ⠀',
        '  ⠀⠀⠀⠀⠀⡴⠁⠈⠢⠀⠀⠀⠀⠀⠀⠀⢀⣴⣾⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠁⠀⠀⠀⠀⢀⣧⠀⠀⠀⠀⠀⠱⠀ ⠀',
        '  ⠀⠀⠀⠀⣾⠀⠀⠀⠀⠑⡄⠀⠀⠀⢠⣾⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣤⣴⣿⣿⣷⣦⣤⡄⠀⠀⡇ ⠀',
        '  ⠀⠀⠀⣼⡇⠀⠀⠀⠀⠀⠈⣒⣤⣾⡿⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠀⠀⠀⠀⠉⢻⣿⠋⠉⠀⠀⠀⢀⠃ ⠀',
        '  ⠀⠀⣸⣿⣇⣀⣀⣀⣤⣶⣿⣿⠟⠉⠢⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠂⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⢀⠌⠀ ⠀',
        '  ⠀⠀⣿⣿⣿⣿⣿⣿⡿⠟⠉⠀⠀⠀⠀⠀⠈⠑⠂⠤⢄⣀⣀⠀⠀⠀⠀⠀⠀⣀⣀⠠⠤⠐⠊⠀⠑⢄⡀⠀⠀⠀⠀⠀⢀⠤⠋⠀⠀ ⠀',
        '  ⠀⠀⠙⠛⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠐⠂⠀⠉⠀⠀⠀⠀⠀ ⠀',
        '                                                     ',
        '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
        '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
        '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
        '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
        '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
        '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
        '                                                     ',
      }
      require('alpha').setup(dashboard.opts)
    end,
    dependencies = {
      'echasnovski/mini.icons',
    },
  },

  -- alpha-nvimで使用するicon library
  'echasnovski/mini.icons',

  -- マークダウン表示用プラグイン
  -- 現状codecompanion用として使用
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "codecompanion" },
        ignore_buftypes = {},
      },
    },
    cond = (vim.env.HTR_NVIM_AI == 'personal' or vim.env.HTR_NVIM_AI == 'business'),
  },
}
