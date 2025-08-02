return {
  -- NeoVimのLSP設定補助プラグイン
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- 各言語共通設定
      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      })

      -- lsp_signatureの設定
      require('lsp_signature').setup({
        bind = true,
        handler_opts = {
          border = 'rounded',
        },
        hint_prefix = ' ',
      })

      -- <Leader>he でdiagnosticをfloatで表示
      vim.keymap.set('n', '<Leader>he', '<CMD>lua vim.diagnostic.open_float(nil, {focus=false})<CR>',
        { noremap = true, silent = true })

      -- diagnosticsのfloatのborderの設定
      vim.diagnostic.config({
        float = { border = "rounded" },
      })

      -- :Formatでフォーマットを実行
      vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({ async = true }) end, {})

      -- Diagnosticsのアイコン指定
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
          },
        },
      })
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'ray-x/lsp_signature.nvim',
    },
  },
}
