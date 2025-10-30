# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%F{red}(%b) '

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%B%F{blue}%~ ${vcs_info_msg_0_}%(?.%F{green}.%F{red})>%f '

# Enable colors
autoload -U colors && colors

# History in cache directory:
if [ ! -f $HOME/.cache/zsh/ ]; then
    mkdir -p $HOME/.cache/zsh
fi

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt SHARE_HISTORY

# Basic autocomplete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Auto cd
setopt autocd

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Edit commands in vi mode
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Use vim keys in tab completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

function find_in_files() {
    $HOME/dotfiles/bin/findInFiles.sh
    zle reset-prompt
}

zle -N find_in_files

bindkey '^F' find_in_files

# bindkey -s '^V' 'vim **^I'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Syntax highlighting
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

export FZF_DEFAULT_COMMAND='fd . --ignore-file $HOME/dotfiles/.fdignore -u --follow' 
export FZF_DEFAULT_OPTS="--layout=reverse --style full --height 100% \
    --preview 'if [ ! -d {} ]; then bat --color=always {} 2> /dev/null; else fd . --color=always --ignore-file $HOME/dotfiles/.fdignore -u --follow --base-directory {}; fi' \
    --preview-window 'top,40%,border-bottom,+{2}+3/3,~3'"
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-m:select-all+accept'"

_fzf_compgen_path() {
    fd . --ignore-file $HOME/dotfiles/.fdignore -u --follow
}

function open_file_for_editing() {
    file="$(fd . -t f --ignore-file "$HOME/dotfiles/.fdignore" -u --follow | fzf)"

    if [ -z "$file" ]; then
        return 1
    fi
    BUFFER="vim ${(q)file}"
    CURSOR=${#BUFFER}
    zle accept-line
}

zle -N open_file_for_editing

bindkey '^V' open_file_for_editing

