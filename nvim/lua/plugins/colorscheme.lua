return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "",
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  -- Automatic dark mode (follows macOS appearance)
  {
    "cormacrelf/dark-notify",
    config = function()
      require("dark_notify").run()
    end,
  },
}
