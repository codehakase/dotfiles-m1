-- Quick escape from insert mode
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>n", "<CMD>nohlsearch<CR>")

-- Diagnostics to quickfix
vim.keymap.set("n", "<leader>qd", function()
	vim.diagnostic.setqflist()
end, { desc = "[Q]uickfix [D]iagnostics" })

-- splits
vim.keymap.set("n", "<leader>v", "<CMD>vsplit<CR>")
vim.keymap.set("n", "<leader>h", "<CMD>split<CR>")
