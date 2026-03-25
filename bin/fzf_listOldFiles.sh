#!/bin/bash

# Script to list recent files and open nvim using fzf
# set to an alias nlof in .zshrc

list_oldfiles() {
    # Get the oldfiles list from Neovim
    local oldfiles=($(nvim -u NONE --headless +'lua io.write(table.concat(vim.v.oldfiles, "\n") .. "\n")' +qa))
    # Filter invalid paths or files not found
    local valid_files=()
    for file in "${oldfiles[@]}"; do
        if [[ -f "$file" ]]; then
            valid_files+=("$file")
        fi
    done
    # Use fzf to select from valid files
    local file=$(printf "%s\n" "${valid_files[@]}" | \
        grep -v '\[.*' | fzf)

    echo "$file"

}

# Call the function
list_oldfiles "$@"
