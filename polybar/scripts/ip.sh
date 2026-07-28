#!/bin/bash
if xdotool search --name "Network Info:" >/dev/null 2>&1; then
    # The app is open, tell i3 to close it
    i3-msg "[title=\"Network Info:\"] kill"
else
    ~/.config/polybar/scripts/ip.py
fi
