#!/bin/bash
set -e

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
