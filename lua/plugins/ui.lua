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
    'itchyny/lightline.vim',
    config = function()
      vim.cmd([[
      function! LightlineFugitive()
        let l:res = ''

        let l:b = FugitiveHead()
        if strlen(b) > 0
          let res = ' '.l:b
        endif

        return res
      endfunction
      ]])

      vim.g.lightline = {
        colorscheme = 'tokyonight',
        component_function = {
          gitbranch = 'LightlineFugitive'
        },
        active = {
          left = {
            {'mode', 'paste'},
            {'gitbranch', 'readonly', 'filename', 'modified'},
          },
          right = {
            {'lineinfo'},
            {'percent'},
            {'fileformat', 'fileencoding', 'filetype'},
          },
        },
      }
    end,
    dependencies = {
      'folke/tokyonight.nvim',
      'tpope/vim-fugitive',
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
}
