#!/bin/bash

RUNNING=$(tmux list-sessions 2>&1)

if [[ $RUNNING == "no server running"* ]];
	then tmux
else
	tmux a
fi
