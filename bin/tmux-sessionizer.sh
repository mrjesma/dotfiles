#!/usr/bin/env bash
# This script selects a host from a fzf list and ssh to it in a new (or switch to an existing) tmux session.
#
# Stole and modified from: https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/bin/tmux-sessionizer

if [[ $# -eq 1 ]]; then
  selected_name=$(echo ${1^^} | cut -d '@' -f2)
  selected=$1
  host=$1
else
  selected=$(cat ~/repos/siemens-env/hosts | fzf --no-sort)
  echo $selected
  selected_name=$(echo $selected |awk -F'|' '{print $1}' |sed 's/ $//' |sed 's/ /_/g')
  host=$(echo $selected |awk -F'|' '{print $2}')
fi

if [[ -z $selected ]]; then
  exit 0
fi

tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  # No tmux server started. Create new session and attach it to it.
  tmux new-session -s $selected_name "ssh $host"
  exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
  # Tmux server is started but no session with name $selected_name. Create new dettached session"
  tmux new-session -ds $selected_name "ssh $host"
fi

# Switch or attach to existing tmux session with name: $selected_name
if [[ -z $TMUX ]]; then
  tmux attach-session -t $selected_name
else
  tmux switch-client -t $selected_name
fi
