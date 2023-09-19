# OPTIONS
unsetopt share_history

# ENVIRONMENT
export PATH=~/.config/zsh/plugins/diff-so-fancy:$PATH
export PATH=~/.config/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=vim

# ALIASES
alias ta='tmux attach -t'
alias ts='tmux new-session -s'

# BINDS
bindkey -s ^t 'tmux-sessionizer\n'

# FUNCTIONS
envg() {
    env |grep "$1"
}

psg() {
    ps aux |grep -i "$1" |grep -v grep
}

diff() {
    command diff -u --color=auto "$@" | diff-so-fancy | less --tabs=4 -FRXSi
}
