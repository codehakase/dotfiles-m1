return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local languages = {
      "go", "lua", "haskell", "typescript", "html",
      "css", "javascript", "rust", "c", "zig",
    }

    require("nvim-treesitter").install(languages)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = languages,
      callback = function()
        vim.treesitter.start()

        local language = vim.treesitter.language.get_lang(vim.bo.filetype) or vim.bo.filetype
        if vim.treesitter.query.get(language, "indents") then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
