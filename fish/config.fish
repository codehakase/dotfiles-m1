source ~/.bashrc

# Path Configuration
set -gx PATH \
    "$HOME/.ghcup/bin" \
    "$HOME/.cabal/bin" \
    "$HOME/.bun/bin" \
    "$HOME/go/bin" \
    "$HOME/.agents/commands" \
    "$HOME/.local/bin" \
    $PATH

# Environment Variables
set -gx EDITOR nvim
set -gx VISUAL nvim

if test -S /Users/talstackstaff/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
    set -x SSH_AUTH_SOCK /Users/talstackstaff/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
end

set --export BUN_INSTALL "$HOME/.bun"
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME

# Interactive Shell
if status is-interactive
    set -g fish_greeting

    set -gx GPG_TTY (tty)
    set -gx MANPAGER 'nvim +Man!'

    # Git
    alias ga="git add"
    alias gs="git status"
    alias gd="git diff"
    alias gaa="git add ."
    alias gc="git commit -S -m "
    alias gp="git push"
    alias gpo="git push origin "
    alias gco="git checkout "
    alias glods='git log --oneline --graph --decorate'
    alias nah="git reset --soft HEAD~1"
    alias up="gp origin HEAD"
    alias upf="gp -f origin HEAD"

    # General
    alias ngrok="$HOME/ngrok"
    alias v=/opt/homebrew/bin/nvim
    alias dotsy="sh $HOME/dotfiles/sync.ex"
    alias t="tail -f"
    alias :q="exit"
    alias cls="clear"
    alias tconf="v $HOME/.config/tmux/tmux.conf"
    alias vc="v $HOME/.config/nvim/init.lua"

    # Ruby/Rails
    alias rb="$HOME/.rbenv/shims/ruby"
    alias rs="$HOME/.rbenv/shims/rails"

    # Tmux
    alias ta="tmux attach -d -t"
    alias td="tmux detach"
    alias tkk='tmux kill-session -t'
    alias tms="tmux-sessionizer"

    # misc
    alias ralph-init="cp $HOME/Dev/personal/experiments/docs/{ralph-loop.sh,progress.txt} ."
end

# Functions
function tm
    tmux -u -2 -f ~/.config/tmux/tmux.conf new -s $argv
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# opencode
fish_add_path /Users/talstackstaff/.opencode/bin

# Added by Antigravity
fish_add_path /Users/talstackstaff/.antigravity/antigravity/bin
