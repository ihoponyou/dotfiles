#!/bin/bash

TAGS=(
    "CLASS"
    "WORK"
    "WASTE" 
    "STOP"
)

selected=$(printf "%s\n" "${TAGS[@]}" | tofi)
picker_status=$?

if [[ $picker_status -ne 0 || -z "$selected" ]]; then
    exit 0
fi

tmux set -g status-interval 5

if [[ "$selected" == "STOP" ]]; then
    timew stop
    tmux set -g status-right ""
else
    timew start "$selected"
    tmux set -g status-right "#(timew | awk '/Total/{print \$NF}')#[bg=black,fg=white,bold] $selected "
fi
