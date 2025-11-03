set -gx PATH "$HOME/.ghcup/bin" $PATH
set -gx PATH "$HOME/.cabal/bin" $PATH
set -x SSH_AUTH_SOCK /Users/ops/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

source ~/.bashrc

export GPG_TTY=$(tty)
export MANPAGER='nvim +Man!'

alias ngrok="~/ngrok"
alias v=/opt/homebrew/bin/nvim
alias dotsy="sh $HOME/dotfiles/sync.ex"
alias nah="git reset --soft HEAD~1"
alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias gaa="git add ."
alias gc="git commit -S -m "
alias gp="git push"
alias gpo="git push origin "
alias gco="git checkout "
alias glods='git log --oneline --graph --decorate'
alias tm="tmux -u -2 -f ~/.config/tmux/tmux.conf new -s"
alias ta="tmux attach -d -t"
alias td="tmux detach"
alias tk='tmux kill-session -t'
alias tms="tmux-sessionizer"
alias ngrok="~/ngrok"
alias t="tail -f"
alias :q="exit"
alias cls="clear"
alias tconf="v $HOME/.config/tmux/tmux.conf"
alias vc="v $HOME/.config/nvim/init.lua"
alias rb="~/.rbenv/shims/ruby"
alias rs="~/.rbenv/shims/rails"
alias up="gp origin HEAD"
alias upf="gp -f origin HEAD"
if status is-interactive
    # Commands to run in interactive sessions can go here
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set -gx PATH $HOME/.agents/commands $PATH
