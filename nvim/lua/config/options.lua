local opt = vim.opt

-- UI
opt.relativenumber = true
opt.number = true
opt.diffopt:append("vertical")
opt.colorcolumn = "0"
opt.smarttab = true
opt.mouse = "a"
opt.inccommand = "split"
opt.scrolloff = 8

-- Show diagnostic messages inline
vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = false,
	underline = true,

	virtual_text = {
		spacing = 2,
		source = "if_many",
		prefix = "●",
	},

	float = {
		border = "rounded",
		source = "if_many",
	},

	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "E",
			[vim.diagnostic.severity.WARN] = "W",
			[vim.diagnostic.severity.INFO] = "I",
			[vim.diagnostic.severity.HINT] = "H",
		},
	},
})

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

-- Persistent undo
opt.undofile = true

-- Case-insensitive search unless uppercase is used
opt.ignorecase = true
opt.smartcase = true

-- Predictable split placement
opt.splitright = true

-- Prevent text shifting when signs appear
opt.signcolumn = "yes"

-- Faster CursorHold and plugin feedback
opt.updatetime = 250

-- Faster mapped-key feedback
opt.timeoutlen = 400

-- Sync clipboard with OS (deferred to keep startup fast)
vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)
