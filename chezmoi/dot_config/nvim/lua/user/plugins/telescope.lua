local M = {}

pcall(function()
  local telescope = require("telescope")
  telescope.setup({})

  pcall(telescope.load_extension, "fzf")
end)


return M
