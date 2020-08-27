#
# ~/.bashrc
#

# If not running interactively, don't do anything
#[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vi='vim'
#PS1='[\u@\h \W]\$ '
cd() {
#  echo "current dir is my dir"
  CURR=`pwd`
  tmux rename-window $CURR
  builtin cd "$1"
}

#PS1="\[\033[32m\]\u\[\033[33m\]:\[\033[32m\]\W\[\033[33m\]# \[\033[0m\]"
PS1='\e[0;33m[\u@\h]\e[0;36m \w #\A\n\$\e[0m '

tmux attach || tmux new
