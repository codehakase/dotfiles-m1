return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "go",
        "lua",
        "haskell",
        "typescript",
        "html",
        "css",
        "javascript",
        "rust",
        "c",
        "zig",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
