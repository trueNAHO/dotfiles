#!/usr/bin/env bash

# Set keyboard layout to 'us' (XServer).
setxkbmap -layout us
# Swap 'Control' and 'Caps_Lock' and set new 'Caps_Lock' to 'Hyper' (XServer).
setxkbmap -option 'ctrl:swapcaps_hyper'

redshift & pid_redshift=$!

# Start window manager
awesome

# Kill processes once window manager is closed
kill $pid_redshift
