#!/usr/bin/env bash

# "Sxhkd clone for Wayland (works on TTY and X11 too)". "Because swhkd can be
# used anywhere, the same swhkd config can be used across Xorg or Wayland
# desktops, and you can even use swhkd in a TTY."
# (https://github.com/waycrate/swhkd)
swhks &
pkexec swhkd --config "${XDG_CONFIG_DIR:-$HOME/.config}/swhkd/swhkdrc"
