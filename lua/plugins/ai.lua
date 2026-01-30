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
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_tools = true,
            show_server_tools_in_chat = true,
            add_mcp_prefix_to_tool_names = false,
            show_result_in_chat = true,
            format_tool = nil,
            make_vars = true,
            make_slash_commands = true,
          },
        },
      },
      opts = {
        language = "Japanese",
      },
    },
    keys = {
      { '<leader>cc', '<cmd>CodeCompanionChat Toggle<CR>' },
    },
    cond = (vim.env.HTR_NVIM_AI == 'personal' or vim.env.HTR_NVIM_AI == 'business'),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "j-hui/fidget.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },

  -- MCPサーバ連携プラグイン
  {
    "ravitemer/mcphub.nvim",
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup()
    end,
    cond = (vim.env.HTR_NVIM_AI == 'personal' or vim.env.HTR_NVIM_AI == 'business'),
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- AI CLIツール連携
  {
    'lambdalisue/nvim-aibo',
    config = function()
      require('aibo').setup()

      local helpers = require('utils.helpers')

      -- AI Agent CLIが見つかった場合はAiboを呼び出すキーマップを設定
      local agent_cmd = helpers.detect_ai_agent_cmd()
      if agent_cmd ~= nil then
        vim.keymap.set("n", "<Leader>ti", function()
          local width = math.floor(vim.o.columns * 0.3)
          vim.cmd(string.format("Aibo -toggle -opener='botright %dvsplit' %s", width, agent_cmd))
        end, { noremap = true })
      end
    end,
  }
}
