#!/bin/sh

# Set Session Name
SESSION="artiq_workspace"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

# Only create tmux session if it doesn't already exist
if [ "$SESSIONEXISTS" = "" ]
then
    tmux new-session -d -s $SESSION

    tmux rename-window -t 0 'artiq'
    tmux split-window -t 0 -h
    tmux split-window -t 1 -v -l "33%"
    tmux split-window -t 1 -v -l "50%"
    tmux send-keys -t 0 'cd ~/artiq; $EDITOR .' C-m
    tmux send-keys -t 1 'cd ~/artiq; nix develop' C-m
    tmux send-keys -t 2 'cd ~/artiq; clear' C-m
    tmux send-keys -t 3 'cd ~/artiq; clear' C-m
    tmux selectp -t 0

    tmux new-window -t $SESSION:1 -n 'artiq-zynq'
    tmux split-window -t 0 -h
    tmux split-window -t 1 -v -l "33%"
    tmux split-window -t 1 -v -l "50%"
    tmux send-keys -t 0 'cd ~/artiq-zynq; $EDITOR .' C-m
    tmux send-keys -t 1 'cd ~/zynq-rs; nix develop' C-m
    tmux send-keys -t 2 'cd ~/artiq-zynq; nix develop' C-m
    tmux send-keys -t 3 'cd ~/artiq-zynq; clear' C-m
    tmux selectp -t 0
    
    tmux new-window -t $SESSION:2 -n 'nac3'
    tmux split-window -t 0 -h
    tmux split-window -t 1 -v -l "33%"
    tmux split-window -t 1 -v -l "50%"
    tmux send-keys -t 0 'cd ~/nac3; $EDITOR .' C-m
    tmux send-keys -t 1 'cd ~/nac3; clear' C-m
    tmux send-keys -t 2 'cd ~/nac3; clear' C-m
    tmux send-keys -t 3 'cd ~/nac3; clear' C-m
    tmux selectp -t 0
fi

# Attach Session, on the Main window
tmux attach-session -t $SESSION:0
