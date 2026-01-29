local M = {}

--- 利用可能なAI Agent CLIコマンドを検出する
--- 環境変数 `HTR_NVIM_AI_CLI` が設定されている場合、その値が最優先される
--- @return string|nil 検出されたCLIコマンド名、または見つからない場合はnil
function M.detect_ai_agent_cmd()
  -- 使用するAI Agent CLI
  local ai_agent_cmd_tbl = {
    "cursor-agent",
    "gemini"
  }

  -- 環境変数 HTR_NVIM_AI_CLI の指定がある場合は優先
  if vim.env.HTR_NVIM_AI_CLI ~= nil then
    table.insert(ai_agent_cmd_tbl, 1, vim.env.HTR_NVIM_AI_CLI)
  end

  local result = nil
  for _, cli in ipairs(ai_agent_cmd_tbl) do
    if vim.fn.executable(cli) == 1 then
      result = cli
      break
    end
  end

  return result
end

return M
