-- Quick escape from insert mode
vim.keymap.set("i", "jk", "<Esc>")

-- Diagnostics to quickfix
vim.keymap.set("n", "<leader>qd", function()
  vim.diagnostic.setqflist()
end, { desc = "[Q]uickfix [D]iagnostics" })
