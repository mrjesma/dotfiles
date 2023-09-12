# ENVIRONMENT
export PATH=~/.config/zsh/plugins/diff-so-fancy:$PATH
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=vim

# ALIASES
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias ssh='TERM=xterm-256color ssh'     # to prevent tmux-256color over ssh

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
