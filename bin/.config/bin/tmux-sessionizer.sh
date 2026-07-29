#!/usr/bin/env bash
# This script selects a host from a fzf list and ssh to it in a new (or switch to an existing) tmux session.
# Stole and modified from: https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/bin/tmux-sessionizer

IFS=',' read -r DESCRIPTION HOST COMMAND <<<"$(fzf --ansi --no-sort --cycle --print-query --delimiter ',' --with-nth '{1} - {2}' < ~/repos/siemens-env/hosts | tail -1)"

[[ -z $DESCRIPTION || -z $HOST ]] && exit 0
[[ -z $COMMAND ]] && COMMAND="ssh $HOST"

if [[ $COMMAND == *"&" ]]; then
	eval "$COMMAND"
	exit 0
fi

DESCRIPTION="$(echo $DESCRIPTION | sed 's/\x1b\[[0-9;]*m//g' | xargs | tr '[:lower:]' '[:upper:]' | tr ' ' '_')"

tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
	# No tmux server started. Create new session and attach it to it.
	tmux new-session -s "${DESCRIPTION}" "${COMMAND}"
	exit 0
fi

if ! tmux has-session -t="${DESCRIPTION}" 2>/dev/null; then
	# Tmux server is started but no session with name $DESCRIPTION. Create new dettached session"
	tmux new-session -ds "${DESCRIPTION}" "${COMMAND}"
fi

# Switch or attach to existing tmux session with name: $DESCRIPTION
if [[ -z $TMUX ]]; then
	tmux attach-session -t "${DESCRIPTION}"
else
	tmux switch-client -t "${DESCRIPTION}"
fi
