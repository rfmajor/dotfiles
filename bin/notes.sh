#!/bin/sh

NOTES_DIR="$HOME/notes"
LAST_NOTE_FILE="$HOME/notes/last-note"
EDITOR="nvim"

init_git_repo() {
    cd "$NOTES_DIR" || return 1
    git init
    echo "$(basename "$LAST_NOTE_FILE")" >> .gitignore
    git add .
    git commit -m "Initial commit"
}

# args: 1 - message
commit_update() {
    cd "$NOTES_DIR" || return 1
    git add . > /dev/null 2>&1 
    git commit -m "$1" > /dev/null 2>&1 
}

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
    filename="$NOTES_DIR/$1"
    filename_base=$(basename "$filename")
    if [ -f "$filename" ]; then
        rm -f "$filename"
        echo "$filename_base removed"
        return 0
    else
        echo "$filename_base not found"
        return 1
    fi
}

edit_note() {
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
        echo ""
    else
        readlink -f "$LAST_NOTE_FILE"
    fi
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

    if [ ! -d "$NOTES_DIR/.git" ]; then
        echo "No git repo found under $NOTES_DIR, initializing a new one"
        init_git_repo
    fi

    case "$1" in
        "-c")
            if [ "$#" -lt 2 ]; then
                printf "Note name: " >&2
                read -r note_name
                if [ -z "$note_name" ]; then
                    echo "Note name is mandatory"
                    exit 1
                fi
            else
                note_name="$2"
            fi
            create_note "$note_name" || exit 1
            filename="$NOTES_DIR/$note_name.md"
            edit_note "$filename" || exit 1
            commit_update "Create $(basename "$filename")"
            ;;
        "-s")
            selected_note=$(select_note)
            if [ -n "$selected_note" ]; then
                filename="$NOTES_DIR/$selected_note"
                edit_note "$filename" || exit 1
                commit_update "Update $(basename "$filename")"
            fi
            ;;
        "-l")
            last_note=$(get_last_note) || exit 1
            if [ -z "$last_note" ]; then
                echo "No last note found (maybe it was deleted?)"
                exit 1
            fi
            edit_note "$last_note" || exit 1
            commit_update "Update $(basename "$last_note")"
            ;;
        "-d")
            if [ "$#" -lt 2 ]; then
                echo "Select note to delete: "
                selected_note=$(select_note)
            else
                selected_note="$2.md"
            fi
            if [ -z "$selected_note" ]; then
                exit 1
            fi
            delete_note "$selected_note" || exit 1
            commit_update "Delete $(basename "$selected_note")"
            ;;
        "-gc")
            git_branch=$(get_git_branch_and_repo) || exit 1
            create_note "$git_branch" || exit 1
            filename="$NOTES_DIR/$git_branch.md"
            edit_note "$filename" || exit 1
            commit_update "Create $(basename "$filename")"
            ;;
        *)
            echo "Unknown option"
            exit 1
            ;;
    esac
}

main "$@"
