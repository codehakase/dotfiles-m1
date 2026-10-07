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

-- navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Move current line up/down in Normal mode
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })

-- Move current line up/down in Insert mode
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })

-- Move selected block up/down in Visual mode
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- git ops
vim.keymap.set("n", "<leader>g", "<CMD>Gitsigns toggle_current_line_blame<CR>")
