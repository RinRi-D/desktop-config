local M = {}

function M.setup()
  local ok_mason, mason = pcall(require, "mason")
  local ok_mti, mti = pcall(require, "mason-tool-installer")
  local ok_mlsp, mlsp = pcall(require, "mason-lspconfig")
  local ok_cmp_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

  if ok_mason then
    mason.setup()
  end

  if ok_mti then
    mti.setup({
      ensure_installed = {
        "gopls",
        "delve",
      },
    })
  end

  if ok_mlsp then
    mlsp.setup({
      ensure_installed = { "gopls" },
    })
  end

  local capabilities = nil
  if ok_cmp_lsp then
    capabilities = cmp_nvim_lsp.default_capabilities()
  end

  vim.lsp.config("gopls", {
    capabilities = capabilities,
    settings = {
      gopls = {
        gofumpt = true,
        staticcheck = true,
        analyses = {
          unusedparams = true,
          nilness = true,
          unusedwrite = true,
          useany = true,
        },
      },
    },
  })

  vim.lsp.enable("gopls")

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local opts = { buffer = args.buf, silent = true }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    end,
  })
end

return M