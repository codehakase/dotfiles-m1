#!/bin/sh
# Select a dark theme and keep Alacritty in sync with macOS appearance.
# The chosen dark variant is persisted; light appearance uses Gruvbox Light.

themes_dir="$HOME/.config/alacritty/themes"
state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles"
state_file="$state_dir/theme"
default_theme="gruvbox-hard"

valid_theme() {
    case "$1" in
        gruvbox|gruvbox-hard|monochrome) return 0 ;;
        *) return 1 ;;
    esac
}

current_theme() {
    if [ -r "$state_file" ]; then
        theme=$(cat "$state_file")
        if valid_theme "$theme"; then
            printf '%s\n' "$theme"
            return
        fi
    fi
    printf '%s\n' "$default_theme"
}

apply_dark_theme() {
    case "$1" in
        gruvbox) source_theme="gruvbox-dark" ;;
        *) source_theme="$1" ;;
    esac

    cp "$themes_dir/$source_theme.toml" "$themes_dir/current.toml"
}

select_theme() {
    if ! valid_theme "$1"; then
        echo "Unknown theme: $1" >&2
        echo "Available themes: gruvbox, gruvbox-hard, monochrome" >&2
        exit 1
    fi

    apply_dark_theme "$1" || return 1
    mkdir -p "$state_dir" || return 1
    printf '%s\n' "$1" > "$state_file" || return 1
    printf 'Theme: %s\n' "$1"
}

apply_once() {
    if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -qi dark; then
        apply_dark_theme "$(current_theme)"
    else
        cp "$themes_dir/gruvbox-light.toml" "$themes_dir/current.toml"
    fi
}

case "${1:-}" in
    watch)
        exec dark-notify -c "$0"
        ;;
    set)
        [ -n "${2:-}" ] || {
            echo "Usage: $0 set {gruvbox|gruvbox-hard|monochrome}" >&2
            exit 1
        }
        select_theme "$2"
        ;;
    current)
        current_theme
        ;;
    list)
        printf '%s\n' gruvbox gruvbox-hard monochrome
        ;;
    gruvbox|gruvbox-hard|monochrome)
        select_theme "$1"
        ;;
    "")
        apply_once
        ;;
    *)
        echo "Usage: $0 [THEME|set THEME|current|list|watch]" >&2
        exit 1
        ;;
esac
