#!/bin/sh

NOTES_DIR="$HOME/notes"
LAST_NOTE_FILE="$HOME/notes/last-note"
EDITOR="nvim"

create_note() {
    filename="$NOTES_DIR/$1.md"
    filename_base=$(basename "$filename")
    if [ -f "$filename" ]; then
        echo "$filename_base already exists"
    else
        echo "Creating a new note called $filename_base"
        touch "$filename"
    fi
}

get_git_branch_and_repo() {
    git rev-parse --is-inside-work-tree > /dev/null 2>&1 || exit 1
    branch=$(git rev-parse --abbrev-ref HEAD)
    repo=$(basename $(git rev-parse --show-toplevel))
    echo "${repo}_${branch}"
}

delete_note() {
    filename="$NOTES_DIR/$1.md"
    filename_base=$(basename "$filename")
    if [ -f "$filename" ]; then
        rm -f "$filename"
        echo "$filename_base removed"
    else
        echo "$filename_base not found"
    fi
}

open_note() {
    filename="$1"
    filename_base=$(basename "$filename")
    if [ ! -f "$filename" ]; then
        echo "No file found: $filename_base"
    fi
    ln -sf "$filename" "$LAST_NOTE_FILE"

    echo "Opening $filename_base"
    "$EDITOR" "$filename"
}

get_last_note() {
    if [ ! -f "$LAST_NOTE_FILE" ]; then
        exit 1
    fi
    readlink -f "$LAST_NOTE_FILE"
}

select_note() {
    find "$NOTES_DIR" -name '*.md' | xargs -I {} basename {} | fzf --height=70% --layout=reverse --preview 'bat -n --color=always '"$NOTES_DIR/"'{}'
}

main() {
    if [ "$#" = 0 ]; then
        echo "No args provided"
        exit 1
    fi

    if [ ! -d "$NOTES_DIR" ]; then
        echo "No $NOTES_DIR directory found, creating a new one"
        mkdir -p "$NOTES_DIR"
    fi

    case "$1" in
        "-c")
            if [ "$#" -lt 2 ]; then
                echo "Note name is missing"
                exit 1
            fi
            create_note "$2" || exit 1
            filename="$NOTES_DIR/$2.md"
            open_note "$filename" || exit 1
            ;;
        "-s")
            selected_note=$(select_note)
            if [ -n "$selected_note" ]; then
                filename="$NOTES_DIR/$selected_note"
                open_note "$filename" || exit 1
            fi
            ;;
        "-l")
            last_note=$(get_last_note) || exit 1
            open_note "$last_note" || exit 1
            ;;
        "-d")
            if [ "$#" -lt 2 ]; then
                echo "Note name is missing"
                exit 1
            fi
            delete_note "$2" || exit 1
            ;;
        "-gc")
            git_branch=$(get_git_branch_and_repo) || exit 1
            create_note "$git_branch" || exit 1
            filename="$NOTES_DIR/$git_branch.md"
            open_note "$filename" || exit 1
            ;;
        *)
            echo "Unknown option"
            exit 1
            ;;
    esac
}

main "$@"
