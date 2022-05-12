#!/bin/bash

# ZSH
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH/plugins/zsh-autocomplete

# Download vim plug
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
	curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Sync nvimrc file
if [ ! -d $HOME/.config/nvim ]; then
	mkdir -p $HOME/.config/nvim
	ln -s $PWD/neovim/init.vim $HOME/.config/nvim/init.vim
else
	if [ ! -e $HOME/.config/nvim/init.vim ]; then
		rm $HOME/.config/nvim/init.vim
	fi
	ln -s $PWD/neovim/init.vim $HOME/.config/nvim/init.vim
fi

# Sync Coc config
if [ ! -e $HOME/.config/nvim/coc-settings.json ]; then
  rm $HOME/.config/nvim/coc-settings.json
fi
ln -s $PWD/config/coc-settings.json $HOME/.config/nvim/coc-settings.json

# Sync tmux config
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" --quiet
	if ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
		tmux source-file "$HOME/.tmux.conf"
	fi
fi

# Sync and load tmux config
if [ ! -e $HOME/.tmux.conf ]; then
  ln -s $PWD/tmux/.tmux.conf $HOME/.tmux.conf
fi
