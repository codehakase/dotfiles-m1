return {
	-- Rust: rustaceanvim owns rust_analyzer entirely (do not configure it via lspconfig/mason)
	{
		"mrcjkb/rustaceanvim",
		version = "^9",
		lazy = false,
	},
	-- Haskell: haskell-tools owns hls (do not configure it via lspconfig/mason)
	{
		"mrcjkb/haskell-tools.nvim",
		version = "^9",
		lazy = false,
		init = function()
			vim.g.haskell_tools = {
				tools = {
					codeLens = {
						autoRefresh = false,
					},
				},
				hls = {
					settings = {
						haskell = {
							checkProject = false,
							checkParents = "NeverCheck",
							plugin = {
								importLens = {
									codeLensOn = false,
									inlayHintsOn = false,
								},
								moduleName = {
									globalOn = false,
								},
							},
						},
					},
				},
			}
		end,
	},
	-- Go extras (:GoTest, struct tags, etc.). gopls owns `gd`, so disable vim-go's mapping.
	{
		"fatih/vim-go",
		ft = { "go" },
		init = function()
			vim.g.go_addtags_transform = "camelcase"
			vim.g.go_def_mapping_enabled = 0
		end,
	},
}
