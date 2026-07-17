return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			keymap = {
				preset = "super-tab",
				["<CR>"] = { "accept", "fallback" },
			},
			completion = {
				ghost_text = { enabled = true },
				menu = { border = "rounded" },
				documentation = { auto_show = true, window = { border = "rounded" } },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			signature = {
				enabled = true,
				window = { border = "rounded" },
			},
			cmdline = {
				enabled = true,
				completion = {
					menu = { auto_show = true },
					list = { selection = { preselect = false, auto_insert = true } },
				},
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			disable_filetype = { "TelescopePrompt" },
		},
	},
}
