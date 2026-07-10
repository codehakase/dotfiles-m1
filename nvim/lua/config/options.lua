local opt = vim.opt

-- UI
opt.relativenumber = true
opt.number = true
opt.diffopt:append("vertical")
opt.colorcolumn = "0"
opt.smarttab = true
opt.mouse = "a"
opt.inccommand = "split"

-- Treesitter-based folding (available but open on file open)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

-- Auto-reload files changed externally
opt.autoread = true

-- Sync clipboard with OS (deferred to keep startup fast)
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)
