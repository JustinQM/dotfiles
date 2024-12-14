#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
#todo: make color not always default blue
export PS1="\[\033[38;5;85m\]\u@\h\[$(tput sgr0)\][\w]\\$ \[$(tput sgr0)\]"

alias vim="nvim"
alias vi="nvim"
alias v="nvim"

alias t="tmux"
alias tm="tmux"

alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

#load fzf keybinds
eval "$(fzf --bash)"
