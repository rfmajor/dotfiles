#!/bin/sh

choice=$(sk -i -c 'rg -n "{}" --color=always' --ansi)
if [ -n "$choice" ]; then
    filename=$(echo "$choice" | cut --delimiter ':' --fields 1)
    line=$(echo "$choice" | cut --delimiter ':' --fields 2)

    nvim +"$line" "$filename"
fi
