#!/bin/bash

#specifies which nvim branch to use
nvim_branch="managawa"

function install_package {
	echo $1
	if pacman -Qi $1 > /dev/null; then
		echo "$1 is already installed!"
		return
	else
		echo "installing $1!"
		sudo pacman -S $1 --noconfirm
	fi
}

#alacritty
install_package "alacritty"
cp -rv ./alacritty ~/.config

#neovim
if test -d ./nvim-config; then
	echo "removing existing nvim repo..."
	rm -rf ./nvim-config
fi

echo "cloning nvim repo..."
git clone -b $nvim_branch https://github.com/JustinQM/nvim-config.git
install_package "neovim"
rm -rf ./nvim-config/.git
cp -rv ./nvim-config/* ~/.config/nvim/

#tmux
install_package "tmux"
cp -v ./tmux/tmux.conf ~/.tmux.conf
#install plugin manager
if ! test -d ~/.tmux/plugins/tmp; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

#fzf
install_package "fzf"

#bashrc
cp -v ./bashrc/bashrc ~/.bashrc
