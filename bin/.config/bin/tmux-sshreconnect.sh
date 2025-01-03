#!/usr/bin/env bash
# Reconnect to current stuck ssh session

# Get current active pane pid and id
current_pane_pid=$(tmux list-panes -F "#{pane_active} #{pane_pid}" |grep '^1' |awk '{print $2}')
current_pane_id=$(tmux list-panes -F "#{pane_active} #{pane_id}" |grep '^1' |awk '{print $2}')

# Get pid ssh command
while read -r cmd; do
  if [[ "$cmd" =~ ^(auto)?ssh ]]; then
    command=$cmd
  fi
done < <(ps -o command= -g ${current_pane_pid})

# Get hostname
host=$($command -G |grep "^hostname" |awk '{print $2}')

if [[ -z $host ]]; then
 exit 0
fi

# New window
tmux new-window "ssh $host; $SHELL"

# Swap panes and kill old one
tmux swap-pane -t $current_pane_id
tmux kill-pane -t $current_window_index
