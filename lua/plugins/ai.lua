-- 環境変数 HTR_NVIM_AI の値に応じてcodecompanionのadapterを変更する
local function codecompanion_adapter()
  local mode = vim.env.HTR_NVIM_AI
  local adapter = ""
  if mode == "personal" then
    adapter = "gemini"
  elseif mode == "business" then
    adapter = "copilot"
  end

  return adapter
end

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
    cond = (vim.env.HTR_NVIM_AI == 'business'),
  },

  -- Windsurf(Codeium)の利用に必須
  -- 環境変数 HTR_NVIM_AI が personal の場合のみインストール
  {
    "Exafunction/windsurf.nvim",
    config = function()
      require("codeium").setup({})
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cond = (vim.env.HTR_NVIM_AI == "personal"),
  },

  -- AI ChatやAgent用プラグイン
  {
    "olimorris/codecompanion.nvim",
    opts = {
      strategies = {
        chat = {
          adapter = codecompanion_adapter(),
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
          opts = {
            completion_provider = "cmp",
          },
        },
        inline = {
          adapter = codecompanion_adapter()
        },
        cmd = {
          adapter = codecompanion_adapter()
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
    keys = {
      { '<leader>cc', '<cmd>CodeCompanionChat Toggle<CR>' },
    },
    init = function()
      require("plugins.codecompanion.fidget-spinner"):init()
    end,
    cond = (vim.env.HTR_NVIM_AI == 'personal' or vim.env.HTR_NVIM_AI == 'business'),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "j-hui/fidget.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },
}
