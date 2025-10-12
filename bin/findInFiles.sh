#!/bin/sh

choice=$(sk -i -c 'rg -in "{}" --color=always' --ansi)
if [ -n "$choice" ]; then
    filename=$(echo "$choice" | cut --delimiter ':' --fields 1)
    line=$(echo "$choice" | cut --delimiter ':' --fields 2)

    nvim +"$line" "$filename"
fi
