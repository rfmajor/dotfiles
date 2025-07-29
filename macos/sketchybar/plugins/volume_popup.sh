#!/bin/sh

click_timestamp=$(date +%s)
export CLICK_TIMESTAMP="$click_timestamp"

popup_drawing=$(sketchybar --query volume | jq -r '.popup.drawing')

if [ "$popup_drawing" = "off" ]; then
    sketchybar --set volume popup.drawing=on
    sleep 3
    if [ "$CLICK_TIMESTAMP" = "$click_timestamp" ]; then
        sketchybar --set volume popup.drawing=off
    fi
else
    sketchybar --set volume popup.drawing=off
fi

