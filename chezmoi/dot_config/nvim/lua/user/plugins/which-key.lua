local M = {}

function M.setup()
  local ok, wk = pcall(require, "which-key")
  if not ok then
    return
  end

  wk.setup({})
end

return M