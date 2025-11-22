#!/bin/bash
# waybar-chooser.sh - Interactive waybar style selector

CONFIG_DIR="$HOME/.config/waybar/styles/"
CACHE_FILE="$HOME/.cache/waybar-style-choice"
STYLES=("default" "line" "bottom" "vertical")
LAUNCHER="rofi -dmenu -i -p 'Select Waybar Style'"
CHOICE=$(printf '%s\n' "${STYLES[@]}" | eval $LAUNCHER)

if [ -z "$CHOICE" ]; then
    exit 0
fi

if [[ ! " ${STYLES[@]} " =~ " ${CHOICE} " ]]; then
    notify-send "Waybar Chooser" "Invalid selection: $CHOICE" -u critical
    exit 1
fi

echo "$CHOICE" > "$CACHE_FILE"

notify-send "Waybar Style" "Selected: $CHOICE - Restarting waybar." -t 3000 &
pkill waybar &
sleep 0.5 &
bash "$HOME/.scripts/launch-waybar.sh"
