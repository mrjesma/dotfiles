#!/usr/bin/env bash
# This script will open a ssh tunnel to the current ssh connection hostname from our local gitlab server

# Get current active pane pid
current_pane_pid=$(tmux list-panes -F "#{pane_active} #{pane_pid}" |grep '^1' |awk '{print $2}')

# Get pid ssh command
while read -r cmd; do
  if [[ "$cmd" =~ ^(auto)?ssh ]]; then
    command=$cmd
  fi
done < <(ps -o command= -g ${current_pane_pid})

# Get hostname
host=$($command -G |grep "^hostname" |awk '{print $2}')

# Debug
#echo "Pane_PID: $current_pane_pid"
#echo "SSH_Command: $command"
#echo "Hostname: $host"

if [[ -z $host ]]; then
 exit 0
fi

tmux new-window "ssh -tt ccneobr 'ssh -R 8888:localhost:80 $host'"
