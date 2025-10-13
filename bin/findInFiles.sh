#!/bin/sh

choice=$(sk -i -c 'rg -in "{}" --color=always' --ansi)
if [ -n "$choice" ]; then
    filename=$(echo "$choice" | cut -d ':' -f 1)
    line=$(echo "$choice" | cut -d ':' -f 2)

    nvim +"$line" "$filename"
fi
