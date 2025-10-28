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

# CUSTOM FUNCTION FOR GIT SP7 COMMANDS
if [[ -d "$HOME/repos/copel/sadm" ]]; then
    gitdef() {
        if [[ $1 == "sp7" ]]; then
            \git "$@" -cfg $HOME/.gitdir/git.xml -trg $HOME/repos/copel --no-afterburn 2>/dev/null
        else
            \git "$@"
        fi
    }
    export PATH=$HOME/repos/copel/sadm/git:$PATH
    alias git=gitdef
fi

gitxml() {
    if [[ $# -eq 0 ]]; then
        vim ~/.gitdir/git.xml
    else
        sed -E "s/ref=\"\S+\"/ref=\"$1\"/" ~/.gitdir/git.xml  > /tmp/git.xml
        mv /tmp/git.xml ~/.gitdir/git.xml
        git sp7 checkoutcfg
    fi
}
