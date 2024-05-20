return {
  -- LSPでの入力補完
  {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      -- インストールするプラグイン
      vim.g.coc_global_extensions = {
        'coc-solargraph',
        'coc-pyright',
        'coc-tsserver',
        'coc-html',
        'coc-css',
        'coc-json',
        'coc-yaml',
        'coc-docker',
        'coc-sh',
        'coc-go',
        'coc-cfn-lint',
        'coc-lists',
      }

      -- シンボルハイライト等の表示更新の遅延
      vim.opt.updatetime = 300

      -- statuscolumnを常に1列は表示する
      vim.opt.signcolumn = 'auto:1-9'

      local keyset = vim.keymap.set

      -- 自動補完
      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      -- 補完時のTABキーの動作
      local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
      keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
      keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

      -- 補完の確定
      keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

      -- <c-Space>での補完の実行
      keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

      -- diagnosticsの候補移動
      keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
      keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

      -- 定義元参照等の移動
      keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
      keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
      keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
      keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

      -- ドキュメント参照
      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end
      keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
      keyset("n", "<Leader>h", '<CMD>lua _G.show_docs()<CR>', {silent = true})

      -- カーソル下のシンボルのハイライト
      vim.api.nvim_create_augroup("CocGroup", {})
      vim.api.nvim_create_autocmd("CursorHold", {
        group = "CocGroup",
        command = "silent call CocActionAsync('highlight')",
        desc = "Highlight symbol under cursor on CursorHold"
      })

      -- シンボルのリネーム
      keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

      -- コードのフォーマット
      keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
      keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

      -- ドキュメントのpopup内のスクロール
      local opts = {silent = true, nowait = true, expr = true}
      keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
      keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
      keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
      keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
      keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
      keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

      -- language serverによる範囲選択
      -- textDocument/selectionRangeに対応していること
      keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
      keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})

      -- :Formatでカレントバッファのフォーマット
      vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

      -- :Foldでcocによる折りたたみ
      vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

      -- :ORで現在のバッファのimportを整理
      vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

      local opts = {silent = true, nowait = true}
      -- diagnosticsの一覧表示
      keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)

      -- カレントディレクトリ配下のgrep
      keyset("n", "<space>ll", ":<C-u>CocList grep<cr>", opts)

      -- CocListの再開
      keyset("n", "<space>lp", ":<C-u>CocListResume<cr>", opts)

      -- エラーや警告等のハイライト
      local event = {'VimEnter', 'Colorscheme'}
      vim.api.nvim_create_autocmd(event, {pattern = {'*'}, command = 'hi CocUnderline cterm=underline gui=undercurl'})
      vim.api.nvim_create_autocmd(event, {pattern = {'*'}, command = 'hi CocErrorHighlight ctermfg=125 cterm=underline guifg=#f7768e gui=undercurl'})
      vim.api.nvim_create_autocmd(event, {pattern = {'*'}, command = 'hi CocErrorSign ctermfg=125 guifg=#f7768e'})
      vim.api.nvim_create_autocmd(event, {pattern = {'*'}, command = 'hi CocWarningHighlight ctermfg=130 cterm=underline guifg=#ff9e64 gui=undercurl'})
      vim.api.nvim_create_autocmd(event, {pattern = {'*'}, command = 'hi CocWarningSign ctermfg=130 guifg=#ff9e64'})
      vim.api.nvim_create_autocmd(event, {pattern = {'*'}, command = 'hi CocInfoHighlight cterm=underline gui=undercurl'})
      vim.api.nvim_create_autocmd(event, {pattern = {'*'}, command = 'hi CocHintHighlight cterm=underline gui=undercurl'})
      vim.api.nvim_create_autocmd(event, {pattern = {'*'}, command = 'hi CocHighlightText ctermbg=238 guibg=#525c88'})
    end,
  },
}
