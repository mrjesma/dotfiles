#!/usr/bin/env bash
# This script selects a host from a fzf list and ssh to it in a new (or switch to an existing) tmux session.
# Stole and modified from: https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/bin/tmux-sessionizer

IFS=',' read -r description host command <<<"$(cat ~/repos/siemens-env/hosts | fzf --no-sort --cycle --print-query --delimiter ',' --with-nth=1,2 | tail -1)"

[[ -z $description || -z $host ]] && exit 0
[[ -z $command ]] && command="ssh $host"
description="$(echo $description | xargs | tr '[:lower:]' '[:upper:]' | tr ' ' '_')"

tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
	# No tmux server started. Create new session and attach it to it.
	tmux new-session -s "${description}" "${command}"
	exit 0
fi

if ! tmux has-session -t="${description}" 2>/dev/null; then
	# Tmux server is started but no session with name $description. Create new dettached session"
	tmux new-session -ds "${description}" "${command}"
fi

# Switch or attach to existing tmux session with name: $description
if [[ -z $TMUX ]]; then
	tmux attach-session -t "${description}"
else
	tmux switch-client -t "${description}"
fi
