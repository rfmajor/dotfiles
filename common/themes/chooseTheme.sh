#!/bin/sh

THEMES_FILE="$HOME/dotfiles/common/themes/themes.json"
CURRENT_THEME_FILE="$HOME/dotfiles/common/themes/current"

theme=$(jq -r ".[].name" "$THEMES_FILE" |
    fzf --height=70% --layout=reverse)

if [ -z "$theme" ]; then
    exit 1
fi

echo "THEME_NAME=\"$theme\"" >"$CURRENT_THEME_FILE"
jq -r --arg name "$theme" '.[] | select(.name == $name) | .colors | to_entries[] | "\(.key | ascii_upcase)=\"\(.value)\""' \
    "$THEMES_FILE" >> "$CURRENT_THEME_FILE"

wallpaper=$(jq -r --arg name "$theme" '.[] | select(.name == $name) | .wallpaper' "$THEMES_FILE")
echo "WALLPAPER=$wallpaper" >> "$CURRENT_THEME_FILE"

barIconFont=$(jq -r --arg name "$theme" '.[] | select(.name == $name) | .barIconFont' "$THEMES_FILE")
barLabelFont=$(jq -r --arg name "$theme" '.[] | select(.name == $name) | .barLabelFont' "$THEMES_FILE")
echo "BAR_ICON_FONT=\"$barIconFont\"" >> "$CURRENT_THEME_FILE"
echo "BAR_LABEL_FONT=\"$barLabelFont\"" >> "$CURRENT_THEME_FILE"
