vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.list = true
vim.opt.listchars = "tab:>-,trail:~,extends:>,precedes:<"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes:1"
vim.opt.scrolloff = 8
vim.opt.showcmd = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase =true

vim.opt.termguicolors = true

vim.opt.showmode = false

local dap = require("dap")

vim.keymap.set("n", "<F5>", function()
  dap.continue()
end, { desc = "DAP Continue" })

vim.keymap.set("n", "<F10>", function()
  dap.step_over()
end, { desc = "DAP Step Over" })

vim.keymap.set("n", "<F11>", function()
  dap.step_into()
end, { desc = "DAP Step Into" })

vim.keymap.set("n", "<F12>", function()
  dap.step_out()
end, { desc = "DAP Step Out" })

vim.keymap.set("n", "<leader>db", function()
  dap.toggle_breakpoint()
end, { desc = "DAP Toggle Breakpoint" })

vim.keymap.set("n", "<leader>dr", function()
  dap.repl.open()
end, { desc = "DAP REPL" })
