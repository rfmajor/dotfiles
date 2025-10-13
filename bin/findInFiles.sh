#!/bin/sh

choice=$(sk -i -c 'rg -Fin "{}" --color=always' --ansi)
if [ -n "$choice" ]; then
    filename=$(echo "$choice" | cut -d ':' -f 1)
    line=$(echo "$choice" | cut -d ':' -f 2)

    nvim +"$line" "$filename"
fi
