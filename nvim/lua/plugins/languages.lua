return {
  -- Rust: rustaceanvim owns rust_analyzer entirely (do not configure it via lspconfig/mason)
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
  },
  -- Haskell: haskell-tools owns hls (do not configure it via lspconfig/mason)
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^4",
    lazy = false,
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
