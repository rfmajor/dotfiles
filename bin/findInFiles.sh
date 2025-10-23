#!/bin/sh

LAST_QUERY_CACHE="$HOME/.cache/last_fzf_query"
CACHE_EXPIRY_SECONDS=60
QUICK_FIX_CACHE="$HOME/.cache/quickfix"
RG_PREFIX="rg --column --line-number --smart-case --no-heading --hidden --color=always"

SINGLE="SINGLE"
QUICKFIX="QUICKFIX"

get_cached_query() {
    query_with_timestamp=$(cat "$LAST_QUERY_CACHE" 2> /dev/null)
    if [ -z "$query_with_timestamp" ]; then
        echo ""
        return 0
    fi

    current_timestamp=$(date +%s)
    query=$(echo "$query_with_timestamp" | cut -d ',' -f 1)
    timestamp=$(echo "$query_with_timestamp" | cut -d ',' -f 2)
    if [ $((current_timestamp - timestamp)) -gt "$CACHE_EXPIRY_SECONDS" ]; then
        echo "" > "$LAST_QUERY_CACHE"
        echo ""
        return 0
    fi
    echo "$query"
}

choice=$(fzf --bind "start,change:reload:$RG_PREFIX {q} || true" \
    --bind "enter:execute-silent[echo {q},\$(date +%s) > $LAST_QUERY_CACHE &]+accept" \
    --bind "ctrl-l:clear-query" \
    --bind "ctrl-q:select-all+execute-silent[echo {q},\$(date +%s) > $LAST_QUERY_CACHE &]+accept" \
    --color "hl:-1:underline,hl+:-1:underline:reverse" \
    --delimiter ':' \
    --preview "$RG_PREFIX {q} | bat --color=always {1} --highlight-line {2} 2> /dev/null" \
    --preview-window 'top,40%,border-bottom,+{2}+3/3,~3' \
    --multi --ansi --disabled --query "$(get_cached_query)")

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

