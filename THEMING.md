# Auto Light/Dark Theming (macOS)

How Alacritty, tmux, and Neovim all follow the macOS system appearance
(System Settings → Appearance → **Auto**) at the same time.

Everything is built on [`dark-notify`](https://github.com/cormacrelf/dark-notify),
a small macOS helper that runs a command whenever the system flips between
light and dark.

```
                 macOS appearance (Auto)
                          │
          ┌───────────────┼────────────────┐
          ▼               ▼                ▼
   dark-notify       tmux-dark-notify   dark-notify.nvim
 (LaunchAgent)         (TPM plugin)      (lazy plugin)
          │               │                │
          ▼               ▼                ▼
   theme-switch.sh   sources tmux-      sets vim.o.background
   rewrites          {light,dark}.conf   + colorscheme
   themes/current.toml
          │
          ▼
   Alacritty live-reloads colors
```

## Prerequisites

```sh
brew install dark-notify
```

(Also needed elsewhere: Homebrew, Alacritty, tmux + TPM, Neovim. Font:
JetBrainsMono Nerd Font.)

## One-time setup on a new machine

```sh
git clone <this repo> ~/dotfiles
cd ~/dotfiles
./init.sh          # symlinks configs + installs the Alacritty theme LaunchAgent
```

`init.sh` does, for the theming bits:

1. Symlinks `alacritty/` → `~/.config/alacritty`.
2. Runs `alacritty/theme-switch.sh` once to generate `themes/current.toml`
   from the current appearance.
3. Symlinks and `launchctl load`s the LaunchAgent that watches for changes.

> **Different username?** The LaunchAgent plist
> (`alacritty/com.talstackstaff.alacritty-theme.plist`) hardcodes
> `/Users/talstackstaff` paths. Edit it before running `init.sh` if your
> macOS username differs.

For tmux and Neovim, theming comes from their plugins, so installing those
plugins is enough:

- **tmux**: `tmux-dark-notify` (TPM). Run `prefix + I` to install. Config in
  `tmux/tmux.conf` points at `tmux/tmux-light.conf` and `tmux/tmux-dark.conf`.
- **Neovim**: `dark-notify` plugin (managed by lazy.nvim, see
  `nvim/lazy-lock.json`). Installs automatically on first launch.

## How each piece works

### Alacritty
- `alacritty/alacritty.toml` imports `themes/current.toml` via
  `[general] import`.
- `themes/current.toml` is a **machine-generated copy** of either
  `gruvbox-dark.toml` or `gruvbox-light.toml`. It is gitignored.
- `theme-switch.sh` reads `defaults read -g AppleInterfaceStyle` and copies the
  right palette over `current.toml`. Alacritty live-reloads (no restart).
- The LaunchAgent runs `theme-switch.sh watch`, which execs
  `dark-notify -c theme-switch.sh` so the swap happens on every appearance
  change and at login.

### tmux
- `tmux-dark-notify` sources `tmux-light.conf` / `tmux-dark.conf` on change.
- These only style the status bar / borders — the pane background passes
  through to Alacritty (`window-style` is left at `default`).

### Neovim
- The `dark-notify` Lua plugin sets `vim.o.background` and the colorscheme to
  match, live, while nvim is running.

## Verifying / troubleshooting

```sh
# Is the Alacritty watcher running?
launchctl list | grep alacritty
pgrep -fl theme-switch.sh

# What palette is active right now?
head -1 ~/.config/alacritty/themes/current.toml

# Manually re-apply current appearance
~/.config/alacritty/theme-switch.sh

# Validate the Alacritty config
/Applications/Alacritty.app/Contents/MacOS/alacritty migrate --dry-run \
  -c ~/.config/alacritty/alacritty.toml
```

- **Alacritty background looks like default dark, not Gruvbox**: the import
  didn't apply — fully quit (`Cmd+Q`) and reopen Alacritty once.
- **Nothing switches**: confirm `dark-notify` is installed and System Settings →
  Appearance is set to **Auto**.
- **Reload the LaunchAgent** after editing the plist:
  ```sh
  launchctl unload ~/Library/LaunchAgents/com.talstackstaff.alacritty-theme.plist
  launchctl load   ~/Library/LaunchAgents/com.talstackstaff.alacritty-theme.plist
  ```
