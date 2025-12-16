# HISTORY
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# ENVIRONMENT
export PATH=~/.config/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=vim

# ALIASES
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias navip='navi --print |tee >(clip.exe)'
alias navic='navi --print --cheatsh'
alias ls='ls -F --color=auto'
alias ll='ls -laF --color=auto'
alias vim='nvim'
alias v='nvim'

# KEY BIND
bind -x '"\C-t":"tmux-sessionizer.sh"'

# FUNCTIONS
envg() {
    env |grep "$1"
}

psg() {
    ps aux |grep -i "$1" |grep -v grep
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

# LOAD STARSHIP
eval "$(starship init bash)"
