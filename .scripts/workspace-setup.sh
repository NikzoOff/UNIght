#!/bin/bash

chosen=$(printf "Work\nChill" | rofi -dmenu -p "Workspace setup:")

case "$chosen" in
  "Work")
    swaymsg "workspace 1; exec firefox"
    swaymsg "workspace 1; exec obsidian"
    swaymsg "workspace 2; exec foot -e rmpc"
    swaymsg "workspace 4; exec foot -e tmux"
    ;;
  "Chill")
    swaymsg "workspace 1; exec firefox"
    swaymsg "workspace 2; exec foot -e rmpc"
    ;;
  *) exit 0 ;;
esac
