return {
  -- GitHub Copilotの利用に必須
  -- 環境変数 HTR_NVIM_AI が enabled の場合のみインストール
  {
    'zbirenbaum/copilot.lua',
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
    cond = (vim.env.HTR_NVIM_AI == 'enabled'),
  },

  -- AI ChatやAgent用プラグイン
  {
    "olimorris/codecompanion.nvim",
    opts = {
      strategies = {
        chat = {
          adapter = "copilot",
          slash_commands = {
            ["buffer"] = {
              opts = {
                provider = "telescope"
              },
            },
            ["file"] = {
              opts = {
                provider = "telescope"
              },
            },
            ["help"] = {
              opts = {
                provider = "telescope"
              },
            },
            ["symbols"] = {
              opts = {
                provider = "telescope"
              },
            },
          },
        },
        inline = {
          adapter = "copilot"
        },
        cmd = {
          adapter = "copilot"
        },
      },
      display = {
        action_palette = {
          provider = "telescope"
        },
      },
      opts = {
        language = "Japanese",
      },
    },
    init = function()
      require("plugins.codecompanion.fidget-spinner"):init()
    end,
    cond = (vim.env.HTR_NVIM_AI == 'enabled'),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "j-hui/fidget.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },
}
