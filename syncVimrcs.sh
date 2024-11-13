#!/usr/bin/bash

# This script is supposed to be run as a pre-commit hook. It processes the 
# set.lua and remap.lua files and produces a traditional .vimrc file 
# as a result, then adds it to the staging area before making the actual commit

ROOT_DIR=$HOME/dotfiles
FILE=$ROOT_DIR/.vimrc
REMAP_REL=nvim/lua/fmajor/remap.lua
REMAP_ABS=$ROOT_DIR/$REMAP_REL
SET_REL=nvim/lua/fmajor/set.lua
SET_ABS=$ROOT_DIR/$SET_REL

echo -e "\" note: this is an autogenerated file\n" > $FILE;

echo -e "\" MAPPINGS (origin: $REMAP_REL)\n" >> $FILE;

# Replacements for remap.lua:
#   replace 'vim.keymap.set' with 'noremap'
#   replace 'vim.g.$VAL' with 'let g:$VAL'
#   replace any leftover lines starting with 'vim' with empty lines
#   replace ' \"' with ' "' (basically deletes the character escapes)
#   replace '--' comments with '"' comments
sed -r \
    -e 's/vim\.keymap\.set\(\"(.)\",\s\"(.+)\",\s\"(.+)\"\)/\1noremap \2 \3/g;'\
    -e 's/vim\.g\.([a-z]+)\s\=\s\"([.\\ ]+)\"/let g:\1 = \"\2\"/g;'\
    -e 's/^vim\..*$//g;'\
    -e 's/\s\\\"/ "/g;'\
    -e 's/--/\"/g;' $REMAP_ABS >> $FILE;

echo -e "\n\n\" SETS (origin: $SET_REL)" >> $FILE;

# Replacements for remap.lua:
#   replace 'vim.opt.$KEY=$VAL' with 'set $KEY=$VAL'
#   replace 'set $VAL=false' with 'set no$VAL'
#   replace '=true' with nothing
#   replace termguicolors line with an empty line (it breaks the colorscheme for default vim)
#   replace any leftover lines starting with 'vim' with empty lines
sed -r \
    -e 's/vim\.opt\.(.+)\s\=\s(.*)/set \1=\2/g;'\
    -e 's/set\s(.+)=false/set no\1/g;'\
    -e 's/\=true//g;'\
    -e 's/^set\stermguicolors$//g;'\
    -e 's/^vim\..*$//g;' $SET_ABS >> $FILE;

cd $ROOT_DIR && git add .vimrc
