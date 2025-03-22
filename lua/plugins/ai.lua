return {
  -- GitHub Copilotの利用に必須
  -- 環境変数 HTR_GH_COPILOT が enabled の場合のみインストール
  {
    'zbirenbaum/copilot.lua',
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
    cond = (vim.env.HTR_GH_COPILOT == 'enabled'),
  },
}
