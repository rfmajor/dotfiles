#!/bin/sh

. "$HOME/dotfiles/macos/common/colors/current"

NETWORK=$(ipconfig getsummary "$(networksetup -listallhardwareports | awk '/Wi-Fi|AirPort/{getline; print $NF}')" | grep '  SSID : ' | awk -F ': ' '{print $2}')
if [ "$NETWORK" = "" ]; then
    ICON="󰖪 "
    NETWORK="No connection"
    COLOR="$ACCENT"
else
    ICON="󰖩 "
    COLOR="$FOREGROUND"
fi

sketchybar --set "$NAME" icon="$ICON" label="$NETWORK" icon.color="$COLOR"
