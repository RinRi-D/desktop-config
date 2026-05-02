return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        }),
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      { "williamboman/mason-lspconfig.nvim", opts = {} },
      { "WhoIsSethDaniel/mason-tool-installer.nvim", opts = {} },
      { "hrsh7th/cmp-nvim-lsp" },
      { "mfussenegger/nvim-dap" },
      { "leoluz/nvim-dap-go", ft = "go" },
    },
    config = function()
      require("mason").setup()

      require("mason-tool-installer").setup({
        ensure_installed = {
          "gopls",
          "delve",
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = { "gopls" },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

      require("dap-go").setup({
        delve = {
          path = "dlv",
          initialize_timeout_sec = 20,
        },
      })
    end,
  },
}
