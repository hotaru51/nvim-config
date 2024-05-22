return {
  -- インデントガイドを表示
  'nathanaelkane/vim-indent-guides',
  init = function()
    vim.g.indent_guides_enable_on_vim_startup = 1
    vim.g.indent_guides_guide_size = 1
    vim.g.indent_guides_start_level = 2
    vim.g.indent_guides_auto_colors = 0
  end,
  config = function()
    local event = {'VimEnter', 'Colorscheme'}
    vim.api.nvim_create_autocmd(event, {pattern = {'*'}, command = 'hi IndentGuidesOdd  ctermbg=238 guibg=#3b4261'})
    vim.api.nvim_create_autocmd(event, {pattern = {'*'}, command = 'hi IndentGuidesEven ctermbg=236 guibg=#2b3047'})
  end,
}
