# OPTIONS
unsetopt share_history

# ENVIRONMENT
export PATH=~/.config/zsh/plugins/diff-so-fancy:$PATH
export PATH=~/.config/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=vim

# CUSTON ENVIRONMENT
if [[ -d ~/repos/siemens-env/siscon ]]; then
    set -a
    source ~/repos/siemens-env/siscon
    set +a
fi

# ALIASES
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias navip='navi --print |tee >(clip.exe)'
alias navic='navi --print --cheatsh'
alias ls='ls -F --color=auto'
alias ll='ls -laF --color=auto'
alias vim='nvim'
alias v='nvim'

# BINDS
bindkey -s ^t 'tmux-sessionizer.sh\n'

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

git-sp7() {
    /home/ajunior/repos/copel-d_adms_sp2/sadm/git/git-sp7 "$@" -cfg /home/ajunior/.gitdir/git.xml -trg /home/ajunior/repos/copel-d_adms_sp2
}

