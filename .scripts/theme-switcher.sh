#!/bin/bash

# Format: "display_name|wallust_theme_name"
themes=(
    "  Tokyo Night|Tokyo-Night"
    "󰗜  Gruvbox Dark|Gruvbox-Material-Dark"
    " Nord|Nord"
    "󰄛  Catppuccin|Catppuccin-Mocha"
    "  Solarized|solarized-dark"
    "󰭟  Monokai|monokai"
    "󱢗  Everforest|Everforest-Dark-Medium"
)

# Map: wallust theme -> nvchad theme
declare -A nvchad_map=(
    ["Tokyo-Night"]="tokyonight"
    ["Gruvbox-Material-Dark"]="gruvbox"
    ["Nord"]="nord"
    ["Catppuccin-Mocha"]="catppuccin"
    ["solarized-dark"]="solarized_dark"
    ["monokai"]="monekai"
    ["Everforest-Dark-Medium"]="everforest"
)


# Get list of theme names (display names only)
theme_list=$(printf '%s\n' "${themes[@]}" | cut -d'|' -f1)

# Show rofi menu and get selection
selected=$(echo "$theme_list" | rofi -dmenu -i -p "Select Color Scheme")
# Exit if nothing selected
[[ -z "$selected" ]] && exit 0

# Find the matching wallust theme name
wallust_theme=""
for theme in "${themes[@]}"; do
    display_name="${theme%%|*}"
    theme_name="${theme##*|}"
    if [[ "$display_name" == "$selected" ]]; then
        wallust_theme="$theme_name"
        break
    fi
done

# If no match found, exit
if [[ -z "$wallust_theme" ]]; then
    echo "❌ Error: Theme not found" | rofi -dmenu -p "Error"
    exit 1
fi

# Check if wallust is installed
if ! command -v wallust &> /dev/null; then
    echo "❌ Error: wallust is not installed" | rofi -dmenu -p "Error"
    exit 1
fi

# Apply the theme using wallust
wallust theme "$wallust_theme"

nvchad_theme="${nvchad_map[$wallust_theme]}"

if [[ -z "$nvchad_theme" ]]; then
    echo "❌ NvChad theme not mapped for '$wallust_theme'" | rofi -dmenu -p "Error"
    exit 1
fi

# Path to your init.lua (modifier si ce n’est pas ce fichier)
NVCHAD_INIT="$HOME/.config/nvim/init.lua"

# Replace the theme line inside init.lua
sed -i "s|require(\"nvconfig\").base46.theme = '.*'|require(\"nvconfig\").base46.theme = '$nvchad_theme'|" "$NVCHAD_INIT"

gsettings set org.gnome.desktop.interface gtk-theme "$nvchad_theme"
pywalfox update
pkill waybar && ~/.scripts/launch-waybar.sh
