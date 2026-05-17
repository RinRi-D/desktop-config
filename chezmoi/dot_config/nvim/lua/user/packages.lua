vim.pack.add({
  -- UI
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/catppuccin/nvim", version = "v1.10.0" },

  -- Completion
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },

  -- LSP / DAP / tooling
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/williamboman/mason.nvim" },
  { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/leoluz/nvim-dap-go" },

  -- Telescope
  { src = "https://github.com/nvim-telescope/telescope.nvim", version = "v0.2.2" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },

  -- Treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },

  -- Oil file manager
  { src = "https://github.com/stevearc/oil.nvim" }
})

-- Load plugin configs
require("user.plugins.lualine")
require("user.plugins.which-key")
require("user.plugins.cmp")
require("user.plugins.lsp")
require("user.plugins.telescope")
require("user.plugins.treesitter")
require("user.plugins.oil")
