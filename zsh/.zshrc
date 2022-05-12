# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

source ~/.bash_profile
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export GOROOT=/usr/local/go
export GO111MODULE=on
export GOFLAGS=-mod=mod
export PATH="/opt/homebrew/bin:$PATH"

export HOMEBREW_NO_AUTO_UPDATE=1
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

source $ZSH/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh


# Handle ssh-clients with passphrase
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

# aliases
alias ngrok="~/ngrok"
alias v=/opt/homebrew/bin/nvim
alias dotsy="sh ~/dotfiles/sync.ex"
alias nah="git reset --soft HEAD~1"
alias ga="git add"
alias gs="git status"
alias gaa="git add ."
alias gc="git commit -S -m "
alias gp="git push"
alias gpo="git push orign "
alias tm="tmux -2 -f ~/tmux.conf new -s"
alias ta="tmux attach"
alias td="tmux detach"
alias tk='tmux kill-session -t'
alias ngrok="~/ngrok"
alias t="tail -f"
alias :q="exit"
alias cls="clear"
alias dev="cd ~/Dev/Projects/"
alias tconf="v ~/.tmux.conf"
alias vc="v ~/.config/nvim/init.vim"
alias rb="~/.rbenv/shims/ruby"
alias rs="~/.rbenv/shims/rails"


