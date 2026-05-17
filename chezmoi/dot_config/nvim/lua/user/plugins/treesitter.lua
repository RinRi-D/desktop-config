local M = {}

pcall(function()
  require("nvim-treesitter").setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
  })

  require("nvim-treesitter").install({ "go", "cpp" })
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'go', 'cpp', 'c', 'h' },
    callback = function() vim.treesitter.start() end,
  })
end)

return M
