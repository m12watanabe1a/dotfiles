.PHONY: config

bin_dir = $(HOME)/.local/bin

install: tmux nvim fzf

config: 
	./config/install.sh

tmux:
	./install/tmux/install.sh
	mv ./install/tmux/temp/tmux $(bin_dir)

nvim:
	./install/nvim/install.sh
	mv ./install/nvim/temp/nvim $(bin_dir)

vimplug:
	./install/vimplug/install.sh

fzf:
	./install/fzf/install.sh

