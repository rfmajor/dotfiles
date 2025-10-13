#!/bin/sh

LAST_QUERY_CACHE="$HOME/.cache/last_fzf_query"
QUICK_FIX_CACHE="$HOME/.cache/quickfix"
RG_PREFIX="rg --column --line-number --smart-case --no-heading --color=always"

SINGLE="SINGLE"
QUICKFIX="QUICKFIX"

choice=$(fzf --bind "start,change:reload:$RG_PREFIX {q} || true" \
    --bind "enter:execute-silent[echo {q} > $LAST_QUERY_CACHE &]+accept" \
    --bind "ctrl-l:clear-query" \
    --bind "ctrl-q:select-all+accept" \
    --multi --ansi --disabled --query "$(cat "$LAST_QUERY_CACHE" 2> /dev/null)")

if [ -z "$choice" ]; then
    exit 1;
fi

if [ "$(echo "$choice" | wc -l)" -gt 1 ]; then
    choice_type="$QUICKFIX"
else
    choice_type="$SINGLE"
fi

if [ "$choice_type" = "$SINGLE" ]; then
    filename=$(echo "$choice" | cut -d ':' -f 1)
    line=$(echo "$choice" | cut -d ':' -f 2)
    col=$(echo "$choice" | cut -d ':' -f 3)

    nvim +"call cursor($line, $col)" "$filename"
else
    echo "$choice" > "$QUICK_FIX_CACHE" &&
    nvim +'cope' -q "$QUICK_FIX_CACHE"
fi

