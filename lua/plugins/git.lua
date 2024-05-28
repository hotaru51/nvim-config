return {
  -- VimからGit操作
  'tpope/vim-fugitive',

  -- 変更した行の位置やgit blameの表示
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
      require("scrollbar.handlers.gitsigns").setup()
    end,
    dependencies = {
      'petertriho/nvim-scrollbar',
    },
  },
}
