vim.keymap.set("n", "<leader>r", ":set relativenumber!<CR>", {
  desc = "Toggle relative line numbers",
})

vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

vim.keymap.set("n", "<F5>", function()
  require("dap").continue()
end, { desc = "DAP Continue" })

vim.keymap.set("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "DAP Step Over" })

vim.keymap.set("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "DAP Step Into" })

vim.keymap.set("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "DAP Step Out" })

vim.keymap.set("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "DAP Toggle Breakpoint" })

vim.keymap.set("n", "<leader>dr", function()
  require("dap").repl.open()
end, { desc = "DAP REPL" })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
