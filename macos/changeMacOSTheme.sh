#!/bin/sh

"$HOME/dotfiles/macos/common/colors/chooseTheme.sh" || exit 1

. "$HOME/dotfiles/macos/common/colors/current"

# Change wallpaper
wallpaperFilename=$(readlink -f "$WALLPAPER")
wallpaperScriptPart='tell application "Finder" to set desktop picture to POSIX file'
wallpaperScript="${wallpaperScriptPart} \"${wallpaperFilename}\""
osascript -e "$wallpaperScript"

# Change sketchybar and borders
sketchybar --reload
borders	active_color="$FOREGROUND" inactive_color="$OVERLAY"

