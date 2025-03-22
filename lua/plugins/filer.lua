return {
  -- ファイラー
  {
    'nvim-tree/nvim-tree.lua',
    opts = {
      -- タブ間でnvim-treeの状態を同期
      tab = {
        sync = {
          open = true,
          close = true
        }
      },
      -- gitignore対象のファイルをデフォルトで表示
      git = {
        ignore = false
      },
      -- dotfileをデフォルトで非表示、.gitignoreだけは常に表示する
      filters = {
        dotfiles = true,
        exclude = { ".gitignore" }
      }
    },
    keys = {
      { '<Leader>e', '<Cmd>NvimTreeToggle<CR>', mode = 'n', { noremap = true, silent = true } }
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  }
}
