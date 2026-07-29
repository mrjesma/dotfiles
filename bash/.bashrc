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
alias gcm='git commit -m'

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

# COLOR MAN PAGES
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33;44m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;1;32m'
export LESS_TERMCAP_mr=$'\e[7m'
export LESS_TERMCAP_mh=$'\e[2m'
export LESS_TERMCAP_ZN=$'\e[74m'
export LESS_TERMCAP_ZV=$'\e[75m'
export LESS_TERMCAP_ZO=$'\e[73m'
export LESS_TERMCAP_ZW=$'\e[75m'
export GROFF_NO_SGR=1
export MANPAGER='less'
#export MANPAGER='nvim +Man!'
#export MANPAGER='bat -plman'

