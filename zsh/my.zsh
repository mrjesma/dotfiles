# ENVIRONMENT
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=vim

# ALIASES
alias ta='tmux attach -t'
alias ts='tmux new-session -s'

# FUNCTIONS
envg() {
    env |grep "$1"
}

psg() {
    ps aux |grep -i "$1" |grep -v grep
}

