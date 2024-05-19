return {
  -- カラースキーム
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
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
    },
  },
}
