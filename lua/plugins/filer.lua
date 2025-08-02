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
      {
        '<Leader>e',
        function()
          local nvim_tree = require('nvim-tree.api')
          if nvim_tree.tree.is_tree_buf() then
            nvim_tree.tree.close()
          else
            nvim_tree.tree.open()
          end
        end,
        mode = 'n',
        { noremap = true, silent = true }
      }
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  }
}
