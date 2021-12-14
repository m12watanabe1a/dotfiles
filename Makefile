.PHONY: config

bin_dir = $(HOME)/.local/bin

config: 
	./config/install.sh

install: tmux nvim

tmux:
	./install/tmux/install.sh
	mv ./install/tmux/temp/tmux $(bin_dir)

nvim:
	./install/nvim/install.sh
	mv ./install/nvim/temp/nvim $(bin_dir)


