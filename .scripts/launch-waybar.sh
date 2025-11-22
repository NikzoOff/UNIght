#!/bin/bash
# launch-waybar.sh - Launch waybar with selected style

CONFIG_DIR="$HOME/.config/waybar/styles"
CACHE_FILE="$HOME/.cache/waybar-style-choice"

# Read saved choice, default to "default" if none exists
if [ -f "$CACHE_FILE" ]; then
    STYLE=$(cat "$CACHE_FILE")
else
    STYLE="default"
fi

# Set config and style paths based on selection
case "$STYLE" in
    "line")
        CONFIG="$CONFIG_DIR/line.jsonc"
        STYLE_FILE="$CONFIG_DIR/line.css"
        ;;
    "default")
        CONFIG="$CONFIG_DIR/config.jsonc"
        STYLE_FILE="$CONFIG_DIR/style.css"
        ;;
    "bottom")
        CONFIG="$CONFIG_DIR/bottom.jsonc"
        STYLE_FILE="$CONFIG_DIR/bottom.css"
        ;;
    "vertical"|*)
        CONFIG="$CONFIG_DIR/vertical.jsonc"
        STYLE_FILE="$CONFIG_DIR/vertical.css"
        ;;
esac

# Verify files exist
if [ ! -f "$CONFIG" ]; then
    notify-send "Waybar Error" "Config not found: $CONFIG" -u critical
    exit 1
fi

if [ ! -f "$STYLE_FILE" ]; then
    notify-send "Waybar Error" "Style not found: $STYLE_FILE" -u critical
    exit 1
fi

# Launch waybar with selected config and style
waybar -c "$CONFIG" -s "$STYLE_FILE" &
