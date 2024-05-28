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
        section_separators = {left = nil, right = nil},
        component_separators = {left = '|', right = '|'},
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
  'jeetsukumaran/vim-buffergator',

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
      })
    end,
  }
}
