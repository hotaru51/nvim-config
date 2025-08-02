-- プロジェクトローカルにsolargraphがインストールされている場合はbundler経由で呼び出す
-- See https://github.com/neovim/nvim-lspconfig/issues/1886#issuecomment-1201356197
local solargraph_cmd = function()
  local ret_code = nil
  local jid = vim.fn.jobstart("bundle info solargraph", { on_exit = function(_, data) ret_code = data end })
  vim.fn.jobwait({ jid }, 5000)
  if ret_code == 0 then
    return { "bundle", "exec", "solargraph", "stdio" }
  end
  return { "solargraph", "stdio" }
end

return {
  cmd = solargraph_cmd()
}
