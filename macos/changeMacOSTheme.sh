#!/bin/sh

"$HOME/dotfiles/common/themes/chooseTheme.sh" || exit 1

. "$HOME/dotfiles/common/themes/current"

# Change wallpaper
wallpaperFilename=$(readlink -f "$WALLPAPER")
wallpaperScriptPart='tell application "System Events" to tell every desktop to set picture to'
wallpaperScript="${wallpaperScriptPart} \"${wallpaperFilename}\""
osascript -e "$wallpaperScript"

# Change sketchybar and borders
sketchybar --reload
borders	active_color="$FOREGROUND" inactive_color="$OVERLAY"

