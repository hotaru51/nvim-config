return {
  -- GitHub Copilotの利用に必須
  -- 環境変数 HTR_GH_COPILOT が enabled の場合のみインストール
  {
    'github/copilot.vim',
    cond = (vim.env.HTR_GH_COPILOT == 'enabled'),
  }
}
