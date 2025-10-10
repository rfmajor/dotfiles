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
bindkey -s '^F' '$HOME/dotfiles/bin/findInFiles.sh\n'

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

