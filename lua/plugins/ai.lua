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

  -- AI ChatやAgent用プラグイン
  {
    "olimorris/codecompanion.nvim",
    opts = {
      strategies = {
        chat = {
          adapter = "copilot"
        },
        inline = {
          adapter = "copilot"
        },
        agent = {
          adapter = "copilot"
        },
      },
    },
    cond = (vim.env.HTR_GH_COPILOT == 'enabled'),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
