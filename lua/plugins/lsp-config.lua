return {
  -- NeoVimのLSP設定補助プラグイン
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- <Leader>he でdiagnosticをfloatで表示
      vim.keymap.set('n', '<Leader>he', '<CMD>lua vim.diagnostic.open_float(nil, {focus=false})<CR>',
        { noremap = true, silent = true })

      -- diagnosticsのfloatのborderの設定
      vim.diagnostic.config({
        float = { border = "rounded" },
      })

      -- hover表示時のborder設定
      -- vim.lsp.hover()をoverrideするように設定
      local _hover = vim.lsp.buf.hover
      vim.lsp.buf.hover = function(opts)
        opts = opts or {}
        opts.border = opts.border or 'rounded'
        return _hover(opts)
      end

      -- signature_help表示時のborder設定
      -- vim.lsp.signature_help()をoverrideするように設定
      local _signature_help = vim.lsp.buf.signature_help
      vim.lsp.buf.signature_help = function(opts)
        opts = opts or {}
        opts.border = opts.border or 'rounded'
        return _signature_help(opts)
      end

      -- 他のプラグインのUIで問題がでなければ下記でborderを設定する
      -- vim.o.winborder = 'rounded'

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
  },
}
