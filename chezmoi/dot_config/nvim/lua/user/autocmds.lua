-- Load cmp only when entering Insert mode the first time
vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    require("user.plugins.cmp").setup()
  end,
})

-- Load LSP config when opening/creating files
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = function()
    require("user.plugins.lsp").setup()
  end,
})

-- Go-specific DAP setup
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  once = true,
  callback = function()
    local ok, dapgo = pcall(require, "dap-go")
    if ok then
      dapgo.setup({
        delve = {
          path = "dlv",
          initialize_timeout_sec = 20,
        },
      })
    end
  end,
})

-- Which-key can be initialized on VimEnter / VeryLazy-ish timing
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    require("user.plugins.which-key").setup()
  end,
})