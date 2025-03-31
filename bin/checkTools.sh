#!/usr/bin/zsh

TOOLS_FILE=tools
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)

# Checks if the cmd tool is installed
# args: 1:tool
check_installed() {
    printf "$1 "
    if which "$1" &> /dev/null; then
        printf "\xE2\x9C\x85\n"
    else
        printf "\xE2\x9D\x8C\n"
    fi
}

setup_yazi() {
    if [ ! -d $HOME/.config/yazi ]; then
        printf "%8s" "Creating the config folder"
        mkdir -p $HOME/.config/yazi
    fi
    ln -s $HOME/dotfiles/yazi.toml $HOME/.config/yazi/yazi.toml
}

setup_git() {
    git config --global include.path $HOME/dotfiles/.gitconfig
    git config --local core.hooksPath .githooks/
}

setup_tmux() {
    echo "source-file $HOME/dotfiles/.tmux.conf" >> ~/.tmux.conf
}

check_setup() {
    check_installed "$1"
    case "$1" in
        fzf)
            ;;
        fd)
            ;;
        nvim)
            ;;
        yazi)
            if [ ! -f "$HOME/.config/yazi/yazi.toml" ]; then
                printf "%4s" "${RED}No config file found${NORMAL}"
                if [ "$2" == "-y" ]; then
                    setup_yazi
                fi
            fi
            ;;
        git)
            ;;
        tmux)
            ;;
        zsh)
            ;;
        rg)
            ;;
        zoxide)
            ;;
        i3)
            ;;
        *)
            ;;
    esac
}

for tool in $(awk -F, '{print $1}' "${TOOLS_FILE}"); do
    check_installed "$tool"
done
