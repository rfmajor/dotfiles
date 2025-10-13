#!/bin/sh

LAST_QUERY_CACHE="$HOME/.cache/last_fzf_query"
RG_PREFIX="rg --column --line-number --smart-case --no-heading --color=always"

choice=$(fzf --bind "start,change:reload:$RG_PREFIX {q} || true" \
    --bind "enter:execute-silent[echo {q} > $LAST_QUERY_CACHE &]+accept" \
    --ansi --disabled --query "$(cat "$LAST_QUERY_CACHE" 2> /dev/null)")

if [ -n "$choice" ]; then
    filename=$(echo "$choice" | cut -d ':' -f 1)
    line=$(echo "$choice" | cut -d ':' -f 2)
    col=$(echo "$choice" | cut -d ':' -f 3)

    nvim +"call cursor($line, $col)" "$filename"
fi
