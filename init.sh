#!/bin/bash
set -e

# Install Rex keybindings, preserving any different config on this machine.
rex_source="$(cd "$(dirname "$0")" && pwd)/rex/init.lua"
rex_config="$HOME/.config/rex/init.lua"
mkdir -p "$(dirname "$rex_config")"
if [[ ! "$rex_config" -ef "$rex_source" ]]; then
  if [[ -e "$rex_config" || -L "$rex_config" ]]; then
    echo "Keeping existing $rex_config. Merge it with $rex_source to use the dotfiles version." >&2
  else
    ln -s "$rex_source" "$rex_config"
  fi
fi

# Symlink config dirs into ~/.config
ln -s $PWD/nvim $HOME/.config/
ln -s $PWD/fish $HOME/.config/
ln -s $PWD/ghostty $HOME/.config/
ln -s $PWD/tmux $HOME/.config/
ln -s $PWD/alacritty $HOME/.config/

# --- Alacritty auto light/dark theme switching (macOS) ---
# Requires: brew install dark-notify
# Generate the active theme file from the current macOS appearance.
"$PWD/alacritty/theme-switch.sh"

# Install + load the LaunchAgent that watches appearance changes.
# NOTE: the plist hardcodes /Users/talstackstaff paths. If your username
# differs, edit com.talstackstaff.alacritty-theme.plist first.
mkdir -p "$HOME/Library/LaunchAgents"
ln -sf "$PWD/alacritty/com.talstackstaff.alacritty-theme.plist" \
  "$HOME/Library/LaunchAgents/com.talstackstaff.alacritty-theme.plist"
launchctl load "$HOME/Library/LaunchAgents/com.talstackstaff.alacritty-theme.plist"

# NOTE: neovim V0.12.4+ requires: brew install tree-sitter-cli
