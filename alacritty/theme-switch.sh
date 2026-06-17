#!/bin/sh
# Swap Alacritty's imported theme to match macOS appearance.
# Copies the matching theme over themes/current.toml; Alacritty live-reloads.

themes_dir="$HOME/.config/alacritty/themes"

set_theme() {
    # $1 = "dark" or "light"
    cp "$themes_dir/gruvbox-$1.toml" "$themes_dir/current.toml"
}

apply_once() {
    if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -qi dark; then
        set_theme dark
    else
        set_theme light
    fi
}

# With no args: apply current state once and exit.
# With "watch": follow appearance changes via dark-notify.
if [ "$1" = "watch" ]; then
    exec dark-notify -c "$0"
else
    apply_once
fi
