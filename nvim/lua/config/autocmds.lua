local autocmd = vim.api.nvim_create_autocmd

-- Auto-reload files when changed externally
autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  pattern = { "*" },
  command = "if mode() != 'c' | checktime | endif",
})

-- Close all buffers except the current one
vim.api.nvim_create_user_command("Qo", "%bd|e#|bd#", { desc = "Close all buffers except current" })
