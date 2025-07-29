#!/usr/bin/env bash

. "$HOME/dotfiles/macos/common/colors/current"

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set "$NAME" background.color="$ACCENT" drawing=on
    exit 0
else
    sketchybar --set "$NAME" background.drawing=off
fi

if [ -z "$(aerospace list-windows --workspace "$1")" ]; then
    sketchybar --set "$NAME" drawing=off
else
    sketchybar --set "$NAME" drawing=on
fi
