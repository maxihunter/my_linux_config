#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

cd() {
#  echo "current dir is my dir"
  builtin cd "$1"
  CURR=`pwd`
  tmux rename-window $CURR
}

alias vi='vim'
PS1='\e[0;33m[\u@\h]\e[0;36m \w #\A\n\$\e[0m '
tmux attach || tmux
CURR=`pwd`
tmux rename-window $CURR
HISTFILE=/tmp/.bash_history
