local M = {}

local variants = { "gruvbox", "gruvbox-hard", "monochrome" }
local default_variant = "gruvbox-hard"
local state_home = vim.env.XDG_STATE_HOME or vim.fn.expand("~/.local/state")
local state_file = state_home .. "/dotfiles/theme"
local switcher = vim.fn.expand("~/.config/alacritty/theme-switch.sh")

local function valid(name)
  return vim.tbl_contains(variants, name)
end

local function configure_gruvbox(hard)
  local config = { contrast = "" }
  if hard then
    config = {
      contrast = "hard",
      palette_overrides = {
        dark0_hard = "#000000",
      },
    }
  end

  require("gruvbox").setup(config)
end

function M.current()
  local file = io.open(state_file, "r")
  if not file then
    return default_variant
  end

  local name = vim.trim(file:read("*a"))
  file:close()
  return valid(name) and name or default_variant
end

function M.apply(name, sync_terminal)
  if not valid(name) then
    vim.notify("Unknown theme: " .. name, vim.log.levels.ERROR)
    return false
  end

  vim.o.background = "dark"
  if name == "monochrome" then
    vim.cmd.colorscheme("monochrome")
  else
    configure_gruvbox(name == "gruvbox-hard")
    vim.cmd.colorscheme("gruvbox")
  end

  if sync_terminal ~= false then
    local output = vim.fn.system({ switcher, "set", name })
    if vim.v.shell_error ~= 0 then
      vim.notify(vim.trim(output), vim.log.levels.ERROR)
      return false
    end
  end

  if sync_terminal ~= false then
    vim.notify("Theme: " .. name)
  end
  return true
end

function M.apply_for_mode(mode)
  if mode == "light" then
    vim.o.background = "light"
    configure_gruvbox(false)
    vim.cmd.colorscheme("gruvbox")
    return
  end

  M.apply(M.current(), false)
end

function M.setup()
  vim.api.nvim_create_user_command("Theme", function(opts)
    if opts.args == "" then
      vim.notify("Theme: " .. M.current())
      return
    end
    M.apply(opts.args, true)
  end, {
    nargs = "?",
    complete = function()
      return variants
    end,
    desc = "Show or switch the shared Neovim and terminal theme",
  })
end

return M
