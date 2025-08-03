#!/bin/sh

popup_drawing=$(sketchybar --query wifi | jq -r '.popup.drawing')

if [ "$popup_drawing" = "off" ]; then
    sketchybar --set wifi popup.drawing=on
else
    sketchybar --set wifi popup.drawing=off
fi
