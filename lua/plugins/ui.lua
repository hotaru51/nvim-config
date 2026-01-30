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
    config = function()
      require('toggleterm').setup({
        open_mapping = [[<leader>tf]],
        direction = 'float',
        insert_mappings = false,
        terminal_mappings = false,
        auto_scroll = false,
      })

      local terminal = require('toggleterm.terminal').Terminal

      -- lazygit専用ターミナル表示
      local lazygit = terminal:new({ cmd = 'lazygit', hidden = true })
      local lazygit_toggle = function()
        lazygit:toggle()
      end
      vim.keymap.set('n', '<leader>tl', lazygit_toggle, { noremap = true, silent = true })

      -- AI Agent CLIが見つかった場合は表示用のターミナルを作成
      local helpers = require('utils.helpers')
      local agent_cmd = helpers.detect_ai_agent_cmd()
      if agent_cmd ~= nil then
        local ai_agent = terminal:new({ cmd = agent_cmd, hidden = true, direction = 'vertical' })
        local ai_agent_toggle = function()
          -- outline.nvimが開いている場合は閉じる
          require('outline').close_outline()
          ai_agent:toggle(math.floor(vim.o.columns * 0.3))
        end
        vim.keymap.set('n', '<leader>ta', ai_agent_toggle, { noremap = true, silent = true })
      end
    end,
  },

  -- バッファ操作
  {
    'j-morano/buffer_manager.nvim',
    config = function()
      require("buffer_manager").setup({
        select_menu_item_commands = {
          sp = {
            key = "<C-x>",
            command = "split",
          },
          vs = {
            key = "<C-v>",
            command = "vsplit",
          },
          tabe = {
            key = "<C-t>",
            command = "tabedit",
          },
        },
        show_indicators = "before",
      })
      local ui = require("buffer_manager.ui")
      vim.keymap.set("n", "<leader>b", ui.toggle_quick_menu, { silent = true, noremap = true })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
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
    version = '*',
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
