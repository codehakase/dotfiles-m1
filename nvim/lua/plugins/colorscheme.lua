return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      local theme = require("config.theme")
      theme.setup()
      theme.apply(theme.current(), false)
    end,
  },
  -- Automatic dark mode (follows macOS appearance)
  {
    "cormacrelf/dark-notify",
    config = function()
      require("dark_notify").run({
        onchange = function(mode)
          require("config.theme").apply_for_mode(mode)
        end,
      })
    end,
  },
}
