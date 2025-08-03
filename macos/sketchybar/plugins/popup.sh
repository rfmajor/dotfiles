#!/bin/sh

TIMESTAMP_FILE="$HOME/dotfiles/macos/sketchybar/plugins/${1}_popup_timestamp"
click_timestamp=$(date +%s)
echo "$click_timestamp" > "$TIMESTAMP_FILE"

popup_drawing=$(sketchybar --query "$1" | jq -r '.popup.drawing')

if [ "$popup_drawing" = "off" ]; then
    sketchybar --set "$1" popup.drawing=on
    sleep 3
    CLICK_TIMESTAMP=$(cat "$TIMESTAMP_FILE")
    if [ "$CLICK_TIMESTAMP" = "$click_timestamp" ]; then
        sketchybar --set "$1" popup.drawing=off
    fi
else
    sketchybar --set "$1" popup.drawing=off
fi
