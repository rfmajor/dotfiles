#!/bin/sh

. "$HOME/dotfiles/common/themes/current"

NETWORK=$(system_profiler SPAirPortDataType | awk '/Current Network/ {getline;$1=$1; gsub(":",""); print;exit}')
# Not working recently
# NETWORK=$(ipconfig getsummary "$(networksetup -listallhardwareports | awk '/Wi-Fi|AirPort/{getline; print $NF}')" | grep '  SSID : ' | awk -F ': ' '{print $2}')
if [ "$NETWORK" = "" ]; then
    ICON="󰖪 "
    NETWORK="No connection"
    COLOR="$ACCENT"
else
    ICON="󰖩 "
    COLOR="$FOREGROUND"
fi

sketchybar --set "$NAME" icon="$ICON" label="$NETWORK" icon.color="$COLOR"

#speedtest=$(speedtest --json)
#if [ -z "$speedtest" ]; then
#    download="--"
#    upload="--"
#else
#    download=$(echo "$speedtest" | jq '.download')
#    upload=$(echo "$speedtest" | jq '.upload')
#
#    download=$(echo "$download" | cut -d '.' -f 1 | tr -d '\n')
#    upload=$(echo "$upload" | cut -d '.' -f 1 | tr -d '\n')
#
#    download=$(($download / 1000000))
#    upload=$(($upload / 1000000))
#fi
#
#sketchybar --set "${NAME}_popup_download" label="$download Mb/s"
#sketchybar --set "${NAME}_popup_upload" label="$upload Mb/s"
